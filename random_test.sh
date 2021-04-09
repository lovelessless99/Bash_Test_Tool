#!/bin/bash

raw_dir="test_data/test"
ans_dir="test_data/ans"

function create_dir()
{
        for dir in "$@"; 
        do
                if [[ ! -x ${dir} ]]; then
                        mkdir -p ${dir}
                fi
        done
}

function random_range()
{
        local total_data=$(shuf -i 100-500 -n 1)
        local test_data=$(shuf -i $1-$2 -n ${total_data})
        echo ${test_data[@]}
}


function generate_test_data()
{
        local num_test_data=$1
        local random_min=1
        local random_max=2000

        for i in `seq ${num_test_data}`; 
        do
                data=$(random_range ${random_min} ${random_max})
                
                # like list-conprehension
                local order_sorted=( $(echo ${data[*]} | tr ' ' '\n' | sort -n | tr ' ' '\n') )
                local rev_order_sorted=( $(echo ${data[*]} | tr ' ' '\n' | sort -n -r | tr ' ' '\n') )
                
                echo ${data[*]} > ${raw_dir}"/test_$i.txt"
                echo ${order_sorted[@]} > ${ans_dir}"/ans_$i.txt"
                echo ${rev_order_sorted[@]} >> ${ans_dir}"/ans_$i.txt"
        done
}

function main()
{
        create_dir ${raw_dir} ${ans_dir}
        generate_test_data $1
}

if [[ "$#" -lt 1 ]]; then
        echo "No assign the # of test data, ex: sh random_test.sh 10 "
        exit 1
fi
main $1