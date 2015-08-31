#!/bin/sh
# run in dir containing target files.
# if output looks bad, revise main script's
# awk syntax.

for f in `ls -a | grep ser`
do
filedate=`echo $f | awk '{print substr($0,0,13)}'`
echo `date -d @$filedate +%Y-%m-%d`
done
