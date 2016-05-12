class PackagesController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  def index
    if !@current_user.admin
      redirect_to packages_new_path
    end
  end

  def destroy
  end
end
