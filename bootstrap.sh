MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==

/etc/eks/bootstrap.sh aws-virginia-factory-front-develop \
  --cni-prefix-delegation-enabled \
  --disk-size 100 \
  --use-max-pods false \
  --kubelet-extra-args '--max-pods=110'

--==MYBOUNDARY==--