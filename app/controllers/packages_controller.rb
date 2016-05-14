class PackagesController < ApplicationController
  before_filter :login_required, :only => [:new]

  def new
    @package = Package.new
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
