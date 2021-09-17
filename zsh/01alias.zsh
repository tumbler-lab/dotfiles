# alias
# abbrev-alias ls='ls --color=auto'
abbrev-alias l='ls -CF'   # 列をそろえない、各分類を表示(*ならコマンド、/ならディレクトリ等)
abbrev-alias la='ls -alF' # 全てを表示、整列させる、各分類を表示

abbrev-alias v='vim'
abbrev-alias vz='vim ~/.zshrc'

abbrev-alias relogin='exec $SHELL -l'

abbrev-alias -g G='| grep --color=auto'	# grep
abbrev-alias -g C='| wc -l'	# count
abbrev-alias -g H='| head'	# head
abbrev-alias -g T='| tail'	# tail

abbrev-alias actv='source .venv/bin/activate'
abbrev-alias dctv='deactivate'
