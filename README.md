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
