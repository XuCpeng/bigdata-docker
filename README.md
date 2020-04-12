# BigData-docker

使用docker创建hadoop集群或Spark集群

- hadoop version: hadoop-3.2.1
- spark version: spark-3.0.0-preview2-bin-hadoop3.2
- jdk version: AdoptOpenJDK8U-jdk_x64_linux_hotspot_8u242b08

## 如何使用

### 配置集群（可选）

你可以编辑`hadoop-base`和`spark-base`文件夹下的配置文件来配置集群，这些文件会覆盖docker镜像中对应的配置文件,修改之后需要重新创建集群才能生效。

### 创建集群

只创建hadoop集群：

```bash
docker-compose -f "haddop-cluster\docker-compose.yml" up -d --build
```

创建hadoop和spark集群：

```bash
docker-compose -f "spark-cluster\docker-compose.yml" up -d --build
```

#### 容器结构

```bash
Successfully tagged spark-cluster_spark-master:latest
Creating hadoop-slave1 ... done
Creating hadoop-slave2 ... done
Creating hadoop-slave3 ... done
Creating spark-slave2  ... done
Creating spark-slave1  ... done

Creating hadoop-master ... done
Creating spark-master  ... done
```

#### 默认端口

- Spark web: <http://localhost:8080/>
- hadoop web: <http://localhost:50070/>
- Spark Master at spark://spark-master:7077  已映射到 localhost:7077
- hdfs://hadoop-master:8020  已映射到 localhost:8020

#### 文件数据

- spark、hadoop和jdk均在`/opt`目录下
- hdfs的数据文件在`/opt/data`目录下

## 其他说明

- jdk、spark、hadoop均为编译时通过网络下载，可在`hadoop-base/Dockerfile`和`spark-base/Dockerfile`中更改下载链接(默认均为清华镜像的链接)。
- apt软件源更改为了清华源，如果不需要更改请删除`hadoop-base/Dockerfile`和`spark-base/Dockerfile`中的`COPY sources.list /etc/apt/`语句。
- 支持`xcall`命令，在`hadoop-master`中运行`xcall command`，`command`将在hadoop-master和hadoop-slave上运行。例如`xcall jps`。
