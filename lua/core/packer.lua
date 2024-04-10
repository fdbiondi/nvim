-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- file browser
    use {
        'nvim-telescope/telescope-file-browser.nvim',
        requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
    }

    -- icons for telescope
    use('nvim-tree/nvim-web-devicons')

    use('folke/trouble.nvim')   -- list for showing diagnostics, references, telescope results, quickfix and location lists
    use {
        'folke/which-key.nvim', -- keymaps suggestions
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {}
        end
    }

    -- highlighting, indentation and some other stuff
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-context')

    -- lsp configuration
    use {
        'VonHeikemen/lsp-zero.nvim',
        -- TODO update to v3 - https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/migrate-from-v2-branch.md
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- fancier statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- colorschemes
    use { 'rose-pine/neovim', as = 'rose-pine' }
    use { 'briones-gabriel/darcula-solid.nvim', as = 'darcula', requires = 'rktjmp/lush.nvim' }
    use { 'EdenEast/nightfox.nvim', as = 'nightfox' }
    use { 'folke/tokyonight.nvim', as = 'tokyonight' }
    use { 'catppuccin/nvim', as = 'catppuccin' }

    -- git plugins
    use('tpope/vim-fugitive')
    use('lewis6991/gitsigns.nvim')
    use('ThePrimeagen/git-worktree.nvim')

    -- debugging
    use('nvim-lua/plenary.nvim')
    use('mfussenegger/nvim-dap')
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    use('theHamsta/nvim-dap-virtual-text')
    use('leoluz/nvim-dap-go')

    -- rust tools
    use('simrat39/rust-tools.nvim')

    -- golang tools
    use("ray-x/go.nvim")

    -- useful tools
    use('sbdchd/neoformat')                    -- format document
    use('windwp/nvim-ts-autotag')
    use('mbbill/undotree')                     -- navigation through undo history tree
    use('laytan/cloak.nvim')                   -- password hidding
    use('lukas-reineke/indent-blankline.nvim') -- lines indentation guidelines
    use('numToStr/Comment.nvim')               -- comment visual regions/lines
    use('theprimeagen/harpoon')                -- file navigation tool
    use {                                      -- refactoring tool
        'theprimeagen/refactoring.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-treesitter/nvim-treesitter' }
        }
    }

    -- nx build system tool
    use {
        'Equilibris/nx.nvim',
        requires = { 'nvim-telescope/telescope.nvim' }
    }

    -- IA suggestions tool
    use('Exafunction/codeium.vim')

    -- some practice plugin
    use('theprimeagen/vim-be-good')
end)
