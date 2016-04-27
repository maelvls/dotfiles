" Mes raccourcis : 
" 	ctrl+b pour nerdtree
" 	ctrl+l pour tabbar
" 	ctrl + p pour débugguer
" 	ctrl + w + fleches pour changer de fenetre
" 	cmd + b pour make
" 	ctrl + b pour nerd-tree 
" 	:A pour switcher header/implementation (A-VIM)
" 	u pour annuler
" 	/recherche pour les regex
"		ctrl + h pour cacher la regex
"		n/b pour circuler dans les regex
"	`gcc` pour commenter (ou ctrl+_ + c)
"
" Raccourcis intéressants :
" 	`^` et `$` pour aller au début/fin ligne
" 	`a`/`s`/`o` pour insérer
" 	`ctrl+v` pour sélectionner un rectangle de texte
"   	puis `r` pour remplacer par qqchose
"   `ctrl+i` pour auto-complete
"   `ctrl+p`
" Recherche :
"	`:set incsearch` pour rechercher incrémentalement
"	`:set ignorecase`
"	`:set smartcase` qui va faire du ignorecase si lettres minuscules,
"		et casesensitive si on met au moins une lettre majuscule
"   `/\Cma_recherche` pour chercher en mode case-sensitive
"   `ctrl + $` pour chercher toutes les occurrences du mot du curseur
"   `ctrl + h` (hide) pour désactiver le highlight en cours
" Remplacement :
"   `:%s/un_mot/un_remplaçant/g` pour remplacer
"   	`%` est utilisé pour remplacer dans toutes les lignes du texte
"   	`gi` dans le cas où on veut du case-insensitive
" Buffers :
" 	`:bn` pour passer au buffer suivant
" 	`:bp` pour passer au buffer précédent
" 	`:b <tab>` pour se déplacer dans les buffers
" 	
" Ouvrir et rechercher un fichier rapidement :
" 	`ctrl + t` pour chercher un fichier
"
" Pour aller dans le dossier du fichier ouvert :
" 	cd %:p:h
" 	:NERDTreeFind
"
" Pour corriger l'indentation :
"   `G=gg` (l'opérateur = est responsable de la correction)
" Retourner à la dernière position :
"   ``
" 	
" 
" 23 oct 2014 - Pour faire fonctionner clang (ctrl+p) avec des librairies :
" 	- créer .clang_complete à la racine du projet
" 	- y mettre les flags de compilation : 
" 		-L/opt/local/lib -lgstreamer-0.10 -lglib-2.0 -lgobject-2.0  
" 		-I/opt/local/include/glib-2.0 -I/opt/local/lib/glib-2.0/include/
" 20 déc 2014 - Probleme avec {+tab : si y'a une indentation ça bug et ça recopie =>> j'ai
" 	réglé le pbm en mettant à jour les pluggins et en relançant
" 29 mars 2015 - Problème avec supertab : semble désactivé
" 29 mars 2015 - j'ai remplacé ervandew/supertab et Rip-Rip/clang_complete
" 	par Valloric/YouCompleteMe
" 29 mars 2015 - j'ai remplacé QuickComment par tcomment_vim
" 29 mars 2015 - J'ai remplacé garbas/vim-snipmate par SirVer/ultisnips
" 30 mars 2015 - J'ai ajouté une fonction `UltiSnips_Complete` qui permet
" 	de valider le choix d'un snippet quand on a le panneau d'autocomplétion
"	(car la touche `entrée` ne fonctionne pas avec UltiSnips+YouCompleteMe)
" 4 avril 2015 - J'ai ajouté Command-T. Comme la version de ruby utilisée par MavVim était
" 	`:ruby puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"` -> 2.0.0,
" 	j'ai cherché le */bin/ruby correspondant et j'ai recompilé Command-T (cf
" 	:help command-t)
" 	NOTE: s'il y a un `SIGENV`, c'est certainement parce que'une mauvaise
" 	version de ruby ou de python est utilisée
" 4 avril 2015 - J'ai enlevé le message d'erreur de Command-T suivant :
" 	`warning: Insecure world writable dir /Users/maelv/.vim/bundle 
" 	in PATH, mode 040777` en faisant `chmod go-w /Users/maelv/.vim/bundle`.
" 13 avril 2015 - ajout de `Plugin tlib` en `Plugin tomtom/tlib_vim`.
" 14 janv. 2016 - j'ai essayé de faire fonctionner YouCompleteMe avec mes
" .c/.cpp. Le souci était en fait que j'avais oublié de faire ./install.py
" avec l'option : 
" autocmd FileType html set shiftwidth=4 tabstop=4
" 	`./install.sh --clang-completer`
" 15 janv 2016 
" 	- ajout de l'option 'gnome-terminal' car sinon pas de couleurs 
" 	sous ubuntu
" 	- j'ai aussi mis de coté YouCompleteMe et Command-T qui prennaient
" 	trop de place sur les 250Mo autorisés à l'ENAC
" 17 janv 2016
"       - J'ai ajouté `set listchars` pour afficher les retours à la ligne et tabs
"	Il suffit de faire `set list` pour activer l'affichage
" 7 avril 2016
"   - passage à git


