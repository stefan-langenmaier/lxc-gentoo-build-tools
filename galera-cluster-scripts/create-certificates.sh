#!/bin/bash

# this will generate certs that are valid for 100 years, because the cluster has to be shutdown for a cert update

echo "make sure that the canonical name from the ca and the server differ"
echo "otherwise they wont validate"

# generate ca key
echo "Generating ca"
openssl genrsa 2048 > ca-key.pem
# generate ca cert
openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem
echo

# server cert
echo "Generating server cert"
# generate server key
openssl req -newkey rsa:2048 -days 365000 \
      -nodes -keyout server-key.pem -out server-req.pem
openssl rsa -in server-key.pem -out server-key.pem
#generate server cert
openssl x509 -req -in server-req.pem -days 365000 \
      -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 \
      -out server-cert.pem
echo

# client cert
echo "Generating client cert"
# generate client key
openssl req -newkey rsa:2048 -days 365000 \
      -nodes -keyout client-key.pem -out client-req.pem
openssl rsa -in client-key.pem -out client-key.pem
# generate client cert
openssl x509 -req -in client-req.pem -days 365000 \
      -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 \
      -out client-cert.pem
echo

#verifying the certs
echo "Validating certs"
echo "Should only show okay, otherwise you have to redo it!"
openssl verify -CAfile ca-cert.pem \
      server-cert.pem client-cert.pem
