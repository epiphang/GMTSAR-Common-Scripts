#!/bin/bash
#把trans.dat文件链接到所有干涉对文件夹中。为大气校正做准备。脚本 link_transdat.csh文件放置于 /home/zyz/SARwork/YNC_SBAS/F3/intf_all目录下。


# 定义源文件路径和目标目录模式
transdat_source="/home/zyz/SARwork/YNC_SBAS/F3/topo/trans.dat"
target_directory_pattern="2*_2*"

echo "开始链接 trans.dat 文件..."

# 检查源文件是否存在
if [[ ! -f "$transdat_source" ]]; then
    echo "错误: 源文件 $transdat_source 不存在!"
    exit 1
fi

# 遍历当前目录下所有符合模式的目标目录
for dir in $target_directory_pattern/; do
    # 确保是目录而不是文件
    if [[ -d "$dir" ]]; then
        target_path="${dir}trans.dat"
        
        # 如果链接已存在，先删除
        if [[ -L "$target_path" ]]; then
            rm "$target_path"
            echo "已移除现有链接: $target_path"
        fi
        
        # 创建符号链接
        ln -s "$transdat_source" "$target_path"
        echo "已创建链接: $target_path -> $transdat_source"
    fi
done

echo "操作完成!"
