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
                pattern = { '*' },
                callback = function()
                    vim.api.nvim_command [[write]]
                end,
                group = vim.api.nvim_create_augroup("Autosave buffer", { clear = true }),
            })

            vim.api.nvim_set_keymap('n', '<Space>', "", {})
            vim.g.mapleader = ' '

            options = { noremap = true }
            vim.api.nvim_set_keymap('n', '<leader>s', ':setlocal spell!<cr>', options)
            vim.api.nvim_set_keymap('n', '<leader>p', ':set paste!<cr>', options)
            vim.api.nvim_set_keymap('n', '<leader>e', ':Explore<cr>', options)
            vim.api.nvim_set_keymap('n', '<s-tab>', ':bprevious<cr>', options)
            vim.api.nvim_set_keymap('n', '<tab>', ':bnext<cr>', options)

            require("lspconfig").nil_ls.setup{}
            require("lspconfig").ruff_lsp.setup{}
            require("lspconfig").rust_analyzer.setup{}

            require('mini.completion').setup()
            local imap_expr = function(lhs, rhs)
                vim.keymap.set('i', lhs, rhs, { expr = true })
            end
            imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
            imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

            require('marks').setup()

            require('nvim_comment').setup()
            vim.api.nvim_set_keymap('n', ';', ':CommentToggle<cr>', options)
            vim.api.nvim_set_keymap('v', ';', ':CommentToggle<cr>', options)

            require('nvim-autopairs').setup()

            vim.g.indentLine_char_list = [[|]]
            vim.g.tex_conceal = ""
            vim.g.gitgutter_enabled = 1

            vim.api.nvim_command [[colorscheme molokai]]
        '';
    };

}
