#!/bin/bash
OPENSSL_VER="$(openssl version)"

if [[ $OPENSSL_VER == *"0.9"* ]]; then
	echo "Your OpenSSL version is too old: $OPENSSL_VER"
	echo "Please install version 1.0.1 or later"
	exit -1
else
    echo "Your OpenSSL version is: $OPENSSL_VER"
fi

set -e
./clean.sh
./gen_root_ca.sh opcapass password
./gen_node_cert.sh 01 password opcapass && ./gen_node_cert.sh 02 password opcapass &&  ./gen_node_cert.sh 03 password opcapass
./gen_client_node_cert.sh admin password opcapass

rm -f ./*tmp*
