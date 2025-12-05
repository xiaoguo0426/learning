#!/bin/bash

# 对比两个目录下相同文件名文件的hash值

# 定义目录
DIR1="/home/xiaoguo0426/workspace/prizm/file/customer-1"
DIR2="/home/xiaoguo0426/workspace/prizm/file/customer-2"

# 检查目录是否存在
if [ ! -d "$DIR1" ]; then
    echo "错误: 目录 $DIR1 不存在"
    exit 1
fi

if [ ! -d "$DIR2" ]; then
    echo "错误: 目录 $DIR2 不存在"
    exit 1
fi

echo "对比目录:"
echo "  DIR1: $DIR1"
echo "  DIR2: $DIR2"
echo "================================"

# 使用sha256sum进行hash计算和对比
echo "开始对比文件hash值..."
echo ""

# 方法1: 使用md5sum (更快速)
echo "方法1: 使用md5sum对比"
echo "----------------------"

# 临时存储hash值
TMP1=$(mktemp)
TMP2=$(mktemp)

# 计算第一个目录的hash
(cd "$DIR1" && find . -type f -exec md5sum {} \; | sort -k 2 > "$TMP1")

# 计算第二个目录的hash
(cd "$DIR2" && find . -type f -exec md5sum {} \; | sort -k 2 > "$TMP2")

# 对比相同文件名的hash
echo "文件对比结果:"
echo "------------"

# 获取两个目录的共同文件
COMMON_FILES=$(comm -12 <(cut -d' ' -f3- "$TMP1" | sort) <(cut -d' ' -f3- "$TMP2" | sort))

if [ -z "$COMMON_FILES" ]; then
    echo "两个目录中没有相同的文件名"
else
    ALL_MATCH=true
    COUNT=0
    
    for file in $COMMON_FILES; do
        HASH1=$(grep "  $file$" "$TMP1" | cut -d' ' -f1)
        HASH2=$(grep "  $file$" "$TMP2" | cut -d' ' -f1)
        
        if [ "$HASH1" = "$HASH2" ]; then
            echo "✓ $file: 一致"
            ((COUNT++))
        else
            echo "✗ $file: 不一致"
            echo "  DIR1 hash: $HASH1"
            echo "  DIR2 hash: $HASH2"
            ALL_MATCH=false
        fi
    done
    
    echo ""
    echo "统计:"
    echo "  共有文件: $(echo "$COMMON_FILES" | wc -l) 个"
    echo "  一致文件: $COUNT 个"
    
    if $ALL_MATCH; then
        echo "✓ 所有共同文件的hash值都一致"
    else
        echo "✗ 存在不一致的文件"
    fi
fi

# 清理临时文件
rm -f "$TMP1" "$TMP2"

echo ""
echo "================================"
echo ""

# 方法2: 使用diff直接对比（更详细）
echo "方法2: 使用diff对比文件内容"
echo "----------------------------"

# 找出只在一个目录中存在的文件
echo "只在 $DIR1 中存在的文件:"
comm -23 <(cd "$DIR1" && find . -type f | sort) <(cd "$DIR2" && find . -type f | sort) | sed 's/^/  /'

echo ""
echo "只在 $DIR2 中存在的文件:"
comm -13 <(cd "$DIR1" && find . -type f | sort) <(cd "$DIR2" && find . -type f | sort) | sed 's/^/  /'

echo ""
echo "共同文件的内容差异:"
echo "------------------"

# 对比共同文件的内容差异
COMMON_FILES_LIST=$(comm -12 <(cd "$DIR1" && find . -type f | sort) <(cd "$DIR2" && find . -type f | sort))

DIFF_FOUND=false
for file in $COMMON_FILES_LIST; do
    if ! diff -q "$DIR1/$file" "$DIR2/$file" > /dev/null 2>&1; then
        echo "差异文件: $file"
        DIFF_FOUND=true
    fi
done

if ! $DIFF_FOUND; then
    echo "所有共同文件内容一致"
fi

echo ""
echo "================================"
echo ""

# 方法3: 快速验证脚本
echo "方法3: 快速验证脚本"
echo "-------------------"

# 创建一个快速的对比函数
quick_compare() {
    local dir1="$1"
    local dir2="$2"
    
    echo "对比中..."
    
    # 使用shasum (兼容性更好)
    shasum_check=$(cd "$dir1" && find . -type f -exec shasum -a 256 {} \; | sort)
    
    # 也可以使用stat查看文件大小对比
    echo ""
    echo "文件大小对比:"
    echo "文件名                    DIR1大小      DIR2大小     状态"
    echo "--------------------------------------------------------"
    
    for file in $(cd "$dir1" && find . -type f); do
        if [ -f "$dir2/$file" ]; then
            size1=$(stat -f%z "$dir1/$file" 2>/dev/null || stat -c%s "$dir1/$file" 2>/dev/null)
            size2=$(stat -f%z "$dir2/$file" 2>/dev/null || stat -c%s "$dir2/$file" 2>/dev/null)
            
            if [ "$size1" -eq "$size2" ]; then
                status="✓ 大小一致"
            else
                status="✗ 大小不同"
            fi
            
            printf "%-25s %-12s %-12s %s\n" "$file" "$size1" "$size2" "$status"
        fi
    done
}

quick_compare "$DIR1" "$DIR2"

# 最后的总统计
echo ""
echo "================================"
echo "对比完成！"
echo ""
echo "常用命令参考:"
echo "1. 查看单个文件差异: diff \"$DIR1/文件名\" \"$DIR2/文件名\""
echo "2. 查看文件详细信息: ls -la \"$DIR1/\" \"$DIR2/\""
echo "3. 计算单个文件hash: sha256sum \"$DIR1/文件名\""
echo "4. 只检查文件名差异: diff <(cd \"$DIR1\" && find . -type f | sort) <(cd \"$DIR2\" && find . -type f | sort)"
