CC = gcc 
CFLAGS = -g -c -Wall


SRC = $(wildcard ./*.c)
EXE = main
TEST_NUM = 20


.PHONY: clean gen_test_data test test_by_shellsh test_by_bats
all: $(EXE)

$(EXE): $(SRC)
	$(CC) $^ -o $@

test: gen_test_data test_by_shellsh test_by_bats test_by_shunit2

gen_test_data: random_test.sh
	sh random_test.sh $(TEST_NUM)


# can be more simpler
test_by_shellsh: test_by_shellsh.sh
	sh test_by_shellsh.sh ./$(EXE) $(TEST_NUM)

test_by_bats: test_by_bats.sh
	bats test_by_bats.sh

test_by_shunit2: test_by_shunit2.sh
	sh test_by_shunit2.sh

clean:
	rm $(EXE)
	rm -r test_data