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

3. wid和rid可以不一致。例如：wid = 1， rid = 2，只要操作地址一致，就可以正确读出数据
    
4. 读写地址

设 地址增量为 I（axi写数据通道位宽/8)

读写地址均为ddr3 memory中以byte为单位的地址。设置的写入地址最好为'h40的整数倍

例如：写数据端口位宽为512bit，awlen = 2，awaddr = 0，则写入数据的地址分别为`'h00，'h40，'h80`

读地址增量同理。

当写地址不是 I 的整数倍时，实际写取数据的地址为：(raddr/'h40)`*`'h40

当读地址不是 I 的整数倍时，实际读取数据的地址为：(raddr/'h40)`*`'h40

```
# awid: 1, awaddr:0x00000000, awlen:  2, awsize:6, wdata:0xfffffffffffffffffffffee47dadc
# awid: 1, awaddr:0x00000000, awlen:  2, awsize:6, wdata:0xfffffffffffffffffffffbaa68e75
# awid: 1, awaddr:0x00000000, awlen:  2, awsize:6, wdata:0xffffffffffffffffffffff5984aeb

# arid: 1, araddr:0x00000020, arlen:  2, arsize:6, rdata:0xfffffffffffffffffffffee47dadc
# arid: 1, araddr:0x00000020, arlen:  2, arsize:6, rdata:0xfffffffffffffffffffffbaa68e75
# arid: 1, araddr:0x00000020, arlen:  2, arsize:6, rdata:0xffffffffffffffffffffff5984aeb

# arid: 1, araddr:0x00000040, arlen:  2, arsize:6, rdata:0xfffffffffffffffffffffbaa68e75
# arid: 1, araddr:0x00000040, arlen:  2, arsize:6, rdata:0xffffffffffffffffffffff5984aeb
# arid: 1, araddr:0x00000040, arlen:  2, arsize:6, rdata:0x1111111111111bbbbbbbbbbbbbbbb

# arid: 2, araddr:0x00000060, arlen:  2, arsize:6, rdata:0xfffffffffffffffffffffbaa68e75
# arid: 2, araddr:0x00000060, arlen:  2, arsize:6, rdata:0xffffffffffffffffffffff5984aeb
# arid: 2, araddr:0x00000060, arlen:  2, arsize:6, rdata:0x1111111111111bbbbbbbbbbbbbbbb

# arid: 1, araddr:0x00000080, arlen:  2, arsize:6, rdata:0xffffffffffffffffffffff5984aeb
# arid: 1, araddr:0x00000080, arlen:  2, arsize:6, rdata:0x1111111111111bbbbbbbbbbbbbbbb
# arid: 1, araddr:0x00000080, arlen:  2, arsize:6, rdata:0x112a4e737ea01e08112a4e737ea01

# arid: 2, araddr:0x000000a0, arlen:  2, arsize:6, rdata:0xffffffffffffffffffffff5984aeb
# arid: 2, araddr:0x000000a0, arlen:  2, arsize:6, rdata:0x1111111111111bbbbbbbbbbbbbbbb
# arid: 2, araddr:0x000000a0, arlen:  2, arsize:6, rdata:0x3cf43e61de915ef63cf43e61de915

# arid: 1, araddr:0x000000c0, arlen:  2, arsize:6, rdata:0x1111111111111bbbbbbbbbbbbbbbb
# arid: 1, araddr:0x000000c0, arlen:  2, arsize:6, rdata:0x65f9b314c56cb84365f9b314c56cb
# arid: 1, araddr:0x000000c0, arlen:  2, arsize:6, rdata:0x65f9b314c56cb84365f9b314c56cb
```

# DDR3 IP默认配置
主要针对example_top.v，这个模块里调用DDR3 IP
1. sys_clk_p, sys_clk_n, 输入400MHz差分时钟，
2. clk_ref_p, clk_ref_n, 输入200MHz差分时钟，
3. sys_rst, 低电平复位
4. demo里驱动模块主频100MHz

# NOTE


[1]: https://raw.githubusercontent.com/kdurant/axi-ddr3/master/docs/pic/axi_burst_length.png
[2]: https://raw.githubusercontent.com/kdurant/axi-ddr3/master/docs/pic/axi_burst_size.png
[3]: https://raw.githubusercontent.com/kdurant/axi-ddr3/master/docs/pic/awid%3D%3D0.png


