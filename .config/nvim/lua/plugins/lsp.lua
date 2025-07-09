
return {


    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
        },
        config = function()

            -- go to definition
            vim.keymap.set('n', 'gd', '<C-]>', { noremap = true, })

            -- go to declaration
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true, })

            -- go back after jump to definition
            vim.keymap.set('n', 'gb', '<C-t>', { noremap = true, })

            vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { noremap = true, })
            vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, { noremap = true, })
            vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition, { noremap = true, })
            vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { noremap = true, })
            vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { noremap = true, })
            vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, { noremap = true, })
            vim.keymap.set('n', '<leader>lo', vim.lsp.buf.document_symbol, { noremap = true, })
            vim.keymap.set('n', '<leader>lf', function()
                vim.lsp.buf.format({ async = true })
            end, {noremap = true})


            require("mason").setup()


            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                    }
                }
            })

            vim.lsp.config('rust_analyzer', {
                -- imports = {
                --     granularity = {
                --         group = "module",
                --     },
                --     prefix = "self",
                -- },
                -- diagnostic = {
                --     -- TEMP: until https://github.com/neovim/neovim/issues/30985
                --     refreshSupport = false,
                -- },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true
                },
                completion = {
                    callable = {
                        snippets = "none"
                    }
                }
            })



            vim.lsp.config('eslint', {
                settings = {
                    options = {
                        -- cache = true,
                        -- overrideConfigFile = vim.fn.stdpath("config"),
                    }
                }
            })


            vim.lsp.config('mdx_analyzer', {
                filetypes = { "markdown.mdx", "mdx" },
            })

            vim.lsp.config('cssls', {
                filetypes = { "css", "sass", "scss", "less", "astro" },
            })



            vim.lsp.enable({
                'lua_ls',
                -- 'ts_ls',
                'rust_analyzer',
                'pylsp',
                'gopls',
                'clangd',
                'svelte',
                'astro',
                'tailwindcss',
                -- 'unocss',
                -- 'jinja_lsp',
                'glsl_analyzer',
                'eslint',
                -- 'mdx_analyzer',
                'cssls',
            })

            -- TODO: temp fix until telescope uses winborder
            local _hover = vim.lsp.buf.hover
            vim.lsp.buf.hover = function()
                return _hover({ border = 'single' })
            end

        end,
    },


    {
        "pmizio/typescript-tools.nvim",
        ft = {
            'javascript', 'javascriptreact', 'javascript.jsx',
            'typescript', 'typescriptreact', 'typescript.tsx',
            'vue', 'astro', 'svelte',
        },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            filetypes = {
                'javascript', 'javascriptreact', 'javascript.jsx',
                'typescript', 'typescriptreact', 'typescript.tsx',
                'vue', 'astro', 'svelte',
            },
        },
    },

    -- {
    --     'mrcjkb/rustaceanvim',
    --     version = '^6',
    --     lazy = false,
    --     ft = { 'rust' },
    --     dependencies = { 'neovim/nvim-lspconfig' },
    --     config = function()
    --         vim.g.rustaceanvim = {
    --             tools = {
    --                 -- Plugin configuration
    --             },
    --             server = {
    --                 -- copy of this config exists above in rust_analyzer setup too
    --                 on_attach = function(client, bufnr)
    --                     -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    --                     -- you can also put keymaps in here
    --                 end,
    --                 default_settings = {
    --                     ['rust-analyzer'] = {
    --                         -- imports = {
    --                         --     granularity = {
    --                         --         group = "module",
    --                         --     },
    --                         --     prefix = "self",
    --                         -- },
    --                         diagnostic = {
    --                             -- TEMP: until https://github.com/neovim/neovim/issues/30985
    --                             refreshSupport = false,
    --                         },
    --                         cargo = {
    --                             buildScripts = {
    --                                 enable = true,
    --                             },
    --                         },
    --                         procMacro = {
    --                             enable = true
    --                         },
    --                         completion = {
    --                             callable = {
    --                                 snippets = "none"
    --                             }
    --                         }
    --                     },
    --                 },
    --             },
    --             dap = {
    --             },
    --         }
    --     end
    -- },

    -- {
    --     "davidmh/mdx.nvim",
    --     dependencies = {"nvim-treesitter/nvim-treesitter"},
    --     config = function ()
    --         require('mdx').setup({})
    --         require('Comment.ft').set('mdx', '{/* %s */}')
    --     end

    -- },

    -- {
    --     'kosayoda/nvim-lightbulb',
    --     config = function()
    --         require("nvim-lightbulb").setup({
    --             autocmd = { enabled = true }
    --         })
    --     end
    -- },

    -- {
    --     "folke/trouble.nvim",
    --     cmd = "Trouble",
    --     opts = {},
    -- },
}


