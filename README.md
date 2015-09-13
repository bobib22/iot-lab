IoT-LAB Main Repository
=======================

This repository contains common IoT-LAB resources, such as
experiments management tools, deployment tools, dev. env. setup.

Overall documentation is available at https://github.com/iot-lab/iot-lab/wiki

To perform the initial setup of your development environment, run ``make``.

# dinas on iotlab

To launch a first contiki experiment on m3 nodes : 

* create an account on https://www.iot-lab.info/ and copy your ssh key in your profile
* ssh <login>@lille.iot-lab.info:~ (grid topology : https://www.iot-lab.info/deployment/lille/)
* git clone -b dinas-iotlab --single-branch https://github.com/bobib22/iot-lab dinas-iotlab
* cd dinas-iotlab
* make setup-openlab setup-contiki-dinas-iotlab
* cd parts/contiki-dinas-iotlab/examples/ipv6/rpl-dinas/demo-dinas
* edit project-conf.h if you want to [change the transmission power or the rssi threshold](https://github.com/iot-lab/iot-lab/wiki/Limit-nodes-connectivity) to force the topology
* make (dinas-peer.iotlab-m3 and dinas-sink.iotlab-m3 are iotlab-compliant binaries)
* cd iotlab-scripts (script to launch an experiment on iotlab)
  * auth-cli -u <login> -p <password> (to authorize the launch of experiments through the command-line)
  * ./launch.sh (submit the experiment, flash the nodes and collect the logs from the serial output of each node in separate files (output/<id>))
  * ./dinas.sh (to distribute node id through the serial link and control the dinas message transmision sequence)

If you prefer to compile code on your computer : 

* don't forget the relevant toolchain for m3 :[gcc-arm-none-eabi-4_8-2014q1](https://github.com/iot-lab/iot-lab/wiki/FAQ_Gcc_arm_versions)
* rsync is your friend : rsync -Haurov dinas-iotlab  <login>@lille.iot-lab.info:~