" Vundle {{{
" Pour installer vundle: 
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible 
filetype off " pour Vundle
set rtp+=~/.vim/bundle/Vundle.vim " pour Vundle 
call vundle#rc() " pour Vundle
" Redéfinition du <Leader>
"let mapleader = ","
Plugin 'VundleVim/Vundle.vim'
" === Début Plugins (Vundle) === 
Plugin 'Valloric/YouCompleteMe'
"Plugin 'rdnetto/YCM-Generator'
Plugin 'ervandew/supertab'
Plugin 'maelvalais/gmpl.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tomtom/tlib_vim'
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'vim-scripts/Colour-Sampler-Pack'
"Plugin 'EasyMotion'
Plugin 'tomtom/tcomment_vim'
"Plugin 'Tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'aperezdc/vim-template'
"Plugin 'std_c.zip'
"Plugin 'lervag/vimtex'
"Plugin 'geetarista/ego.vim'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
"Plugin 'syntaxm4.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
"Plugin 'go.vim'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'MatlabFilesEdition'

" launches merlin, the ocaml completion.
" I installed it using `opam install merlin`
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"


Plugin 'vim-scripts/a.vim'
" a.vim : ":A" pour changer header <-> code
" === Fin plugins ===
filetype plugin indent on " pour Vundle
"}}}

" Avoid warnings "Failure to setup sound" in term
set visualbell

" Font {{{	
if has("gui_running")
	set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h12
endif
if &guifont =~? 'powerline'
	let g:airline_powerline_fonts = 1
endif
let g:airline#extensions#whitespace#enabled = 0
" }}}
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" Display certain characters somehow unwanted (trailing spaces, tabs)
" set nolist/set list to turn off/on
set listchars=tab:▸\ ,trail:◃,nbsp:•
set list

" Paramètres généraux {{{
set mouse=a
" set cursorline
set wildmenu " Ajoute pour la ligne de commande
set laststatus=2

set showmatch
set number
set showcmd " SHOWS THE 2-SEC DELAY ON <ESC> TO RETURN IN NORMAL
set showmode
set encoding=utf-8
set incsearch " Pour que la recherche `/recherche` soit incrémentale
set ignorecase
set smartcase " ignore la casse si seulement petite lettres

" Indentation, wraping, tabulations {{{
" TAB vs SPACES: set expandtab ; set noexpandtab pour enlever 
set tabstop=4
set shiftwidth=4
set textwidth=80 " One line cannot exceed 80 characters
autocmd FileType ml set shiftwidth=2 tabstop=2 expandtab 
autocmd FileType md set sw=2 ts=2 et
autocmd FileType asm set shiftwidth=8 tabstop=8
autocmd FileType ruby set expandtab softtabstop=2 tabstop=2 shiftwidth=2
set autoindent
set smartindent
set wrap
set autochdir " Se met dans le dir. du fichier ouvert
"set foldmethod=marker
"}}}

" Adds *.hcp (used in my company) {{{
au BufNewFile,BufRead *.hcp set filetype=cpp
" }}}

