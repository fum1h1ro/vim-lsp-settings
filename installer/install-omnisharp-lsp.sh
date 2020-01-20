#!/bin/bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch="-x64"

case $os in
linux) ;;
darwin)
  os="osx"
  arch=""
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

version=`curl https://roslynomnisharp.blob.core.windows.net/releases/versioninfo.txt`
url="https://roslynomnisharp.blob.core.windows.net/releases/$version/omnisharp-$os$arch.tar.gz"
curl -LO "$url"
tar xzvf omnisharp-$os$arch.tar.gz
rm omnisharp-$os$arch.tar.gz

chmod +x run

cat <<EOF > omnisharp-lsp
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/run \$*
EOF

chmod +x omnisharp-lsp
