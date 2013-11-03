#!/bin/sh

ab -r -n 20000 -c 1000 http://127.0.0.1:8080/bench
#ab -r -n 20000 -c 1000 http://127.0.0.1:8080/bench-ejs
#ab -r -n 20000 -c 1000 http://127.0.0.1:8080/bench-eco

#ab -r -n 20000 -c 1000 http://127.0.0.1:8080/bench-docpad
#ab -r -n 20000 -c 1000 http://127.0.0.1:8080/bench.html

read -s -n 1