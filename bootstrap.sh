MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh aws-virginia-factory-front-develop \
  --use-max-pods false \
  --kubelet-extra-args '--max-pods=110'

--==MYBOUNDARY==--