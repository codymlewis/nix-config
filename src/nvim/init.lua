do
    -- Specifies where to install/use rocks.nvim
    local install_location = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "rocks")

    -- Set up configuration options related to rocks.nvim (recommended to leave as default)
    local rocks_config = {
        rocks_path = vim.fs.normalize(install_location),
    }

    vim.g.rocks_nvim = rocks_config

    -- Configure the package path (so that plugin code can be found)
    local luarocks_path = {
        vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
        vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
    }
    package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

    -- Configure the C path (so that e.g. tree-sitter parsers can be found)
    local luarocks_cpath = {
        vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
        vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
    }
    package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

    -- Add rocks.nvim to the runtimepath
    vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))
end

-- If rocks.nvim is not installed then install it!
if not pcall(require, "rocks") then
    local rocks_location = vim.fs.joinpath(vim.fn.stdpath("cache") --[[@as string]], "rocks.nvim")

    if not vim.uv.fs_stat(rocks_location) then
        -- Pull down rocks.nvim
        local url = "https://github.com/nvim-neorocks/rocks.nvim"
        vim.fn.system({ "git", "clone", "--filter=blob:none", url, rocks_location })
        -- Make sure the clone was successfull
        assert(vim.v.shell_error == 0, "rocks.nvim installation failed. Try exiting and re-entering Neovim!")
    end

    -- If the clone was successful then source the bootstrapping script
    vim.cmd.source(vim.fs.joinpath(rocks_location, "bootstrap.lua"))

    vim.fn.delete(rocks_location, "rf")
end

vim.o.history = 500
vim.o.autoread = true
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
    pattern = { '*' },
    callback = function()
        vim.api.nvim_command [[checktime]]
    end,
    group = vim.api.nvim_create_augroup("Detect file changes", { clear = true }),
})

vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.magic = true
vim.o.wildmenu = true
vim.o.background = 'dark'
vim.o.encoding = 'utf8'
vim.o.swapfile = false
vim.o.title = true
vim.o.splitright = true
vim.o.splitbelow = true

vim.wo.number = true
vim.wo.lbr = true
vim.wo.wrap = true

vim.bo.tabstop = 8
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.undofile = true

vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

vim.opt.clipboard = 'unnamedplus'

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = { '*.tex', '*.bib', '*.md', '*.txt' },
    callback = function()
        vim.opt_local.spell = true
    end,
    group = vim.api.nvim_create_augroup("Enable spell checking", { clear = true }),
})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*' },
    callback = function()
        vim.api.nvim_command [[%s/\s\+$//e]]
    end,
    group = vim.api.nvim_create_augroup("Clean trailing spaces", { clear = true }),
})

vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost'}, {
    pattern = { '*.*' },
    callback = function()
        vim.api.nvim_command [[write]]
    end,
    group = vim.api.nvim_create_augroup("Autosave buffer", { clear = true }),
})

vim.api.nvim_set_keymap('n', '<Space>', "", {})
vim.g.mapleader = ' '

options = { noremap = true }
vim.api.nvim_set_keymap('n', '<leader>s', ':setlocal spell!<cr>', options)
vim.api.nvim_set_keymap('n', '<leader>e', ':Explore<cr>', options)
vim.api.nvim_set_keymap('n', '<leader>t', ':vsplit term://zsh<cr>', options)
vim.api.nvim_set_keymap('n', '<s-tab>', ':bprevious<cr>', options)
vim.api.nvim_set_keymap('n', '<tab>', ':bnext<cr>', options)

vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, options)
vim.keymap.set('n', '<leader>c', function() require('dap').continue() end, options)
vim.keymap.set('n', '<leader>i', function() require('dap').step_into() end, options)
vim.keymap.set('n', '<leader>o', function() require('dap').step_over() end, options)
vim.keymap.set({'n', 'v'}, '<leader>dd', function() require('dap').disconnect() end, options)
vim.keymap.set({'n', 'v'}, '<leader>dh', function() require('dap.ui.widgets').hover() end, options)
vim.keymap.set({'n', 'v'}, '<leader>dp', function() require('dap.ui.widgets').preview() end, options)
require("dap-python").setup("uv")

vim.keymap.set('n', '<leader>g', function() require('neogit').open() end, options)

vim.keymap.set("n", ";", "gcc", { remap = true })
vim.keymap.set("v", ";", "gc", { remap = true })

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },

    sources = {
        { name = "nvim_lsp" },
        { name = 'nvim_lsp_signature_help' },
        { name = "buffer" },
    },

    mapping = {
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    },

    preselect = cmp.PreselectMode.None,

    completion = {
        compteopt = vim.o.completeopt,
    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("lspconfig").ruff.setup{ capabilities = capabilities, }
require("lspconfig").pyright.setup{ capabilities = capabilities, }
require("lspconfig").rust_analyzer.setup{ capabilities = capabilities, }
require("lspconfig").clangd.setup{ capabilities = capabilities, }
vim.diagnostic.config({ virtual_text = true })

require('marks').setup()

require('nvim-autopairs').setup()

require("ibl").setup()

require("gitsigns").setup()
require("neogit").setup{}

require('lualine').setup{
    options = { theme = 'codedark', }
}

vim.api.nvim_command [[colorscheme unokai]]
