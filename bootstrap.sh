MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
export USE_MAX_PODS=false
export KUBELET_EXTRA_ARGS="--max-pods=110"

--==MYBOUNDARY==--