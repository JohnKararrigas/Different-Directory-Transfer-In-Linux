#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Error. Wrong amount of arguments."
	exit
fi

#variables to count files and directories
var2=0
var3=0
var3=$(find ./$1 -type d -print | wc -l )
var2=$(find ./$1 -type f -print | wc -l )

echo "Use The Menu Wisely To Avoid Bad Execution Of The Programm. "

#counters for attempts
counter=4
counter2=0

while [ $counter -gt 0 ]
do
echo "MENU:"
echo "Press 1. To move the executable files."
echo "Press 2. To move the libraries."
echo "Press 3. To move c,cc,cpp,cxx files."
echo "Press 4. To move h,hxx files."
echo "Press 5. To exit."
#user is prompt to exit or else the programm ends and he loses permission.
#Use : `chmod +x collect.sh  ` to gain the permission back if needed.

#user has some time to pick a choice or else the programm ends.
read -t 60 answer;

if [ "$answer" == "" ]
	then
	echo "Error. You run out of time" 
	echo "Programm Ended. "
	exit
fi	

if((answer==1))
then
mkdir bin
counter2=$(( $counter2 + 1 ))

echo "Bin file created successfully."
echo "######################### EXE FILES:################################"
#scans the file to find executables

find /home/csuser/Desktop/$1 . -type f -executable  -exec sh -c -a '
for file; do
      dest=/home/csuser/Desktop/bin/${file##*/}
      if [ -e "$dest" ]; then
          ls -ld "$dest" "$file"
          read -p "File already exists.Write new name for the second,or ENTER to overwrite the first: " newname;
          if [ "$newname" != "" ]; then
                dest=/home/csuser/Desktop/bin/${newname##*/}
            fi
        fi
        mv "$file" "$dest" 
	#echo "The Time it"
    done' /home/csuser/Desktop/bin/ {} \; 
	
echo "###################################################"
read -p " Do you want to use another directory than bin?[Y|N]:" transport
if [ "$transport" == "y" ]; then
 	read -p "Name the new directory:" newdirectory
	mkdir $newdirectory

find /home/csuser/Desktop/bin . -type f -executable -exec  mv -v '{}' /home/csuser/Desktop/$newdirectory/ \; 
	mv $(find /home/csuser/Desktop/$newdirectory -name "*collect.sh*") /home/csuser/Desktop 
	rmdir bin 
else  echo "Bin file created successfully" 
fi 

#maths to count the files that have been scanned
var6=0
var5=$(find ./$1 -type f  -print | wc -l )
var6=`expr $var2 - $var5 `
echo "EXE files that moved to bin directory:  $var6 "
fi 

if((answer==2))	
then
mkdir lib
counter2=$(( $counter2 + 1 ))
echo "lib file created successfully"

echo "######################## LIB FILES:###############################"
#scans the file to find libraries.
find /home/csuser/Desktop/$1 . -type f -name "lib*" -exec sh -c '
for file; do
      dest=/home/csuser/Desktop/lib/${file##*/}
      if [ -e "$dest" ]; then
          ls -ld "$dest" "$file"
          read -p "Enter new name for the second,or just ENTER to overwrite the first: " newname
          if [ "$newname" != "" ]; then
                dest=/home/csuser/Desktop/lib/${newname##*/}
            fi
        fi
        mv "$file" "$dest"
    done' /home/csuser/Desktop/lib/ {} \;

echo "###################################################"
read -p " Do you want to use another directory than lib?[Y|N]:" transport2
 if [ "$transport2" == "y" ]; then
	read -p "Name the new directory:" newdirectory2
	mkdir $newdirectory2
	find /home/csuser/Desktop/lib . -type f -name "lib*" -exec  mv -v '{}' /home/csuser/Desktop/$newdirectory2/ \;
rmdir lib
else  echo "Lib file created successfully"
fi

#maths to count libraries
var8=0
var8=$(find ./$1 -type f  -print | wc -l )
var7=`expr $var2 - $var8 - $var6 `
echo "LIB files that moved to lib directory:  $var7 "
fi

if((answer==3))
then
mkdir src
counter2=$(( $counter2 + 1 ))
echo "src file created successfully"

echo "##########################.CC FILES:############################"
find /home/csuser/Desktop/$1 . -type f -name "*.cc" -exec sh -c '
for file; do
      dest=/home/csuser/Desktop/src/${file##*/}
      if [ -e "$dest" ]; then
          ls -ld "$dest" "$file"
          read -p "Enter new name for the second,or just ENTER to overwrite the first: " newname
          if [ "$newname" != "" ]; then
                dest=/home/csuser/Desktop/src/${newname##*/}
            fi
        fi
        mv "$file" "$dest"
    done' /home/csuser/Desktop/src/ {} \;

echo "######################.CPP FILES:###################################"
find /home/csuser/Desktop/$1 . -type f -name "*.cpp" -exec sh -c '
for file; do
      dest=/home/csuser/Desktop/src/${file##*/}
      if [ -e "$dest" ]; then
          ls -ld "$dest" "$file"
          read -p "Enter new name for the second,or just ENTER to overwrite the first: " newname
          if [ "$newname" != "" ]; then
                dest=/home/csuser/Desktop/src/${newname##*/}
            fi
        fi
        mv "$file" "$dest"
    done' /home/csuser/Desktop/src/ {} \;

echo "########################.CXX FILES:##############################"
find /home/csuser/Desktop/$1 . -type f -name "*.cxx" -exec sh -c ' 
  for file; do
      dest=/home/csuser/Desktop/src/${file##*/}
      if [ -e "$dest" ]; then
	  ls -ld "$dest" "$file"
	  read -p "Enter new name for the second,or just ENTER to overwrite the first: " newname
	  if [ "$newname" != "" ]; then
		dest=/home/csuser/Desktop/src/${newname##*/}
            fi
        fi
	mv "$file" "$dest"
    done' /home/csuser/Desktop/src/ {} \;

echo "######################.C FILES:#################################"
find /home/csuser/Desktop/$1 . -type f -name "*.c" -exec sh -c ' 
  for file; do
      dest=/home/csuser/Desktop/src/${file##*/}
      if [ -e "$dest" ]; then
	  ls -ld "$dest" "$file"
	  read -p "Enter new name for the second,or just ENTER to overwrite the first: " newname
	  if [ "$newname" != "" ]; then
		dest=/home/csuser/Desktop/src/${newname##*/}
            fi
        fi
	mv "$file" "$dest"
    done' /home/csuser/Desktop/src/ {} \;

echo "###################################################"
read -p " Do you want to use another directory than src?[Y|N]:" transport3
 if [ "$transport3" == "y" ]; then
	read -p "Name the new directory:" newdirectory3
	mkdir $newdirectory3
	find /home/csuser/Desktop/src . -type f -name "*.c" -exec  mv -v '{}' /home/csuser/Desktop/$newdirectory3/ \;
	find /home/csuser/Desktop/src . -type f -name "*.cxx" -exec  mv -v '{}' /home/csuser/Desktop/$newdirectory3/ \;
	find /home/csuser/Desktop/src . -type f -name "*.cpp" -exec  mv -v '{}' /home/csuser/Desktop/$newdirectory3/ \;
	find /home/csuser/Desktop/src . -type f -name "*.cc" -exec  mv -v '{}' /home/csuser/Desktop/$newdirectory3/ \;
	rmdir src
else  echo "Src file created successfully"
fi
fi

if((answer==4))
then
mkdir inc
counter2=$(( $counter2 + 1 ))
echo "inc file created successfully"

echo "########################.HXX FILES:###############################"
find /home/csuser/Desktop/$1 . -type f -name "*.hxx" -exec sh -c '
for file; do
      dest=/home/csuser/Desktop/inc/${file##*/}
      if [ -e "$dest" ]; then
          ls -ld "$dest" "$file"
          read -p "Enter new name for the second,or just ENTER to overwrite the first: " newname
          if [ "$newname" != "" ]; then
                dest=/home/csuser/Desktop/inc/${newname##*/}
            fi
        fi
        mv "$file" "$dest"
    done' /home/csuser/Desktop/inc/ {} \;

echo "########################.H FILES:#############################"
find /home/csuser/Desktop/$1 . -type f -name "*.h" -exec sh -c '
for file; do
      dest=/home/csuser/Desktop/inc/${file##*/}
      if [ -e "$dest" ]; then
          ls -ld "$dest" "$file"
          read -p "Enter new name for the second,or just ENTER to overwrite the first: " newname
          if [ "$newname" != "" ]; then
                dest=/home/csuser/Desktop/inc/${newname##*/}
            fi
        fi
        mv "$file" "$dest"
    done' /home/csuser/Desktop/inc/ {} \;

echo "###################################################"
read -p " Do you want to use another directory than inc?[Y|N]:" transport4
 if [ "$transport4" == "y" ]; then
	read -p "Name the new directory:" newdirectory4
	mkdir $newdirectory4
	find /home/csuser/Desktop/inc . -type f -name "*.h" -exec  mv -v '{}' /home/csuser/Desktop/$newdirectory4/ \;
	find /home/csuser/Desktop/inc . -type f -name "*.hxx" -exec  mv -v '{}' /home/csuser/Desktop/$newdirectory4/ \;
	rmdir inc
else  echo "Inc file created successfully"
fi
fi

counter=$(( $counter - 1 ))
echo "Remaining attempts: $counter "

if((answer==5))
then
	echo " The programm ended."
	exit
fi
echo "Total directories scanned $var3 "
echo "Total files scanned : $var2 "
done
echo "Total new directories created: $counter2"
echo "END OF PROGRAMM. "