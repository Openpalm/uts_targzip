#!/bin/sh
# run in directory containing target files
# groups files according to target date by day.
# see awk syntax.
# test using the coupled awk test script.

ME=$0
TODAY=`date +"%Y-%m-%d"`
MYDIR=`pwd`

execBackup()
{
	echo "Starting procedure for $MYDIR"
	#echo "$TODAY $0"
	#echo `stat -c %z $0 | echo `
	for f in `ls -a $MYDIR | grep ser`
	do
		filedate=`stat -c %y $f | awk '{print substr($0,0,10);}'`
		if [ ! $filedate = $TODAY ]
		then
			if [ ! -d `stat -c %y $f | awk '{print substr($0,0,10);}'` ]
			then
				DIRME=`stat -c %y $f | awk '{print substr($0,0,10);}'`
				mkdir $DIRME
				echo creating $DIRME
				DIRCOUNTER=`expr $DIRCOUNTER + 1`
			fi
			mv $f $DIRME
			echo "moved $f to $DIRME"
			FILECOUNTER=`expr $FILECOUNTER + 1`
		fi
	done
	for d in `ls -a $MYDIR | grep -`
	do
		echo "tar.gz\`ing $d..."
		tar cfz $d.tar.gz $d
		echo deleting $d
		rm -rf $d
	done
}

echo ""
execBackup
echo "$DIRCOUNTER directories created and deleted,\n$FILECOUNTER files moved and zipped.\n "
echo "Done."
