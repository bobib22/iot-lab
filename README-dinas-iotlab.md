Dinas on IoT-LAB
=======================

If you are new to IoT-LAB, maybe it would be interesting for you to discover the  environment through the web portal first : [submit-an-experiment-with-web-portal-and-m3-nodes](https://www.iot-lab.info/tutorials/submit-an-experiment-with-web-portal-and-m3-nodes/)
Then after you will be more likely to understand the scripts used below that automates the reservation of nodes, the flashing, the communication via the serial link ... through the [iotlab command-line tools](https://github.com/iot-lab/iot-lab/wiki/CLI-Tools). For more tutorials : https://www.iot-lab.info/tutorials/

To launch a first dinas experiment on m3 nodes : 

* create an account on https://www.iot-lab.info/ and copy your ssh key in your profile
* ``ssh <login>@lille.iot-lab.info:~`` (grid topology : https://www.iot-lab.info/deployment/lille/)
* ``git clone https://github.com/bobib22/iot-lab-dinas``
* ``cd iot-lab-dinas``
* ``make setup-openlab setup-contiki-dinas-iotlab``
* ``cd parts/contiki-dinas-iotlab/examples/ipv6/rpl-dinas/demo-dinas``
* edit project-conf.h if you want to [change the transmission power or the rssi threshold](https://github.com/iot-lab/iot-lab/wiki/Limit-nodes-connectivity) to force the topology
* ``make`` (dinas-peer.iotlab-m3 and dinas-sink.iotlab-m3 are iotlab-compliant binaries)
* ``cd ../iotlab-scripts`` (script to launch an experiment on iotlab)
  * ``auth-cli -u <login> -p <password>`` (to authorize the launch of experiments through the command-line)
  * ``./launch.sh config/strasbourg-BR36-69dBm-20nodes.cfg <TIME(in min)>`` (submit the experiment, flash the nodes and collect the logs from the serial output of each node in a separate file (``output/<log>``))

If you prefer to compile code on your computer : 

* don't forget the relevant toolchain for m3 : [gcc-arm-none-eabi-4_8-2014q1](https://github.com/iot-lab/iot-lab/wiki/FAQ_Gcc_arm_versions)