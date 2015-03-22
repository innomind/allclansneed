FROM kneip/ree-1.8.7-2012.02

RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install libsqlite3-dev

# Install RubyGems
WORKDIR /
RUN wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.22.tgz
RUN tar -xvzf rubygems-1.8.22.tgz
WORKDIR /rubygems-1.8.22
RUN sudo ruby setup.rb
# RUN gem update --system 1.8.25

RUN gem install rails -v '2.3.3' --no-ri --no-rdoc
RUN rm /usr/local/bin/rdoc
RUN rm /usr/local/bin/ri
RUN gem install rdoc --no-ri --no-rdoc
RUN gem install rspec-rails -v '1.3.4' --no-ri --no-rdoc
RUN gem install sqlite3 --no-ri --no-rdoc

RUN mkdir /allclansneed
WORKDIR /allclansneed
ADD . /allclansneed

RUN rake gems:install --trace
