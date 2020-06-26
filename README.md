# 安装
```
bundle install
bundle exec rake app:update:bin
```

# 开启数据库

```
docker ps -a // 查找上次容器
docker restart [容器id]
```
若是第一次开启数据库，请运行

```
docker run -v more-rails-1-data:/var/lib/postgresql/data -p 5001:5432 -e POSTGRES_USER=freda -e POSTGRES_PASSWORD=123456  -d postgres:12.2
```
其中

+ more-rails-1-data 是数据库目录名，可以替换为任意目录名，也可以替换为绝对路径
+ 5001 是数据库服务端口名，可以随意替换，但要确保 database.yml 也作对应修改
+ POSTGRES_USER=ha 是用户名，可以随意替换，但要确保 database.yml 也作对应修改
+ POSTGRES_PASSWORD=123456 是密码，可以随意替换，但要确保 database.yml 也作对应修改

# 配置 database.yml
1. Mac / Linux / Docker for Windows 用户，请将 database.yml 中的 hosts 替换为 localhost
2. Docker Toolbox for Windows 用户，请将 database.yml 中的 hosts 替换为 docker-machine ip 的结果

# 创建数据库

`bin/rails db:create`

# 删除数据库

`bin/rails db:drop`

# 运行 server

`bin/rails s`

# docker 常用命令

```
docker ps -a // 查看所有容器
docker kill [container id] // 关闭[container id]容器
docker restart [container id] //重启[container id]容器
docker rm [container id] //删除[container id]容器
docker container prune //删除无用容器
```