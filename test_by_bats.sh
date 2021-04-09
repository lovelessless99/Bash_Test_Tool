exe="./main"

test_num=20
test_dir="test_data/test"
test_ans="test_data/ans"

function test_file()
{
        run bash -c "${exe} $(cat ${test_dir}/test_$1.txt) | diff -q -w ${test_ans}/ans_$1.txt -"
        [[ $output == "" ]]        
}

@test "============ Test 1 ============" {
        test_file 1
}
@test "============ Test 2 ============" {
        test_file 2
}
@test "============ Test 3 ============" {
        test_file 3
}
@test "============ Test 4 ============" {
        test_file 4
}
@test "============ Test 5 ============" {
        test_file 5
}

@test "============ Test 6 (diff without ignoring newline in the end)============" {
        run bash -c "${exe} $(cat ${test_dir}/test_2.txt) | diff -q ${test_ans}/ans_2.txt -"
        [[ $output == "" ]]   
}

@test "============ Test 7 ============" {
        run bash -c "${exe} $(cat ${test_dir}/test_2.txt) | diff ${test_ans}/ans_2.txt -"
        [[ $output == "" ]]   
}


