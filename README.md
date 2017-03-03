# 目的
为了彻底弄清AXI读写时序，以及以后更好的使用DDR3 IP，会对demo结构进行彻底改造。

# 步骤
1. 使用demo程序进行仿真，弄清程序结构，AXI读写基本时序

2. 将产生AXI信号的`mig_7series_v1_9_axi4_tg`模块转移到顶层tb

3. 按照自己理解重写AXI操作模块

4. 使用sv文件重写testbench

# NOTE
