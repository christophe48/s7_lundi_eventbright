class EventsController < ApplicationController
    before_action :authenticate_user!, only: [:show,:new,:create,:edit,:update,:destroy]
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @users = User.all
  end

  def new
    @event = current_user
  end

  def create
    @event = Event.new(administrator_id: current_user.id, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location] ) # avec xxx qui sont les données obtenues à partir du formulaire

    if @event.save
      flash[:success] = "L'Event a bien été crée"
      redirect_to event_path(@event)
        else
      flash.now[:danger] = "Erreur, l'Event non crée"
      render "events/new"
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
