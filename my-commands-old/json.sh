#!/usr/bin/env bash

set -euo pipefail

usage() {
    cat << 'EOF'
JSON 格式化工具
用法: json [选项] [文件|JSON字符串]

选项:
    -c, --compact     压缩输出（单行）
        json -c '{
                    "a": 1
                }'

    -i N, --indent N  缩进空格数（默认: 2）
    --no-color        禁用颜色输出
    -h, --help        显示此帮助信息
    -v, --version     显示版本

示例:
    json data.json
    json -c data.json
    json '{"a":1}'
    echo '{"a":1}' | json

EOF
}

version() {
    echo "json 1.0.0"
}

main() {
    local compact=0
    local indent=2
    local color=1
    local input_source=""
    local input_file=""

    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -c|--compact)
                compact=1
                shift
                ;;
            -i|--indent)
                if [[ $2 =~ ^[0-9]+$ ]]; then
                    indent="$2"
                    shift 2
                else
                    echo "错误: 缩进必须是数字" >&2
                    return 1
                fi
                ;;
            --no-color)
                color=0
                shift
                ;;
            -h|--help)
                usage
                return 0
                ;;
            -v|--version)
                version
                return 0
                ;;
            -*)
                echo "错误: 未知选项 $1" >&2
                usage >&2
                return 1
                ;;
            *)
                input_file="$1"
                shift
                break
                ;;
        esac
    done

    # 确定输入源
    if [ -t 0 ] && [ -z "$input_file" ]; then
        # 既没有标准输入也没有文件参数
        echo "错误: 需要输入数据" >&2
        usage >&2
        return 1
    fi

    # 构建 jq 命令
    local jq_cmd="jq"
    if [ $compact -eq 1 ]; then
        jq_cmd="$jq_cmd -c"
    else
        jq_cmd="$jq_cmd --indent $indent"
    fi

    if [ $color -eq 0 ]; then
        jq_cmd="$jq_cmd -M"
    fi

    # 处理输入
    if [ -n "$input_file" ]; then
        if [ -f "$input_file" ]; then
            # 从文件读取
            if ! $jq_cmd . "$input_file" >/dev/null 2>&1; then
                echo "错误: 文件 '$input_file' 包含无效的 JSON" >&2
                return 1
            fi
            $jq_cmd . "$input_file"
        else
            # 从字符串参数读取
            if ! echo "$input_file" | $jq_cmd . >/dev/null 2>&1; then
                echo "错误: 参数不是有效的 JSON 字符串" >&2
                return 1
            fi
            echo "$input_file" | $jq_cmd .
        fi
    else
        # 从标准输入读取
        local input_data
        input_data=$(cat)
        if [ -z "$input_data" ]; then
            echo "错误: 标准输入为空" >&2
            return 1
        fi

        if ! echo "$input_data" | $jq_cmd . >/dev/null 2>&1; then
            echo "错误: 标准输入包含无效的 JSON" >&2
            return 1
        fi
        echo "$input_data" | $jq_cmd .
    fi
}

main "$@"
