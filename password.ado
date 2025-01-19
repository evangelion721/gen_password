cap program drop password
cap program drop code1
cap program drop code2

// 定义主程序
program define password,rclass
    version 16.0
    
    // 检查参数
    if "`0'" == "" {
        display as error "语法错误：需要输入字符串和选项"
        display as text "正确语法: passcode string, [code1|code2]"
        exit 198
    }
	     
		 
		 // 解析参数和选项
    syntax anything [, code1 code2]  
	
    // 解析参数
    gettoken string number : anything
    if "`string'" == "" {
        display as error "缺少字符串参数"
        exit 198
    }
 
   
	
    // 根据选项调用相应的程序
    if "`code1'" != "" {
        code1  `string' `number'
    }
    else if "`code2'" != "" {
        code2  `string' `number'
    }
    else {
        display as error "必须指定选项 code1 或 code2"
        exit 198
    }
end

// code1 程序：向后移动steps位
cap program drop code1
program define code1
    args input steps
    local len = strlen("`input'")
    local output ""
    
    // 逐字符处理
    forvalues i = 1/`len' {
        local char = substr("`input'", `i', 1)       
            local pos =     strpos("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*_-.", "`char'")
			
			local newpos = `pos' + `steps'
			
            while `newpos' > 73 {
                local newpos = `newpos' - 73 
            }
			
            local newchar = substr("a3DF9GHfghiluvEwcyb2B1jkxrs4VI06JmPQYZ7no5zACtORSTUKLMNpqdeWX8!@#$%^&*_-.", `newpos', 1)
            local output = "`output'`newchar'"
        }   
    display "`output'"
end

// code2 程序：向前移动steps位
cap program drop code2
program define code2
    args input steps
    local len = strlen("`input'")
    local output ""
    
    // 逐字符处理
    forvalues i = 1/`len' {
        local char = substr("`input'", `i', 1)       
            local pos = strpos("a3DF9GHfghiluvEwcyb2B1jkxrs4VI06JmPQYZ7no5zACtORSTUKLMNpqdeWX8!@#$%^&*_-.", "`char'")
			
			local newpos = `pos' - `steps'
            while `newpos' <= 0 {
                local newpos = 73 - abs(`newpos')  
            }
			
            local newchar = substr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*_-.", `newpos', 1)
            local output = "`output'`newchar'"
        }   
    display "`output'"
end
