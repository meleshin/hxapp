#!/bin/sh

# Kill process with name "node" and PID from file ./PID 
ps -e|grep node|grep `cat PID`|awk '{print "kill " $1 " " $2}'|sh

node bin/app.js  & echo $! > PID


# Pause after run
read -s -n 1