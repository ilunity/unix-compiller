#!/bin/bash -e

inputFile=${1}
if [ ! -f $inputFile ]
then
	echo 'Invalid input file path'
	exit 1
fi

initDir=$(pwd)

tempDir=$(mktemp -d)
trap "rm -rf ${temp_dir}" EXIT HUP INT QUIT TERM PIPE

outputFile=$(grep -o "&Output:\w*[.]*\w*" $inputFile | cut -d ':' -f 2)
if [ -z $outputFile ]
then
  echo 'Could not read the output path'
  exit 2
fi


cp $inputFile $tempDir
cd $tempDir

g++ $inputFile -o $outputFile
if [ $? -ne 0 ]
then
	echo 'Failed to compile'
	exit 3
fi

mv $outputFile $initDir
cd $initDir

echo Compilled
exit 0