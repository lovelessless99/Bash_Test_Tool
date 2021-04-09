#!/bin/bash



function test_all_file()
{ 
        
            for i in `seq ${test_num}`;
            do
                  echo -e "\e[104m============ Test $i ============\e[49m"
                  
                  # "-" read from standard input
                  # diff -q (short report) -w (ignore the last newline)
                  result=$(${exe} $(cat $1/test_$i.txt) | diff -q -w $2/ans_$i.txt -)
                  
                  if [[ ${result} == "" ]]; 
                  then
                        echo -e "\e[92mTest $i Success!\e[39m"
                  else 
                        echo -e "\e[91mTest $i Failed!\e[39m"
                  fi

            done
}


if [[ $# -lt 2 ]]; then
      echo -e "\e[91mNot enough param; ex: sh test.sh [exe_file_name] [test_num]\e[39m"
      exit 1
fi

exe=$1
test_num=$2
test_all_file "test_data/test" "test_data/ans"