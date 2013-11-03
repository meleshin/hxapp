ps -e|grep node|grep `cat PID`|awk '{print "kill " $1 " " $2}'|sh
rm PID