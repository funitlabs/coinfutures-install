#!/bin/sh

# 필요패키지 설치(centos7.4기준)
yum -y groupinstall "Development Tools"
yum -y install nano
yum -y install openssl*
yum -y install mysql-*
yum -y install mysql-client
yum -y install mysql-devel
yum -y install curl*
yum -y install curl-devel*
yum -y install libxml2
yum -y install libxml2-devel
yum -y install wget
yum -y install libcurl
yum -y install libcurl-devel
yum -y install vsftpd
yum -y install ntsysv
yum -y install mysql-devel
yum -y install mysql-libs
yum -y install gd
yum -y install gd-devel
yum -y install libtool-ltdl-devel
yum -y install lrzsz
yum -y install net-tools
yum -y install psmisc
yum -y install mysql
yum -y install httpd
yum -y install httpd-devel

# 폴더 생성 config 복사
mkdir /config
cp config/* /config/

# create httpd.conf symlink
ln -sf /config/httpd.conf /etc/httpd/conf/httpd.conf

# cron 작업 등록 (매일 시간 자동맞춤)
echo "0 5 * * * /usr/bin/rdate -s time.bora.net" | tee -a /var/spool/cron/root


# php 7.0.33 (operator패치된것) 설치
cd php-7.0.33
make clean
./configure  --with-config-file-path=/config --with-apxs2=/usr/bin/apxs --with-gd --with-iconv --enable-mbstring=kr --disable-debug --with-curl=/usr/local/curl --enable-bcmath --enable-sockets --with-openssl --with-libdir=lib64 --with-mysqli --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-tsrm-pthreads --enable-opcache --enable-maintainer-zts
make -j32
make install
cd ..

# operator 모듈 빌드 후 /config로 이동
cd pecl-php-operator/
make clean
phpize
./configure
make
cd modules/
mv -f operator.so /config/
cd ../..

# node 설치
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
yum -y install nodejs