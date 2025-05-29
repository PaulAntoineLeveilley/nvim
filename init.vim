if has("termguicolors")
  set termguicolors
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'Mofiqul/vscode.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'hrsh7th/nvim-cmp'              " Plugin d'autocomplétion
Plug 'hrsh7th/cmp-nvim-lsp'          " Source LSP pour nvim-cmp
Plug 'hrsh7th/cmp-buffer'            " Source mots dans le buffer
Plug 'hrsh7th/cmp-path'              " Source chemins fichiers
Plug 'hrsh7th/cmp-cmdline'           " Source pour la ligne de commande
Plug 'L3MON4D3/LuaSnip'              " Snippets engine
Plug 'saadparwaiz1/cmp_luasnip'      " Source snippets pour nvim-cmp

call plug#end()

let g:vscode_style = "light"
let g:vscode_transparent = v:false

set background=light
colorscheme vscode

lua << EOF


local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),     -- Ctrl+Espace pour lancer la complétion
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Enter pour valider
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- snippets
  }, {
    { name = 'buffer' },
  })
})

-- LSP setup pour pyright, avec capabilities pour nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()



require("mason").setup()
require("lspconfig").pyright.setup {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
}
EOF