" Curseur different en insert {{{
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7""{{{"}}}"{{{"}}}

" Retablir la position du curseur à l'ouverture
augroup line_return 
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
"}}}

" Couleurs de Vim "{{{
colo Tomorrow-Night
let c_cpp_comments = 1 " Pour std_c
"map <c-h> :let @/ = ""<cr> " pour enlever les hilight des recherches
if &t_Co > 2 || has("gui_running")
   	syntax on			" colo syntaxique
    set hlsearch 	" colo pour la recherche
endif
"}}}

" Backups {{{ 
set nobackup  
set noswapfile 	

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
silent !mkdir ~/.vim/tmp ~/.vim/tmp/{undo,backup,swap} > /dev/null 2>&1
"}}}

"" For `o` and `O` without going into INSERT mode
" (new line without going into INSERT mode)
" cmd+enter and cmd+shift+enter
nmap <M-S-Enter> O<Esc>j
nmap <M-CR> o<Esc>k

" Switch between buffers
" NOTE: I added the shortcuts for Macvim from System Preferences
"    cmd+alt+up, down

" Switch between tabs
" NOTE: instead of using :macmenu, I went to the System Preferences
" and added my own shortcuts for MacVim
"    cmd+alt+left, right

" YCM - YouCompleteMe {{{
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
" }}}

" NERDTree : ctrl + b {{{
inoremap <C-b> <esc>:NERDTreeToggle<cr>
nnoremap <C-b> :NERDTreeToggle<cr>
let g:NERDTreeWinSize = 26
let NERDTreeShowBookmarks = 1

" Si on est sur MacVim on ouvre NERDTree
if has("gui_running")
	"autocmd VimEnter * NERDTreeFromBookmark prog
	"autocmd VimEnter * NERDTree
	"autocmd BufEnter * NERDTreeMirror (synchro tous les nerdTree ouverts)
endif
"}}}

" Tagbar : ctrl+l {{{
let g:TagbarOpen = 0
let g:tagbar_width = 22
inoremap <c-l> <esc>:TagbarToggle<cr>
nnoremap <c-l> :TagbarToggle<cr>
"}}}

" Tabbar {{{
map <c-w><c-m> :TbToggle<CR>
let g:Tb_UseSingleClick = 1 " car avec la touche d on peut fermer le buffer
let g:Tb_ModSelTarget = 1
"}}}


" Fonction Chmod {{{
" Une fonction Chmod pour chmod +x % sans relancer vim
function! ActiverExecutable()
	let fname = expand("%:p")
	checktime
	execute "au FileChangedShell " . fname . " :echo"
	silent !chmod a+x %
	checktime
	execute "au! FileChangedShell " . fname
endfunction
command! Chmod call ActiverExecutable()
" }}}

" Options pour template.vim  {{{ 
let g:username = "Maël Valais"
let g:email = "mael.valais@gmail.com"
let g:templates_directory = '~/.vim/templates/'
"}}}

" Powerline {{{
"let g:Powerline_stl_path_style = 'full'
"let g:Powerline_symbols = 'unicode'
"}}}

" UltiSnips {{{
"
" Ces trois lignes servent à rendre possible la cohabitation
" entre Ultisnips et YouCompleteMe ; cela est fait grâce à
" SuperTab.
let g:ycm_key_list_select_completion = ['\<C-TAB>', '\<Down>']
let g:ycm_key_list_previous_completion = ['\<C-S-TAB>', '\<Up>']
let g:SuperTabDefaultCompletionType = '\<C-Tab>'
"
"
" let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" Fonction pour que lorsque j'ai des propositions de snippets,
" je n'ai plus qu'à appuyer sur `tab` et la sélection courante est
" validée. Par contre, il faut que j'utilise `bas/haut` pour naviguer
" dans le menu d'autocomplétion
" function! g:UltiSnips_Complete()
"     call UltiSnips#ExpandSnippet()
"     if g:ulti_expand_res == 0
"         if pumvisible()
"             return "\<C-n>"
" 		else
"             call UltiSnips#JumpForwards()
"             if g:ulti_jump_forwards_res == 0
"                return "\<TAB>"
"             endif
"         endif
"     endif
"     return ""
" endfunction
" au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsListSnippets="<c-e>"
" }}}
