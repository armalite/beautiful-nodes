#!/bin/bash

# This bootstraps k3s onto my beautiful node :-)
# tls-san will ensure the public IP of the node is stored in the k3s config (instead of the internal IP of the node)
sudo hostnamectl set-hostname ${nodename} &&
curl -sfL https://get.k3s.io | sh -s - server \
--datastore-endpoint="mysql://${dbuser}:${dbpass}@tcp(${db_endpoint})/${dbname}" \
--write-kubeconfig-mode 644 \
--tls-san=$(curl http://169.254.169.254/latest/meta-data/public-ipv4) \
--token="beautifultoken"
