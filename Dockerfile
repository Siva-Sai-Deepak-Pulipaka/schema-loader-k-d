FROM        dokken/centos-8
RUN         yum install epel-release -y
COPY        mongo.repo /etc/yum.repos.d/mongo.repo
RUN         yum install git mysql mongo-org-shell unzip jq -y
RUN         curl -L curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && sudo ./aws/install
COPY        run.sh /
ENTRYPOINT [ "bash","/run.sh" ]
