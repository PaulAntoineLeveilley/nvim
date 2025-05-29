if has("termguicolors")
  set termguicolors
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'Mofiqul/vscode.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

call plug#end()

let g:vscode_style = "light"
let g:vscode_transparent = v:false

set background=light
colorscheme vscode

lua << EOF
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

