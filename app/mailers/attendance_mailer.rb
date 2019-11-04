class AttendanceMailer < ApplicationMailer
  default from: 'no-reply@monsite.fr'

  def participate_mail(administrator, user, event)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @administrator = administrator
    @user = user
    @event = event
    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://monsite.fr/login'
    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @administrator.email, subject: "Nouveaux participant à l'évênement")
  end
end
