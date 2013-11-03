all:
	mkdir -p bin
	haxe build.hxml
clean:
	rm -rf bin out *.log

