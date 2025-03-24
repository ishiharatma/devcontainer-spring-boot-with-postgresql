ARG JAVA_VERSION="21-al2023"
FROM amazoncorretto:${JAVA_VERSION}
ENV DOCKER_BUILDKIT=1
ENV GRADLE_VER="8.13"

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Disable SSL verification for yum repository
#RUN echo "sslverify=0" >> /etc/yum.conf

# Install necessary packages
RUN yum install -y ca-certificates || yum install -y ca-certificates.noarch

# Optional: 
## Copy and update certificates
#COPY your-root-ca.cer /usr/local/share/ca-certificates/your-root-ca.crt
#RUN update-ca-certificates || (mkdir -p /etc/pki/ca-trust/source/anchors/ && \
#    cp /usr/local/share/ca-certificates/your-root-ca.crt /etc/pki/ca-trust/source/anchors/ && \
#    update-ca-trust extract)
#
## Certificate configuration for Java
#RUN keytool -import -trustcacerts -cacerts -storepass changeit \
#    -noprompt -alias zscaler -file /usr/local/share/ca-certificates/your-root-ca.crt || \
#    keytool -import -trustcacerts -cacerts -storepass changeit \
#    -noprompt -alias zscaler -file /etc/pki/ca-trust/source/anchors/your-root-ca.crt

# Create the user
RUN yum install -y shadow-utils tar
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && yum update -y \
    && yum install -y sudo yum-utils\
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install tools
RUN yum install -y python3 python3-pip \
    && pip3 install awscli --upgrade

RUN yum -y install git

# curl-minimal is already available, no need to install
# RUN yum -y install curl

RUN yum -y install unzip

RUN yum install -y findutils

# Specify certificate location for Git
#RUN git config --global http.sslCAInfo /usr/local/share/ca-certificates/your-root-ca.crt

# Install and configure Gradle
RUN curl -L -o gradle-${GRADLE_VER}-bin.zip https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
    && unzip gradle-${GRADLE_VER}-bin.zip -d /opt \
    && rm gradle-${GRADLE_VER}-bin.zip \
    && ln -s /opt/gradle-${GRADLE_VER} /opt/gradle
ENV PATH=$PATH:/opt/gradle/bin

# Certificate configuration for Gradle
RUN mkdir -p /home/$USERNAME/.gradle
RUN echo "systemProp.javax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts" > /home/$USERNAME/.gradle/gradle.properties \
    && echo "systemProp.javax.net.ssl.trustStorePassword=changeit" >> /home/$USERNAME/.gradle/gradle.properties \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME/.gradle

# Certificate configuration for Spring Boot runtime (environment variables)
ENV JAVA_OPTS="-Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts -Djavax.net.ssl.trustStorePassword=changeit"

# Cleanup
RUN yum clean all && \
  rm -rf /var/cache/yum/*

# User configuration
USER $USERNAME
WORKDIR /home/$USERNAME