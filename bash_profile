#!/bin/bash

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=0;40:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export LSCOLORS=gxfxcxdxbxegedabagaced
export CLICOLOR=exfxcxdxbxegedabagacad

EDITOR=$(which vim)
VISUAL=$(which vim)
PAGER="$(which more) -s"
BLOCKSIZE=K
HISTSIZE=1000
HISTFILE="$HOME/.history"
SAVEHIST=1000
TERM="xterm-color"
FCEDIT=vi

export EDITOR VISUAL PAGER BLOCKSIZE HISTSIZE HISTFILE SAVEHIST TERM FCEDIT

PATH=$HOME/bin:.:$PATH
export PATH

# get the proper prompt and display path in titlebar of terms..
PS1="\[\033]0;\h:\w\007\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ "
export PS1

# 022: world-readable files
# 077: completely private files (but not readable by Apache)
umask 022

# first order of business: fix stupid aliases..
unalias -a 2>/dev/null

# some useful aliases..
alias 2dos="$(which perl) -p -i -e 's/$/\r/'"
alias 2unix="$(which perl) -p -i -e 's/\r\n/\n/g'"
alias fixascii="perl -i.bak -pe 's/[^[:ascii:]]//g' "
alias l="ls -lF --color=auto"
alias ll="ls -lF --color=auto | more"
alias lt="ls -lFt --color=auto"
alias lld="ls -lF --color=auto | grep ^d"
alias cl=$(which clear)
alias cls="$(which clear);ls -lF --color=auto"
alias csl="$(which clear)clear;ls -lF --color=auto"
alias cp="cp -ip"
alias mv="mv -i"
alias rm="rm -i"
alias x="exit"
alias lsa='ls -ld .* --color=auto'

rename_d=$HOME/bin
rename_f="$rename_d/rename.pl"

perl_x=$(which perl)

if [[ ! -e $rename_f ]]; then
  mkdir -p $rename_d
  cat << EOF > $rename_f
#!$perl_x -w

\$op = shift or die "Usage: rename.pl expr [files]\n";
chomp(@ARGV = <STDIN>) unless @ARGV;
for (@ARGV) {
  \$was = \$_;
  eval \$op;
  \$@ && die;
  rename (\$was, \$_) unless \$was eq \$_;
}
__END__
EOF
fi

# add executable bit..
chmod +x $rename_f

alias fixnames=" \
  $rename_f 's/[^\w|\.|\-]+/\-/g' *; \
  $rename_f 's/\_+/\-/g' *; \
  $rename_f 's/\-+/\-/g' *; \
  $rename_f 's/\-\././g' *; \
  $rename_f 's/^\-+//g' *; \
  $rename_f 's/\.+/\./g' *;"

# define vimrc..
vimrc=$HOME/.vimrc

if [[ ! -e $vimrc ]]; then
  cat << EOF > $vimrc
syntax on
filetype on
au BufNewFile,BufRead *.conf set filetype=config
au BufNewFile,BufRead *.txt set filetype=yaml
au BufNewFile,BufRead *.yml set filetype=yaml
set autoindent
set exrc
set noflash
set mesg
set nocompatible
set noautowrite
set noerrorbells
set noshowmatch
set nowarn
set nowrapscan
set number
set report=2
set shiftwidth=2
set expandtab
set showmode
set nosm
set tabstop=2
set ruler
set noincsearch
set nohlsearch
set title
set background=dark
set modelines=1

colorscheme darkblue
let loaded_matchparen=1
highlight clear Normal
highlight Comment term=NONE ctermfg=6
highlight Error term=NONE cterm=NONE ctermfg=2 ctermbg=NONE
highlight String term=NONE cterm=NONE ctermfg=3 ctermbg=NONE
highlight Special term=NONE cterm=NONE ctermfg=darkred
highlight LineNr term=NONE cterm=NONE ctermfg=2
highlight Title term=NONE cterm=NONE ctermfg=5
highlight NonText ctermfg=6
highlight Underlined term=none cterm=none ctermfg=6
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii term=reverse cterm=bold ctermbg=1 gui=bold guibg=Red

" common typos, and abbreviations..
ab basci basic
ab chagne change
ab eamil email
ab eidtor editor
ab hte the
ab monring morning
ab mroe more
ab mvoe move
ab noly only
ab peices pieces
ab probelm problem
ab ssytem system
ab taht that
ab teh the
ab thsi this
ab waht what
ab wehn when
ab wnat want
ab wnated wanted
ab Falt Flat
ab seh she
ab nad and
ab recieved received
ab baout about
ab ahd had
ab whiel while
ab htat that
ab cleint client
ab itmes items
ab hwo how
ab hse she
ab aviod avoid
ab ahve have
ab clcok clock
ab dorve drove
ab alos also
ab taks task
ab wich which
ab eidting editing
ab yoru your
ab aritcle article
ab ti it
ab wroking working
ab emial email
ab msot most
ab wiht with
ab iwth with
ab soem some
ab soemthing something
ab macors macros
ab macor macro
ab Teh The
ab tiem time
ab peice piece
ab otehr other
ab tkae take
ab htat that
ab hwen when
ab sapce space
ab iwll will
ab toher other
ab Marcos Macros
EOF

fi

vimx=$(which vim)
alias vi="$vimx -u $vimrc"
alias view="$vimx -R -u $vimrc"
set -o vi

# miscellaneous aliases
if [ -f ~/.alias ]; then
  . ~/.alias
fi

# alias web directories [DOCUMENT_ROOT]

# export web directories [DOCUMENT_ROOT]

# database aliases

# ssh shortcuts

# iOS dev..
