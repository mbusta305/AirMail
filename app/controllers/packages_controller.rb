class PackagesController < ApplicationController
  before_filter :login_required, :only => [:new]
  before_action :set_package, only: [:show, :edit, :update, :destroy]


  def new
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)
    # @package.owner_id = current_user.id
    if @package.save
      redirect_to packages_path, notice: 'Package was successfully created.'
    else
      render :new
    end
  end

  def show
    @package = Package.find(params[:id])
  end

  def index
    @packages = Package.all

    # if !@current_user.admin
    #   redirect_to packages_new_path
    # end
  end

  def destroy
    @package.destroy
  end
end

private

  def package_params
    params.require(:package).permit(:country, :first_name, :last_name, :company, :street, :street2, :city, :state, :zip, :phone, :email)
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_package
    @package = Package.find(params[:id])
  end
