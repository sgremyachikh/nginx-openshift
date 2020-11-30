FROM centos:centos7

ENV nginxversion="1.18.0-1" \
    os="centos" \
    osversion="7" \
    elversion="7"

RUN yum install -y wget openssl sed curl bind-tools &&\
    yum -y autoremove &&\
    yum clean all &&\
    wget http://nginx.org/packages/centos/7/x86_64/RPMS/nginx-$nginxversion.el$elversion.ngx.x86_64.rpm &&\
    rpm -iv nginx-$nginxversion.el$elversion.ngx.x86_64.rpm

# ---Configuring nginx---
# Resolving running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx && \
    rm -f /etc/nginx/conf.d/default.conf && \
    mkdir -p /usr/share/nginx/html/ /etc/ssl/private /etc/ssl/certs_configmap


EXPOSE 8081 8443

CMD ["nginx", "-g", "daemon off;"]
