local if_nil = vim.F.if_nil

local default_terminal = {
    type = "terminal",
    command = nil,
    width = 69,
    height = 8,
    opts = {
        redraw = true,
        window_config = {},
    },
}

local default_header = {
    type = "text",
    val = {
        [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠻⠂⣠⣶⣿⣿⣶⣦⣤⣤⣤⣤⡄⢀⣾⣿⣿⣿⣿⣷⣄⡀⣤⣶⣤⠀⠀⠀]],
        [[⠀⠀⠀⡴⠟⠛⠋⠙⠻⢿⣿⣿⠿⠿⠀⣾⣿⣿⣿⣿⣿⠉⣿⣿⡿⢿⣿⣧⠀⠀]],
        [[⠀⠀⠀⢀⣀⣤⣴⠾⠒⠀⠉⣠⣴⡆⠀⠋⠁⠀⠀⠉⠁⠐⠉⠁⠀⠀⠀⠉⠂⠀]],
        [[⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⢸⣿⡟⠀⠲⠶⢶⣶⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⢀⣤⣤⣤⣤⣤⡀⢀⣠⡾⣿⣿⣦⣀⣀⣀⣀⣀⣀⡀⠀⣠⣶⣶⣦⣴⣶⣦⠀]],
        [[⠀⠈⠉⠁⠀⠈⠻⠃⠀⠁⠀⠀⠉⠙⠛⠻⠿⣿⣿⣿⠁⢈⣡⣄⠀⠁⣠⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣾⣿⣿⣯⣤⣴⠏⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⠿⠿⠿⠟⠉⠁⠀⠀⠀⠀⠀]],
    },
    opts = {
        position = "center",
        hl = "Title",
    },
}

local phrases = {
    "It's not a bug, it's a feature.",
    "Debugging is like being a detective.",
    "Simplicity is key.",
    "Guidelines are suggestions.",
    "Programming is hard.",
    "Code never lies.",
    "There's no place like 127.0.0.1.",
    "Booleans are off by a bit.",
    "Don't comment bad code.",
    "If it ain't broke, it doesn't have enough features yet.",
    "Real programmers don't sleep.",
    "Drink coffee >> sleep >> reapeat."
}

math.randomseed(os.time())
local phrase = phrases[math.random(#phrases)]

local footer = {
    type = "text",
    val = phrase,
    opts = {
        position = "center",
        hl = "Text",
    },
}

local leader = "C"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local nvim_config_path = "/home/" .. os.getenv("USER") .. "/.config/nvim/"

local buttons = {
    type = "group",
    val = {
        button("n", "  New File", "<cmd>ene<CR>"),
        button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
        button("f", "  Find File", "<cmd>Telescope find_files<CR>"),
        button("p", "  Projects", "<cmd>Telescope projects<CR>"),
        button("c", "  Config", "<cmd>edit " .. nvim_config_path .. " <CR>"),
        button("q", "  Quit", "<cmd>q<CR>"),
    },
    opts = {
        spacing = 1,
    },
}

local section = {
    terminal = default_terminal,
    header = default_header,
    buttons = buttons,
    footer = footer,
}

local config = {
    layout = {
        { type = "padding", val = 2 },
        section.header,
        { type = "padding", val = 2 },
        section.buttons,
        section.footer,
    },
    opts = {
        margin = 5,
    },
}

return {
    button = button,
    section = section,
    config = config,
    -- theme config
    leader = leader,
    -- deprecated
    opts = config,
}
