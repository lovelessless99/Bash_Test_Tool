#!/bin/bash

function test_file()
{
        local exe="./main"
        local test_num=20
        local test_dir="test_data/test"
        local ans_dir="test_data/ans"
        for i in `seq ${test_num}`;
        do
        result=$(${exe} $(cat ${test_dir}/test_1.txt) | diff -q -w ${ans_dir}/ans_1.txt -)
        assertNotNull 'test failed' ${result}
        done
}

testEquality() {
  assertEquals 1 1
}

testEmpty(){
        assertNull ""
}


. shunit2