FROM ruby:2.1.2

RUN echo "deb http://ftp.us.debian.org/debian jessie main contrib non-free" | tee -a /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates contrib non-free" | tee -a /etc/apt/sources.list \
    && apt-get update \
    && echo "export phantomjs=/usr/bin/phantomjs" > .bashrc \
    && apt-get install -y libfreetype6 libfontconfig1 nodejs npm libnss3-dev libgconf-2-4 ttf-freefont ttf-mscorefonts-installer ttf-bitstream-vera ttf-dejavu ttf-liberation imagemagick bash \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install npm \
    && npm install -g phantomjs@2.1.7 casperjs@1.1.1

ADD . /tmp/build
RUN cd /tmp/build \
    && gem build wraith.gemspec \
    && gem install ./wraith-*.gem --no-rdoc --no-ri \
    && rm -rf /tmp/build

ENTRYPOINT [ "wraith" ]
