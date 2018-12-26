#!/bin/bash
#如果用户没有输入时间，则默认时间间隔为30s
#监控的内存是系统的内存，不是进程的内存
interval=30
if [ "$1" != "" ]
then
interval=$1
fi
echo "检查时间间隔(单位秒)："$interval
datetime=`date +'%Y%m%d'`
echo""> /usr/script/info-$datetime
#无限循环
while :
do
echo `date +'%Y%m%d %H:%M:%S'` >> /usr/script/info-$datetime
cat /proc/meminfo | grep  -E 'MemTotal|MemFree|Cached' |grep -v SwapCached|xargs >>/usr/script/info-$datetime    
#top -b -d 1 -n 1 |grep -E "PID.*USER|load|Cpu|Data" >> /usr/script/info-$datetime
top -b -d 1 -n 1 -p 13067 >> /usr/script/info-$datetime
sleep $interval
echo "-------------------------------------" >> /usr/script/info-$datetime
done

#如果要看进程的内存，可以使用cat /proc/[pid]/status,看其中的VmRSS的值（表示占用的物理内存）
#top命令得出的值中，PID:进程的ID，VIRT：进程占用的虚拟内存，RES：进程占用的物理内存
# %CPU：进程占用cpu的使用率，%MEM：进程使用的物理内存和总内存的百分比，TIME+：该进程启动后占用的总的CPU时间
