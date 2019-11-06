class ChargesController < ApplicationController
  def new
end

def create
  # Amount in cents
  @amount = 500
  @user=current_user

  customer = Stripe::Customer.create({
    email: params[:stripeEmail],
    source: params[:stripeToken],
  })

  charge = Stripe::Charge.create({
    customer: customer.id,
    amount: @amount,
    description: 'Paiement de #{@user.first_name} #{@user.last_name}',
    currency: 'eur',
  })

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end
end
