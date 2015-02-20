FROM tifayuki/java:7
MAINTAINER Jon Vallet <jon.vallet@proxama.com>

RUN apt-get update && \
    apt-get install -y wget unzip pwgen expect && \
    wget download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
    unzip glassfish-4.1.zip -d /opt && \
    rm glassfish-4.1.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/glassfish4/bin:$PATH

ADD change_admin_password.sh /change_admin_password.sh
ADD change_admin_password_func.sh /change_admin_password_func.sh
ADD enable_secure_admin.sh /enable_secure_admin.sh
RUN chmod +x /*.sh

# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener)
EXPOSE 4848 8080 8181

CMD ["asadmin", "start-domain", "-w"]
