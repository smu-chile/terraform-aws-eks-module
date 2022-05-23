/etc/eks/bootstrap.sh aws-virginia-factory-front-develop \
  --disk-size 100 \
  --use-max-pods false \
  --aws-security-group-id 'sg-0b37a81947d9b8015'
  --kubelet-extra-args '--max-pods=110'