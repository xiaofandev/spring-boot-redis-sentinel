FROM centos:centos7

RUN yum update -y

# 安装redis
RUN yum install -y epel-release
RUN yum install -y redis

# 创建目录
RUN mkdir -p /etc/redis-conf

# 拷贝文件到镜像中
COPY redis/* /etc/redis-conf

# 暴露redis端口
EXPOSE 6379
EXPOSE 6380
EXPOSE 6381

# 暴露sentinel端口
EXPOSE 26379
EXPOSE 26380
EXPOSE 26381

### 以下配置为了支持ssh登录 ###
# 安装依赖
RUN yum install -y net-tools openssh-server openssh-clients python3 sudo curl wget bash-completion openssl sshpass && yum clean all

# 设置root密码
RUN echo 'root:root' | chpasswd

# 生成SSH host keys.
RUN ssh-keygen -A

EXPOSE 22

# 后台启动sshd
CMD ["/usr/sbin/sshd", "-D"]
