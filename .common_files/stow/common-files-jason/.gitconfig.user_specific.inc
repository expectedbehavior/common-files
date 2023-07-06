[push]
	default = current
[core]
	pager = delta
[delta]
	plus-color = "#012800"
	minus-color = "#340001"
	syntax-theme = Monokai Extended
	features = line-numbers decorations
	whitespace-error-style = 22 reverse
	max-line-length = 2048
[delta "decorations"]
	commit-decoration-style = bold yellow box ul
	file-style = bold yellow ul
	file-decoration-style = none
[interactive]
	diffFilter = delta --color-only --max-line-length 2048
[pager]
	diff = delta
	show = delta
[diff]
  algorithm = minimal
[include]
	path = .gitconfig.email.inc
