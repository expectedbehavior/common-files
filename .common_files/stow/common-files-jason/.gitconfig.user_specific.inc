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
[delta "decorations"]
	commit-decoration-style = bold yellow box ul
	file-style = bold yellow ul
	file-decoration-style = none
[interactive]
	diffFilter = delta --color-only
[pager]
	diff = delta
	show = delta
[diff]
  algorithm = minimal
