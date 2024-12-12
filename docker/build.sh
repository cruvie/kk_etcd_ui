

cd ..

#docker build -t kk_etcd_ui_local -f docker/Dockerfile .

# 本地构建测试
# docker build -t kk_etcd_ui_local -f docker/Dockerfile .
# docker run --name kk_etcd_ui_local -p 2334:80  kk_etcd_ui_local


# 多平台构建-发布
#  docker login 可以先登陆docker desktop
 docker buildx build --platform linux/amd64,linux/arm64 -t cruvie/kk_etcd_ui:1.4.1 -f docker/Dockerfile . --push


# 测试
# docker pull cruvie/kk_etcd_ui:1.4.1
# docker run --name kk_etcd_ui -p 2334:80 cruvie/kk_etcd_ui:1.4.1

