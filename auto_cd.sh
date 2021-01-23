#!/usr/bin/env bash

[[ ! `grep "cd /home/vagrant/MlleC" /home/vagrant/.bashrc` ]] && echo "cd /home/vagrant/MlleC" >> /home/vagrant/.bashrc
# LA LIGNE CI-DESSUS DOIT ETRE SUPPRIMEE
# LA LIGNE CI-DESSOUS DOIT ETRE DECOMMENTEE ( SUPPRIMER LA # et L'ESPACE AU DEBUT DE LA LIGNE )
# [[ ! `grep "cd /vagrant" /home/vagrant/.bashrc` ]] && echo "cd /vagrant" >> /home/vagrant/.bashrc

