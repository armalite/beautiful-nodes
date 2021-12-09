sudo scp -i ${private_key_path} \
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/dev/null \
-q ubuntu@${nodeip}:/var/lib/rancher/k3s/server/node-token ${k3s_path}/k3s-${nodename}-node-token && 
sed -i 's/127.0.0.1/${nodeip}/' ${k3s_path}/k3s-${nodename}-node-token
