# VM Infra as Code

## Intêret
Création d'une machine virtuelle Linux outillée pour faire de l'Infrastructure As Code.

## J'ai besoin de quoi ?
De [Virtual Box](https://www.virtualbox.org/) et de [Vagrant](https://www.vagrantup.com/downloads) installés sur la machine. 

## Installe :
Terraform, Ansible et Docker dans une VM base Ubuntu Bionic 64

Autocomplétion pour terraform.

AWS CLI V2

## Usage
Dans un terminal : 

Clonez ce dépôt : `git clone https://github.com/alinuxien/terraform.git` 

Allez dans le dossier terraform : `cd terraform`

Editez les fichiers Vagrantfile et auto_cd.sh pour supprimer 1 ligne dans chacun ( instruction claire à l'intérieur )

Lancez la construction : `vagrant up`

Lorsque c'est terminé, connectez-vous à la VM : `vagrant ssh`

# Et après ?
Vous pouvez par exemple configurer vos identifiants Amazon : `aws configure`

( [Plus d'infos sur les identifiants Amazon](https://console.aws.amazon.com/iam/home?#security_credential) )

Et pourquoi pas [créer une infrastrure solide pour 1 Wordpress ?](https://github.com/alinuxien/super-wp-aws-auto)

Enjoy...