-- local function lspconfig()

--     vim.api.nvim_create_autocmd('LspAttach', {
--         group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--         callback = function(ev)
--             -- Buffer local mappings.
--             -- See `:help vim.lsp.*` for documentation on any of the below functions
--             local opts = { buffer = ev.buf }
--             vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--             vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--             vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--             vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--             vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
--             -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--             -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--             -- vim.keymap.set('n', '<space>wl', function()
--             --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--             -- end, opts)
--             vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition, opts)
--             vim.keymap.set('n', '<space>ln', vim.lsp.buf.rename, opts)
--             vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, opts)
--             vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)
--             vim.keymap.set('n', '<leader>lf', function()
--                 vim.lsp.buf.format { async = true }
--             end, opts)
--         end,
--     })


--     local servers = {

--         -- rust_analyzer = {
--             -- on_attach = function(client, bufnr)
--             --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--             --     -- you can also put keymaps in here
--             -- end,
--             -- settings = {
--             --     ["rust-analyzer"] = {
--             --         imports = {
--             --             granularity = {
--             --                 group = "module",
--             --             },
--             --             prefix = "self",
--             --         },
--             --         cargo = {
--             --             buildScripts = {
--             --                 enable = true,
--             --             },
--             --         },
--             --         procMacro = {
--             --             enable = true
--             --         },
--             --     }
--             -- }
--         -- }, -- overridden by 'mrcjkb/rustaceanvim'
--         -- copy of this config exists below in rustaceanvim setup too
--         -- remove from ensure_installed below if enabled here
--         -- remove override from handler if enabled here

--         -- ts_ls = {}, -- overridden by 'pmizio/typescript-tools.nvim',
--         -- remove from ensure_installed below if enabled here

--         pylsp = {},

--         eslint = {
--             settings = {
--                 options = {
--                     -- cache = true,
--                     -- overrideConfigFile = vim.fn.stdpath("config"),
--                 }
--             }
--         },

--         gopls = {},

--         lua_ls = {
--             settings = {
--                 Lua = {
--                     diagnostics = {
--                         -- Get the language server to recognize the `vim` global
--                         globals = { "vim" },
--                     },
--                 }
--             }

--         },

--         clangd = {},

--         -- svelte = {},

--         astro = {},

--         mdx_analyzer = {
--             filetypes = { "markdown.mdx", "mdx" },
--         },

--         cssls = {
--             filetypes = { "css", "sass", "scss", "less", "astro" },
--         },

--         tailwindcss = {},

--         -- unocss = {},

--         jinja_lsp = {},

--         glsl_analyzer = {},
--     }


--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities = vim.tbl_deep_extend(
--         'force', capabilities, require('cmp_nvim_lsp').default_capabilities()
--     )

--     require('mason').setup()
--     require('mason-lspconfig').setup({
--         ensure_installed = vim.tbl_keys(vim.tbl_deep_extend(
--             'force', servers, {
--                 ts_ls = {},
--                 rust_analyzer = {},
--             }
--         )),
--         handlers = {
--             function(server_name)

--                 -- NOTE!! - disable mason auto-config
--                 -- cause overridden by 'mrcjkb/rustaceanvim'
--                 if server_name == 'rust_analyzer' then
--                     return
--                 end

--                 -- NOTE!! - disable mason auto-config
--                 -- cause overridden by 'pmizio/typescript-tools.nvim',
--                 if server_name == 'ts_ls' then
--                     return
--                 end

--                 local server = servers[server_name] or {}
--                 server.capabilities = vim.tbl_deep_extend(
--                     'force', {}, capabilities, server.capabilities or {}
--                 )
--                 -- server.flags = { debounce_text_changes = 100 }
--                 require('lspconfig')[server_name].setup(server)
--             end,
--         },
--     })

