Cour la gem Devise:

#Installation
rajoute de gem 'devise' dans gemfile
puis
#$ rails generate devise:install

Ce qui a pour effet de créer deux fichiers :

_config/initializers/devise.rb_ : le fichier de configuration de Devise. On s'en servira par exemple pour paramétrer le service que l'on va utiliser pour les envois d'e-mails ;
_config/locales/devise.en.yml_ : un fichier contenant les messages d'erreur de Devise. Tu pourras utiliser ses version françaises quand tu seras plus à l'aise avec la gem.

l'information suivante dans le fichier config/environments/development.rb :
#config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

# Les fonctionnalité:
Chaque fonctionnalités de Devise est inclus dans un module qu'on peut activer ou non :

Database Authenticatable : possibilité de stocker les mots de passe dans leur version hashée pour valider l'authenticité d'un utilisateur pendant sa connexion (la base quoi) ;
Registerable : possibilité de créer un compte via un formulaire. Aussi, possibilité d'éditer et de supprimer son compte ;
Recoverable : possibilité de réinitialiser le mot de passe et d'envoyer des instructions par e-mail ;
Rememberable : possibilité d'utiliser le fameux cookie remember me (la session reste ouverte) ;
Validatable : possibilité de donner des validations pour les e-mails et mots de passe (taille, regex, etc) ;
Omniauthable : possibilité de gestion de OmniAuth (un service pour se connecter via son compte Google, Facebook ou autre) ;
Confirmable : possibilité de forcer la confirmation par e-mail du compte ;
Trackable : possibilité de tracker le nombre de login, leurs timestamps, et les adresses IP ;
Timeoutable : possibilité d'expirer des sessions après un certain temps d'inactivité ;
Lockable : possibilité de verrouiller un compte après trop de tentatives échouées de connexions ;

#l'application sur une app:
#$ rails g devise User

🤓 QUESTION RÉCURRENTE
Mais dis-donc Jamy, comment on fait si l'on a déjà créé le model User ?
Devise est plutôt intelligente, puisque elle va changer ta migration de create_table à change_table. Il y aura deux détails à gérer :

Indispensable : Si jamais tu as déjà dans ta table users une colonne que Devise utilise (email, encrypted_password, etc), la migration plantera puisque Devise les ajoute aussi (impossible de créer 2 fois un attribut ayant le même nom). Il te faudra enlever ces lignes de la migration de Devise.
Optionnel : La migration générée est séparée en 2 parties: self.up qui liste les changements qui vont avoir lieu sur la table users si la migration est passée et self.down qui liste les changements si on rollback la migration. Tu peux voir un exemple dans la documentation. Il faudra (idéalement - sinon tout rollback sera inefficace) penser à compléter à la main la partie self.down pour lister ce qui doit être enlevé avec des : remove_column ou des remove_index.

Sur à l'application de devise, le model _user_ à deux nouvelles lignes de code et des nouvelles _routes_ sont générées:

On va les décrypter une à une :

_devise/sessions#new_ : pour accéder à la view de connexion.
_devise/sessions#create_ : le POST pour se connecter.
_devise/sessions#destroy_ : le DELETE pour se déconnecter.
_devise/passwords#new_: pour accéder à l'écran "mot de passe oublié ?" où tu rentres ton adresse email pour recevoir un email de réinitialisation de mot de passe.
_devise/passwords#create_ : le POST pour réinitialiser le mot de passe.
_devise/passwords#edit_ : pour accéder à la view où tu rentres ton nouveau mot de passe (tu y accèdes en cliquant dans le lien "réinitialiser le mot de passe" dans ton email de réinitialisation de mot de passe)
_devise/passwords#update_ : le PATCH/PUT pour changer de mot de passe.
_devise/registrations#cancel_ (rarement utilisée) : pour accéder à la view permettant de supprimer une inscription.
_devise/registrations#new_ : pour accéder à la view d'inscription au site.
_devise/registrations#create_ : le POST pour s'inscrire sur le site.
_devise/registrations#edit_ : pour accéder à la view de modification d'une inscription (notamment son email et son mot de passe).
_devise/registrations#update_ : le PATCH/PUT pour modifier son email et mot de passe
_devise/registrations#destroy_ : le DELETE pour détruire son compte

