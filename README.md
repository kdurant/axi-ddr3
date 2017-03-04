# 目的
为了彻底弄清AXI读写时序，以及以后更好的使用DDR3 IP，会对demo结构进行彻底改造。

# 步骤
1. 使用demo程序进行仿真，弄清程序结构，AXI读写基本时序

2. 将产生AXI信号的`mig_7series_v1_9_axi4_tg`模块转移到顶层tb

3. 按照自己理解重写AXI操作模块

4. 使用sv文件重写testbench

# AXI使用
## 配置选项
### WSTRB[n:0]，写选通
    位宽 = 写数据宽度/8，每位代表一个字节
    为1时，数据写入

### AWLEN 

    AWLEN，表示一次突发写事务中传输的单位个数

    ![pic][1]        

### AWSIZE

    AWSIZE，表示每个单位数据长度

    ![pic][2]        


    ![pic][3]        

    demo里，awlen = 2，awsize = 6
    根据上表可知，每次突发写3个单位，每个单位有64字节（512bit） 

### 读写操作
1. 可以在`awvalid`有效的时候改变写配置选项


2. master写好地址和ID后，发送arvalid信号，等待arready， 然后发送rready，在rready和rvalid同时有效期间出数据

    ![pic][5]        

3. wid和rid可以不一致。例如：wid = 1， rid = 2，只要操作地址一致，就可以正确读出数据
    
4 . 单次写地址（addr = 0）后，读其他地址（addr = 10）时，还可以读出上次写的数据
```
# awid: 1, awaddr:0x00000000, awlen:  2, awsize:6, wdata:0x0000000000dadc
# awid: 1, awaddr:0x00000000, awlen:  2, awsize:6, wdata:0x00000000008e75
# awid: 1, awaddr:0x00000000, awlen:  2, awsize:6, wdata:0x00000000000001

# arid: 1, araddr:0x0000003f, arlen:  2, arsize:6, rdata:0x0000000000dadc
# arid: 1, araddr:0x0000003f, arlen:  2, arsize:6, rdata:0x00000000008e75
# arid: 1, araddr:0x0000003f, arlen:  2, arsize:6, rdata:0x00000000000001

# arid: 1, araddr:0x00000040, arlen:  2, arsize:6, rdata:0x00000000008e75
# arid: 1, araddr:0x00000040, arlen:  2, arsize:6, rdata:0x00000000000001
# arid: 1, araddr:0x00000040, arlen:  2, arsize:6, rdata:0xbbbbbbbbbbbbbb

# arid: 1, araddr:0x00000041, arlen:  2, arsize:6, rdata:0x00000000008e75
# arid: 1, araddr:0x00000041, arlen:  2, arsize:6, rdata:0x00000000000001
# arid: 1, araddr:0x00000041, arlen:  2, arsize:6, rdata:0xbbbbbbbbbbbbbb

# arid: 1, araddr:0x00000060, arlen:  2, arsize:6, rdata:0x00000000008e75
# arid: 1, araddr:0x00000060, arlen:  2, arsize:6, rdata:0x00000000000001
# arid: 1, araddr:0x00000060, arlen:  2, arsize:6, rdata:0xbbbbbbbbbbbbbb


# arid: 1, araddr:0x0000007f, arlen:  2, arsize:6, rdata:0x00000000008e75
# arid: 1, araddr:0x0000007f, arlen:  2, arsize:6, rdata:0x00000000000001
# arid: 1, araddr:0x0000007f, arlen:  2, arsize:6, rdata:0xbbbbbbbbbbbbbb

# arid: 1, araddr:0x00000080, arlen:  2, arsize:6, rdata:0x00000000000001
# arid: 1, araddr:0x00000080, arlen:  2, arsize:6, rdata:0xbbbbbbbbbbbbbb
# arid: 1, araddr:0x00000080, arlen:  2, arsize:6, rdata:0xe2d667481efa16

# arid: 1, araddr:0x00000081, arlen:  2, arsize:6, rdata:0x00000000000001
# arid: 1, araddr:0x00000081, arlen:  2, arsize:6, rdata:0xbbbbbbbbbbbbbb
# arid: 1, araddr:0x00000081, arlen:  2, arsize:6, rdata:0x84bfa600786ac0

# arid: 1, araddr:0x00000100, arlen:  2, arsize:6, rdata:0xf60defa534ff55
# arid: 1, araddr:0x00000100, arlen:  2, arsize:6, rdata:0xf60defa534ff55
# arid: 1, araddr:0x00000100, arlen:  2, arsize:6, rdata:0xf60defa534ff55
```
待总结
# NOTE


[1]: https://coding.net/u/kdurant/p/axi_ddr3/git/raw/master/docs/pic/axi_burst_length.png
[2]: https://coding.net/u/kdurant/p/axi_ddr3/git/raw/master/docs/pic/axi_burst_size.png
[3]: https://coding.net/u/kdurant/p/axi_ddr3/git/raw/master/docs/pic/awid%253D%253D0.png
[4]: https://coding.net/u/kdurant/p/axi_ddr3/git/raw/master/docs/pic/awid%253D%253D1.png
[5]: https://coding.net/u/kdurant/p/axi_ddr3/git/raw/master/docs/pic/arid%253D%253D0.png
