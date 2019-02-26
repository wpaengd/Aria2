#!/bin/bash
# Aria2 的配置文件路径
confPath=/Users/XXX/.aria2/aria2.conf
# 更新前杀掉 aria2 进程
killall aria2
echo "updating......"
# 从 https://github.com/ngosang/trackerslist 获取最新 trackers
# 并将文本中的换行替换成,
list=`wget -qO- https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all_ip.txt | awk NF | tr "\n" ","`
if [ -n "$list" ]; then
    # 把 trackers 更新到 aria2 的配置文件中
    sed -i "" "s@bt-tracker.*@bt-tracker=$list@g" ${confPath} && \
    # 重启 aria2
    aria2c --conf-path="${confPath}" -D && \
    echo "Done!"
else
    echo "获取 trackers 错误"
fi