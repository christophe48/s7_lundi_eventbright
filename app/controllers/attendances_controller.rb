class AttendancesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @event = Event.find(params[:id])
  end

  def create
    # Amount in cents
    @event = Event.find(params[:id])

    if @event.attendances_include? current_user
      flash[:error] = "Vous participez déjà à #{@event.title}"
      redirect_to @event
    end


    @amount = @event.price
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

    @attendance = Attendance.new(user_id: current_user.id, event_id: @event.id, stripe_customer_id: customer.id)
    flash[:success] = "Vous êtes bien inscrit à #{@event.title}"
    redirect_to @event

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
