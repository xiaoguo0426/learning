#!/bin/bash

# 获取当前使用的内核版本
current_kernel=$(uname -r)

# 获取所有已安装的内核版本
installed_kernels=$(dpkg --list | grep 'linux-image' | awk '{print $2}' | grep -v "$current_kernel")

# 保留当前使用的内核和一个旧版本
keep_kernel=$(echo "$installed_kernels" | tail -n 1)

# 生成要删除的内核列表
kernels_to_remove=$(echo "$installed_kernels" | grep -v "$keep_kernel")

# 删除旧内核
for kernel in $kernels_to_remove; do
    sudo dpkg --purge "$kernel"
    sudo dpkg --purge "${kernel/linux-image/linux-headers}"
done

# 清理残留文件
sudo apt-get autoremove

# 更新GRUB配置
sudo update-grub