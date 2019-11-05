class UsersController < ApplicationController
  def index
  end

  def show
    @users = current_user
    @events = Event.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
