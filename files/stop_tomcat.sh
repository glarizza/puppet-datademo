#!/bin/bash
set -u
set -e

CATALINA_PID='/var/run/tomcat.pid'
PID=`cat "$CATALINA_PID"`
echo "Killing Tomcat with the PID: $PID"
kill -9 $PID
rm -f "$CATALINA_PID" >/dev/null 2>&1
if [ $? != 0 ]; then
  echo "Tomcat was killed but the PID file could not be removed."
fi

