import asyncio
import os
from typing import Any

import aiofiles
from aiohttp.client import ClientSession
from pathvalidate import sanitize_filename

AUTH_TOKEN = os.getenv("DISCORD_TOKEN")
if not AUTH_TOKEN:
    raise Exception("Discord auth token not found in env vars (DISCORD_TOKEN).")

HEADERS = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:130.0) Gecko/20100101 Firefox/130.0",
    "Authorization": AUTH_TOKEN,
}
DISCORD_API = "https://discord.com/api/v10/{}"
GUILD_ID = None  # from which guild do you wanna download emojis from. set it to None it download em from all
EXCLUDE_GUILDS = []
SKIP_ANIMATED_EMOJIS = True
EMOJI_SIZE = None  # max
EMOJI_NAME_FORMATE = "{guild}_{name}"
CONCURRENT_DOWNLOADS_LIMIT = 15


async def fetch_user_guilds(session: ClientSession) -> dict[str, str]:
    url = DISCORD_API.format("users/@me/guilds")
    async with session.get(url) as resp:
        _guilds = await resp.json()
        guilds = {guild["id"]: guild["name"] for guild in _guilds}
        return guilds


async def fetch_guild_emojis(
    session: ClientSession, guild_id: str
) -> list[dict[str, Any]]:
    url = DISCORD_API.format(f"guilds/{guild_id}/emojis")
    async with session.get(url) as resp:
        return await resp.json()


async def download_emoji(
    session: ClientSession,
    sema: asyncio.Semaphore,
    url: str,
    guild_name: str,
    name: str,
):
    async with sema:
        async with session.get(url) as resp:
            file_name = sanitize_filename(
                f"{EMOJI_NAME_FORMATE.format(guild=guild_name, name=name)}.{url.split('.')[-1]}"
            )
            async with aiofiles.open(file_name, "wb") as f:
                await f.write(await resp.read())
            print(f"Downloaded: {name}")


async def fetch_guild_name(session: ClientSession, g_id: str) -> dict[str, str]:
    url = DISCORD_API.format(f"guilds/{g_id}")
    async with session.get(url) as resp:
        guild = await resp.json()
        return guild["name"]


async def main():
    async with ClientSession(headers=HEADERS) as session:
        sema = asyncio.Semaphore(CONCURRENT_DOWNLOADS_LIMIT)
        guilds = (
            {GUILD_ID: await fetch_guild_name(session, GUILD_ID)}
            if GUILD_ID
            else await fetch_user_guilds(session)
        )
        all_emojis: list[dict[str, Any]] = []
        for g_id, g_name in guilds.items():
            if g_id in EXCLUDE_GUILDS:
                continue

            emojis = await fetch_guild_emojis(session, g_id)
            for emoji in emojis:
                if emoji["animated"] and SKIP_ANIMATED_EMOJIS:
                    continue
                emoji["url"] = (
                    f"https://cdn.discordapp.com/emojis/{emoji['id']}.{'gif' if emoji['animated'] else 'webp'}"
                )
                emoji["guild_name"] = g_name
                all_emojis.append(emoji)

        tasks = [
            download_emoji(
                session, sema, emoji["url"], emoji["guild_name"], emoji["name"]
            )
            for emoji in all_emojis
        ]

        await asyncio.gather(*tasks)


if __name__ == "__main__":
    asyncio.run(main())
