build/classes: class.list
	mkdir -p build/classes
	javac -d build/classes @class.list

build/graphhopper.jar: build/classes
	cd build/classes && jar cvf ../graphhopper.jar *

build/usage.log: proguard build/graphhopper.jar
	java -jar proguard/lib/proguard.jar @proguard-slim.cfg > build/usage.log

optimize: build/usage.log
	@:

.PHONY: optimize
