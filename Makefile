build:
	pandoc -f markdown -t html -s --mathjax math.md > index.html
