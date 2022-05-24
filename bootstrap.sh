MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash
set -ex
cat <<-EOF > /etc/profile.d/bootstrap.sh
export USE_MAX_PODS=false
export KUBELET_EXTRA_ARGS="--max-pods=110"
EOF
# Source extra environment variables in bootstrap script
sed -i '/^set -o errexit/a\\nsource /etc/profile.d/bootstrap.sh' /etc/eks/bootstrap.sh
EOT

--==MYBOUNDARY==--