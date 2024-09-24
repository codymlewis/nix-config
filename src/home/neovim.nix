{ pkgs, ... }:

{
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        plugins = [
            pkgs.vimPlugins.nvim-lspconfig
            pkgs.vimPlugins.marks-nvim
            pkgs.vimPlugins.nvim-comment
            pkgs.vimPlugins.vim-airline
            pkgs.vimPlugins.vim-gitgutter
            pkgs.vimPlugins.nvim-autopairs
            pkgs.vimPlugins.indentLine
            pkgs.vimPlugins.mini-nvim
            pkgs.vimPlugins.molokai
        ];

        extraLuaConfig = ''
            local o = vim.o
            local wo = vim.wo
            local bo = vim.bo
            local cmd = vim.cmd
            local map = vim.api.nvim_set_keymap
            local api = vim.api

            o.history = 500
            o.autoread = true
            vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
                pattern = { '*' },
                callback = function()
                    vim.api.nvim_command [[checktime]]
                end,
                group = vim.api.nvim_create_augroup("Detect file changes", { clear = true }),
            })

            o.smartcase = true
            o.hlsearch = true
            o.incsearch = true
            o.magic = true
            o.wildmenu = true
            o.background = 'dark'
            o.encoding = 'utf8'
            o.swapfile = false
            o.title = true

            wo.number = true
            wo.lbr = true
            wo.wrap = true

            bo.tabstop = 8
            bo.softtabstop = 4
            bo.shiftwidth = 4
            bo.expandtab = true
            bo.autoindent = true
            bo.undofile = true

            vim.g.netrw_liststyle = 3
            vim.g.netrw_banner = 0

            vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
                pattern = { '*.tex', '*.md', '*.txt' },
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
                pattern = { '*' },
                callback = function()
                    vim.api.nvim_command [[write]]
                end,
                group = vim.api.nvim_create_augroup("Autosave buffer", { clear = true }),
            })

            map('n', '<Space>', "", {})
            vim.g.mapleader = ' '

            options = { noremap = true }
            map('n', '<leader>s', ':setlocal spell!<cr>', options)
            map('n', '<leader>p', ':set paste!<cr>', options)
            map('n', '<leader>e', ':Explore<cr>', options)
            map('n', '<s-tab>', ':bprevious<cr>', options)
            map('n', '<tab>', ':bnext<cr>', options)

            require("lspconfig").nil_ls.setup{}
            require("lspconfig").pylsp.setup{}
            require("lspconfig").rust_analyzer.setup{}

            require('mini.completion').setup()
            local imap_expr = function(lhs, rhs)
                vim.keymap.set('i', lhs, rhs, { expr = true })
            end
            imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
            imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

            require('marks').setup()

            require('nvim_comment').setup()
            map('n', ';', ':CommentToggle<cr>', options)
            map('v', ';', ':CommentToggle<cr>', options)

            require('nvim-autopairs').setup()

            vim.g.indentLine_char_list = [[|]]
            vim.g.tex_conceal = ""
            vim.g.gitgutter_enabled = 1

            api.nvim_command [[colorscheme molokai]]
        '';
    };

}
