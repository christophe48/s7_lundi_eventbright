class EventsController < ApplicationController
    before_action :authenticate_user!, only: [:show,:new,:create,:edit,:update,:destroy]
  def index
    @events = Event.all
    @attendances = Attendance.all
  end

  def show
    @event = Event.find(params[:id])
    @user = User.all
    @attendances = Attendance.all
  end

  def new
    @event = current_user
    @event = Event.new
  end

  def create
    @event = Event.new(administrator_id: current_user.id, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location] ) # avec xxx qui sont les données obtenues à partir du formulaire

    if @event.save
      flash[:success] = "L'Event a bien été crée"
      redirect_to event_path(@event)
        else
      flash.now[:danger] = "Erreur, l'Event non créé"
      render "events/new"
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
      if @event.update(administrator_id: current_user.id, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
        flash[:success] = "L'event a bien été modifié"
        redirect_to event_path(@event)
      else
        flash.now[:danger] = "L'event n'a pas été modifié"
        render :edit
      end
    end


  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = "L'Event a bien été supprimé"
    redirect_to root_path

  end
end
