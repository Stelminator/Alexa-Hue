FROM resin/rpi-raspbian 

RUN apt-get update
RUN apt-get install ruby
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN apt-get install curl
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN apt-get install patch bzip2 gawk libssl-dev make libc6-dev patch zlib1g-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgmp-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev libgmp-dev libreadline6-dev
RUN /usr/local/rvm/bin/rvm install 2.2.0 --disable-binary
EXPOSE 4567
ENTRYPOINT bash --login /app/run.sh
WORKDIR /prep
COPY ./Gemfile /prep/Gemfile
COPY ./Gemfile.lock /prep/Gemfile.lock
COPY ./prep.sh /prep/prep.sh
RUN bash --login /prep/prep.sh
WORKDIR /app
COPY . /app
