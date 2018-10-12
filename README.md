# vagrant-k8s-environment

This repo builds a fully functional 2 node master and 2 node worker kubernetes cluster. The dashboard is deployed via HTTPS without `kubectl proxy`, so you will need to install a certificate and copy the user token, which are both located in this repo after running `vagrant up`.

