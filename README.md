# Bash 自動化測試的工具
靈感來自於這篇 stackoverflow [討論](https://stackoverflow.com/questions/1339416/unit-testing-bash-scripts)


## 1. 自己動手寫 shell script
不依賴任何框架，並且搭配 diff 及 bash 顏色編碼 就可以做出不錯的

```bash
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
                        echo -e "\e[，91mTest $i Failed!\e[39m"
                  fi

            done
}
```
## 2. bats
> [Github link](https://github.com/sstephenson/bats)
> [Tutorial link](https://bats-core.readthedocs.io/en/latest/writing-tests.html)
> [參考文章](https://blog.engineyard.com/bats-test-command-line-tools)
* 一個 bash 測試的框架
* 使用框架定義的關鍵字 (有點像 bash 但又不像 bash)
* 有幫你用 syntex highlight
* 只能使用 runtime variable 來從外面傳參數進去 [相關討論](https://github.com/sstephenson/bats/issues/204)

> [此篇討論](https://github.com/sstephenson/bats/issues/136)
> 作者說有很多個test case，很多人想用 for-loop 去重複化程式碼，但是 `@test` 關鍵字相當於函數，包在 for-loop 內只是重複定義數次，且 bats 不是直譯器，頂多只能算關鍵字串處理的前處理器，所以仍需要把 case 分開寫
 


```bash
sudo apt install bats
```

`run` 指令相當於 Unix Commands，用 pipe時要注意，使用時
```bash
run bash -c ["有 pipe 的指令"]
[[ $output == ... ]]
```


## 3. shunit2
> [Github Link](https://github.com/kward/shunit2)
> [參考教學](https://ephrain.net/linux-%E7%94%A8-shunit2-%E4%BE%86%E5%81%9A-shell-script-%E7%9A%84-unit-testing/)

* 可以無痛接軌 bash script
* 寫起來簡單
* 無法傳參數到 test function 內

```bash
sudo apt install shunit2
```

----
# 專案執行
```bash
make ; make -i test
```



