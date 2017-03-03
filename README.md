# 目的
为了彻底弄清AXI读写时序，以及以后更好的使用DDR3 IP，会对demo结构进行彻底改造。

# 步骤
1. 使用demo程序进行仿真，弄清程序结构，AXI读写基本时序

2. 将产生AXI信号的`mig_7series_v1_9_axi4_tg`模块转移到顶层tb

3. 按照自己理解重写AXI操作模块

4. 使用sv文件重写testbench

# AXI使用
## 配置选项
1. AWLEN and AWSIZE
    AWLEN，表示一次突发写事务中传输的单位个数

    ![pic][1]        

    AWSIZE，表示每个单位数据长度

    ![pic][2]        


    ![pic][3]        

    demo里，awlen = 2，awsize = 6
    根据上表可知，每次突发写3个单位，每个单位有64字节（512bit） 

2. WSTRB[n:0]，写选通
    位宽 = 写数据宽度/8，每位代表一个字节
    为1时，数据写入

# NOTE


[1]: https://coding.net/u/kdurant/p/axi_ddr3/git/raw/master/docs/pic/axi_burst_length.png
[2]: https://coding.net/u/kdurant/p/axi_ddr3/git/raw/master/docs/pic/axi_burst_size.png
[3]: https://coding.net/u/kdurant/p/axi_ddr3/git/raw/master/docs/pic/awid%253D%253D0.png
[4]: https://coding.net/u/kdurant/p/axi_ddr3/git/raw/master/docs/pic/awid%253D%253D1.png