--     -- NOTE - comment this out to use toolchain rust-analyzer
--     -- vim.g.rustaceanvim = {
--     --     server = {
--     --         cmd = function()
--     --             local mason_registry = require('mason-registry')
--     --             local ra_binary = mason_registry.is_installed('rust-analyzer')
--     --             and mason_registry.get_package('rust-analyzer'):get_install_path() .. "/rust-analyzer"
--     --             or "rust-analyzer"
--     --             return { ra_binary }
--     --         end,
--     --     },
--     -- }

-- end


-- return {

--     {
--         'neovim/nvim-lspconfig',
--         dependencies = {
--             'williamboman/mason.nvim',
--             'williamboman/mason-lspconfig.nvim',
--         },
--         config = lspconfig,
--     },


--     -- {
--     --     'simrat39/rust-tools.nvim',
--     --     ft = { 'rust' },
--     --     dependencies = { 'neovim/nvim-lspconfig' },
--     --     config = function()
--     --         require('rust-tools').setup({
--     --             tools = {
--     --                 inlay_hints = {
--     --                     -- auto = false,
--     --                     only_current_line = true,
--     --                     highlight = "NonText",
--     --                 }
--     --             },
--     --         })
--     --     end
--     -- },

--     -- {
--     --     'vxpm/ferris.nvim',
--     --     ft = { 'rust' },
--     --     dependencies = { 'neovim/nvim-lspconfig' }
--     -- },

--     {
--         'mrcjkb/rustaceanvim',
--         version = '^5',
--         ft = { 'rust' },
--         dependencies = { 'neovim/nvim-lspconfig' },
--         config = function()
--             vim.g.rustaceanvim = {
--                 tools = {
--                     -- Plugin configuration
--                 },
--                 server = {
--                     -- copy of this config exists above in rust_analyzer setup too
--                     on_attach = function(client, bufnr)
--                         -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--                         -- you can also put keymaps in here
--                     end,
--                     default_settings = {
--                         ['rust-analyzer'] = {
--                             -- imports = {
--                             --     granularity = {
--                             --         group = "module",
--                             --     },
--                             --     prefix = "self",
--                             -- },
--                             diagnostic = {
--                                 -- TEMP: until https://github.com/neovim/neovim/issues/30985
--                                 refreshSupport = false,
--                             },
--                             cargo = {
--                                 buildScripts = {
--                                     enable = true,
--                                 },
--                             },
--                             procMacro = {
--                                 enable = true
--                             },
--                             completion = {
--                                 callable = {
--                                     snippets = "none"
--                                 }
--                             }
--                         },
--                     },
--                 },
--                 dap = {
--                 },
--             }
--         end
--     },

--     {
--         "pmizio/typescript-tools.nvim",
--         ft = {
--             'javascript', 'javascriptreact', 'javascript.jsx',
--             'typescript', 'typescriptreact', 'typescript.tsx',
--             'vue', 'astro', 'svelte',
--         },
--         dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
--         opts = {
--             filetypes = {
--                 'javascript', 'javascriptreact', 'javascript.jsx',
--                 'typescript', 'typescriptreact', 'typescript.tsx',
--                 'vue', 'astro', 'svelte',
--             },
--         },
--     },



--     -- {
--     --     "David-Kunz/gen.nvim",
--     --     cmd = "Gen",
--     --     opts = {},
--     -- },

--     -- {
--     --     "frankroeder/parrot.nvim",
--     --     -- dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
--     --     -- optionally include "rcarriga/nvim-notify" for beautiful notifications
--     --     config = function()
--     --         require("parrot").setup {
--     --             -- Providers must be explicitly added to make them available.
--     --             providers = {
--     --                 ollama = {},
--     --             },
--     --         }
--     --     end,
--     -- }
-- }
