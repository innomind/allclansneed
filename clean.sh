#!/bin/sh

sudo apachectl stop
rake db:drop:all
rake db:create:all
rake db:migrate
sudo apachectl start
