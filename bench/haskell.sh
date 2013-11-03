#!/bin/sh

cd haskell
dist/build/bench/bench.exe Production +RTS -N6
read -s -n 1