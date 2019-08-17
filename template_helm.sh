#!/usr/bin/env sh

helm init --client-only
helm fetch "jetstack/cert-manager" --untar --untardir /tmp --version "0.9.1"
helm template /tmp/cert-manager > /tmp/cert-manager.yaml
