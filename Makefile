build:
	pandoc -f markdown -t html --toc -s --standalone --mathjax --template template.html --lua-filter=fix-links.lua math.md > dist/index.html

serve:
	python3 -c 'from livereload import Server, shell; server = Server(); server.watch("*.md", shell("make")); server.watch("template.html", shell("make -B")); server.serve(root="./dist/");'
