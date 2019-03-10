#!/bin/bash
gsutil cp  gs://scripts-2018-11/install_ruby.sh ~
gsutil cp  gs://scripts-2018-11/install_mongodb.sh ~
gsutil cp  gs://scripts-2018-11/deploy.sh ~
chmod +x *.sh
./install_ruby.sh
./install_mongodb.sh
./deploy.sh
