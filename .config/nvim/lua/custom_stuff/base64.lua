-- Helper function to get text based on mode
local function get_text(mode)
    if mode == "normal" then
        local line = vim.fn.getline('.')
        local col = vim.fn.col('.')
        local start_col, end_col = col, col
        
        -- Base64 can contain A-Z, a-z, 0-9, +, /, and = for padding
        local base64_pattern = '[A-Za-z0-9+/=]'
        
        -- Search backwards for the start of the base64 string
        while start_col > 0 and line:sub(start_col - 1, start_col - 1):match(base64_pattern) do
            start_col = start_col - 1
        end
        
        -- Search forwards for the end of the base64 string
        while end_col <= #line and line:sub(end_col, end_col):match(base64_pattern) do
            end_col = end_col + 1
        end
        
        return line:sub(start_col, end_col - 1)
    else
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
        local lines = vim.fn.getline(start_pos[2], end_pos[2])
        local selected_text = ""
        
        if start_pos[2] == end_pos[2] then
            selected_text = lines[1]:sub(start_pos[3], end_pos[3])
        else
            selected_text = lines[1]:sub(start_pos[3])
            for i = 2, #lines - 1 do
                selected_text = selected_text .. "\n" .. lines[i]
            end
            selected_text = selected_text .. "\n" .. lines[#lines]:sub(1, end_pos[3])
        end
        return selected_text
    end
end

-- Helper function to set text based on mode
local function set_text(mode, new_text)
    if mode == "normal" then
        local line = vim.fn.getline('.')
        local col = vim.fn.col('.')
        local start_col, end_col = col, col
        
        -- Base64 can contain A-Z, a-z, 0-9, +, /, and = for padding
        local base64_pattern = '[A-Za-z0-9+/=]'
        
        -- Search backwards for the start of the base64 string
        while start_col > 0 and line:sub(start_col - 1, start_col - 1):match(base64_pattern) do
            start_col = start_col - 1
        end
        
        -- Search forwards for the end of the base64 string
        while end_col <= #line and line:sub(end_col, end_col):match(base64_pattern) do
            end_col = end_col + 1
        end
        
        -- Replace newlines with spaces in normal mode
        new_text = new_text:gsub("\n", " ")
        
        -- Update the line with the new text
        local updated_line = line:sub(1, start_col - 1) .. new_text .. line:sub(end_col)
        vim.fn.setline('.', updated_line)
    else
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
        local lines = vim.fn.getline(start_pos[2], end_pos[2])
        
        if start_pos[2] == end_pos[2] then
            local updated_line = lines[1]:sub(1, start_pos[3] - 1) .. new_text .. lines[1]:sub(end_pos[3] + 1)
            vim.fn.setline(start_pos[2], updated_line)
        else
            -- When encoding, join all lines into one with spaces
            if not new_text:match("\n") then
                local updated_line = lines[1]:sub(1, start_pos[3] - 1) .. new_text
                vim.fn.setline(start_pos[2], updated_line)
                -- Delete the rest of the lines in the selection
                if end_pos[2] > start_pos[2] then
                    vim.cmd(string.format('%d,%dd', start_pos[2] + 1, end_pos[2]))
                end
            else
                -- When decoding and result has newlines
                local result_lines = vim.split(new_text, "\n", true)
                local updated_first_line = lines[1]:sub(1, start_pos[3] - 1) .. result_lines[1]
                vim.fn.setline(start_pos[2], updated_first_line)
                
                -- Delete existing lines in selection
                if end_pos[2] > start_pos[2] then
                    vim.cmd(string.format('%d,%dd', start_pos[2] + 1, end_pos[2]))
                end
                
                -- Insert the rest of the lines
                for i = 2, #result_lines do
                    vim.fn.append(start_pos[2] + i - 1, result_lines[i])
                end
            end
        end
    end
end

-- Main encoding function
function encode_base64(mode)
    mode = mode or vim.api.nvim_get_mode().mode
    local text = get_text(mode)
    local encoded = vim.base64.encode(text)
    set_text(mode, encoded)
end

-- Main decoding function
function decode_base64(mode)
    mode = mode or vim.api.nvim_get_mode().mode
    local text = get_text(mode)
    
    -- Add error handling for decoding
    local status, decoded = pcall(function()
        return vim.base64.decode(text)
    end)
    
    if status then
        set_text(mode, decoded)
    else
        vim.api.nvim_err_writeln("Error: Invalid base64 input")
    end
end

-- Set up mappings for both normal and visual mode
vim.api.nvim_set_keymap("n", "<leader>be", ":lua encode_base64('normal')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bd", ":lua decode_base64('normal')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>be", ":lua encode_base64('visual')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>bd", ":lua decode_base64('visual')<CR>", { noremap = true, silent = true })
