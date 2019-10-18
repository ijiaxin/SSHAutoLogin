#!/bin/bash

##
#getopt参考文档
# https://linuxeye.com/389.html
# https://www.jianshu.com/p/6393259f0a13
# mac getopt 不能使用问题需安装brew install gnu-getopt
# https://stackoverflow.com/questions/23630424/getopt3-on-mac-os-and-centos
##

function helpInfo(){
    echo "mac环境ssh连接工具
h | help    帮助文件
list        服务器列表  ssh_login list
其他         快速连接服务器  ssh_login 1
config      服务器配置文件 ssh_login --config=./config/mdd.config
    格式：
        端口号  IP     登录用户名    登录密码/秘钥文件Key    别名   服务器名称/备注    秘钥文件地址

";
}
#-o或--options选项后面是可接受的短选项，如ab:c::，表示可接受的短选项为-a -b -c，
#其中-a选项不接参数，-b选项后必须接参数，-c选项的参数为可选的
#-l或--long选项后面是可接受的长选项，用逗号分开，冒号的意义同短选项。
#-n选项后接选项解析错误时提示的脚本名字
ARGS=`getopt -o h --long help,config: -n "$0" -- "$@"`
if [ $? != 0 ]; then
    echo "Terminating..."
    exit 1
fi

#将规范化后的命令行参数分配至位置参数（$1,$2,...)
eval set -- "${ARGS}"
#echo $ARGS
#helpInfo
#exit
while true
do
    case "$1" in
        --config)
            sshloginrc_path=$2
            shift 2
            ;;
        -h|--help)
            helpInfo
            exit 1
            ;;
        --)
            shift
            break
            ;;
        *)
            echo
            helpInfo
            exit 1
            ;;
    esac
done
