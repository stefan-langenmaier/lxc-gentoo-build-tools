#!/bin/bash

# this will generate certs that are valid for 100 years, because the cluster has to be shutdown for a cert update

# generate ca key
openssl genrsa 2048 > ca-key.pem
# generate ca cert
openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem

# server cert
# generate server key
openssl req -newkey rsa:2048 -days 365000 \
      -nodes -keyout server-key.pem -out server-req.pem
openssl rsa -in server-key.pem -out server-key.pem
#generate server cert
openssl x509 -req -in server-req.pem -days 365000 \
      -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 \
      -out server-cert.pem


# client cert
# generate client key
openssl req -newkey rsa:2048 -days 365000 \
      -nodes -keyout client-key.pem -out client-req.pem
openssl rsa -in client-key.pem -out client-key.pem
# generate client cert
openssl x509 -req -in client-req.pem -days 365000 \
      -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 \
      -out client-cert.pem

#verifying the certs
openssl verify -CAfile ca-cert.pem \
      server-cert.pem client-cert.pem