# générations des views et mailers
#$ rails generate devise:views

_app/views/devise/shared/_links.html.erb_ : une petite partial qui affiche les liens dont tu as besoin en fonction de la page (exemple : le lien "mot de passe oublié" sur l'écran de connexion).
_app/views/devise/confirmations/new.html.erb_ : l'écran de confirmation (pas besoin pour le moment).
_app/views/devise/passwords/edit.html.erb_ : la vue où tu rentres ton nouveau mot de passe (tu y accèdes en cliquant dans le lien "réinitialiser le mot de passe" dans ton email de réinitialisation de mot de passe).
_app/views/devise/passwords/new.html.erb_ : l'écran "mot de passe oublié ?" où tu rentres ton adresse email pour recevoir un email de réinitialisation de mot de passe.
_app/views/devise/registrations/edit.html.erb_ : l'écran pour modifier les informations de son compte utilisateur (notamment son email et son mot de passe).
_app/views/devise/registrations/new.html.erb_ : la page d'inscription au site.
_app/views/devise/sessions/new.html.erb_ : la page de connexion au site.
_app/views/devise/unlocks/new.html.erb_ : écran pour déverrouiller son compte (pas besoin pour le moment).
Au passage, plusieurs e-mails sont générés :

_app/views/devise/mailer/confirmation_instructions.html.erb_ : e-mail pour confirmer son compte (pas besoin pour le moment).
_app/views/devise/mailer/email_changed.html.erb_ : e-mail pour annoncer un changement d'e-mail.
_app/views/devise/mailer/password_change.html.erb_ : e-mail pour annoncer que ton mot de passe a été changé.
_app/views/devise/mailer/reset_password_instructions.html.erb_ : e-mail pour donner le lien pour changer de mot de passe.
_app/views/devise/mailer/unlock_instructions.html.erb_ : e-mail pour débloquer ton compte (pas besoin pour le moment).

#Intégrer les views de Devise à ton app
#$ rails g controller static_pages index secret

#pimper nos view :
les link pour boostrap à mettre dans _view/layout/application_

_<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>_

#le mailer
Le mailer est trés important pour la récupération de password et les emails de confirmation.
il faut rajouter dans _config/environments/production_ la ligne qui fera le lien avec heroku:
#config.action_mailer.default_url_options = { :host => 'YOURAPPNAME.herokuapp.com' }

#3.6.2. Tu veux rassembler toutes les informations de l'utilisateur sur une seule page à l'inscription et à la modification du profil
dans _app/controller/application_controller.rb_


4. Points importants à retenir
Pour pouvoir utiliser Devise, voici la marche à suivre :

Mettre Devise dans les gems, puis faire bundle install
Installer Devise en entrant la ligne $ rails generate devise:install
Si tu ne l'as pas déjà fait, il faut faire marcher les emails en local dans ton application en mettant la ligne config.action_mailer.default_url_options = { host: 'localhost', port: 3000 } dans ton fichier config/environments/development.rb
Devise est installée, tu peux assigner ton model (99% du temps c'est user) à Devise : $ rails g devise user. Puis tu migres.
Tu génères les views avec $ rails generate devise:views
Les 5 views de Devise devront être retouchées (par exemple avec Bootstrap) pour éviter la page de signup moche
Tu peux utiliser les super helpers user_signed_in? (retourne true/false selon si un utilisateur est connecté) et current_user (retourne l'objet User correspondant à la personne connectée)
Tu peux bloquer l'accès des visiteurs non-connecté à une page secret en rajoutant dans le controller lui correspondant un petit before_action :authenticate_user!, only: [:secret]
Tu as juste à appeler les views depuis ta page d'accueil et à toi la gloire !
