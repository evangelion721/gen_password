# password.ado 说明
## 你又密码错误了？
你一定有过这样的经历：试图登录一个网站，却总被提示“密码错误”。\
事实上，你并非不记得密码，你只是不记得这个网站的**密码规则**: 
>是最简单的密码，还是需要有大小写字母，亦或是必须包含了特殊字符？

    
最后，你不得不重新设定密码；而重新设定的密码显然不会是你最常用的那个，它是你的第二，甚至第三选择。\
这样的结果是：下次你试图登录该网站时，仍然会被“密码错误”的提示拦住。

你当然可以对所有的网站都设定相同的高度复杂的密码，这样就不会被网站的不同规则给困住。但又会产生另一个问题，即便是经常浏览的网站，你也需要进行复杂的操作：来回切换大小写，不断按住shift键输入特殊字符。  
这大大影响了你的上网体验和效率——更别提你还需要对若干年前已经设置的简单密码进行修改这么麻烦的事。

## 记录和加密
所以，你可能需要一个记事本，就像手机出现之前的电话薄一样，把所有网站和对应的密码都记录在上面，才能避免被“密码错误”挡住。但记事本却存在泄密的风险，无论是纸质的还是电子的，Chrome就曾发生过泄密的风险。

因此，你不仅需要**记录密码**，你还需要**加密密码**。
你把网站和对应的加密密码储存在电子文档中，当不记得密码时，只需打开记事本，找到对应的密码进行解密即可。

## password.ado 
password.ado文件可以实现这一功能。

> syntax: password  密码字符串   数字, [code1 | code2]
>
> 其中，code1是加密；code2是解密。

该命令的原理很简单。存在两个“密码本”，根据第一个密码本可以得到密码的每一个字符串的位置；然后在第二个密码本的对应位置中找到相应的字符，作为加密的密码。

值得注意的是，第二个密码本中的对应位置并不是固定的，而是需要你通过步长（一个数字）来设定。这点非常重要，也是这个命令**最妙**的地方。  

步长的设定意味着：同样的密码，根据不同的步长，将得到不同的加密密码。也就是，即便这个ado文档被人打开——即“密码本”暴露——但由于<ins>对方不知道你加密的步长，也无法反向推算出你的密码</ins>。

换言之，使用password.ado进行加密，你当然不需要记住若干个繁琐的密码，但也并非将“秘密”完全暴露在有可能会泄密的互联网上。

你仍然在大脑里保留着一把钥匙，也就是加密解密的步长。

**我们记不住太多的秘密，但也不能毫无秘密。保留一点，一点就可以。**

## 示例
### 示例1
加密，然后解密
>password cd789_@   5,code1
>
>. fg#$%D&
>
>. password fg#$%D& 5, code2
>
>. cd789_@

### 示例2
初始密码相同，但步长不同，因此加密密码便不同。
>password cd789_@   20, code1
>
>. jkHfgyi
>
