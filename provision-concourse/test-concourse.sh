#!/bin/bash

fly login -t mgmt -c https://10.193.163.17

fly -t mgmt sp -p test -c test_pipeline.yml --non-interactive
fly -t mgmt unpause-pipeline -p test
fly -t mgmt trigger-job -j test/hello-world
