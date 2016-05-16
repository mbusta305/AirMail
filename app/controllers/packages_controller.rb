require 'easypost'
class PackagesController < ApplicationController
  before_filter :login_required, :only => [:new]
  before_action :set_package, only: [:show, :edit, :destroy]


  def new
    @package = Package.new
  end

  def create

    # @users = User.all

EasyPost.api_key = 'fLMWifRPARb3cinJZWg2sA'

    to_address = EasyPost::Address.create(
      name: package_params[:first_name],
      :street1 => '179 N Harbor Dr',
      :city => 'Redondo Beach',
      :state => 'CA',
      :zip => '90277',
      :country => 'US',
      :phone => '310-808-5243'
    )
    from_address = EasyPost::Address.create(
      :company => 'EasyPost',
      :street1 => '118 2nd Street',
      :street2 => '4th Floor',
      :city => 'San Francisco',
      :state => 'CA',
      :zip => '94105',
      :phone => '415-456-7890'
    )

    parcel = EasyPost::Parcel.create(
      :width => 15.2,
      :length => 18,
      :height => 9.5,
      :weight => 35.1
    )

    customs_item = EasyPost::CustomsItem.create(
      :description => 'EasyPost T-shirts',
      :quantity => 2,
      :value => 23.56,
      :weight => 33,
      :origin_country => 'us',
      :hs_tariff_number => 123456
    )
    customs_info = EasyPost::CustomsInfo.create(
      :integrated_form_type => 'form_2976',
      :customs_certify => true,
      :customs_signer => 'Dr. Pepper',
      :contents_type => 'gift',
      :contents_explanation => '', # only required when contents_type => 'other'
      :eel_pfc => 'NOEEI 30.37(a)',
      :non_delivery_option => 'abandon',
      :restriction_type => 'none',
      :restriction_comments => '',
      :customs_items => [customs_item]
    )

    shipment = EasyPost::Shipment.create(
      :to_address => to_address,
      :from_address => from_address,
      :parcel => parcel,
      :customs_info => customs_info
    )

    shipment.buy(
      :rate => shipment.lowest_rate
    )

    shipment.insure(amount: 100)

    puts shipment.insurance
    @user_shipment = shipment.postage_label.label_url
    puts" HERE IT IS!!!! #{ shipment.postage_label.label_url}"


    @package = Package.new(package_params)
    @package.label_url = @user_shipment
    puts @package
    @package.user_id = current_user.id
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
    if current_user.admin
     @packages = Package.all
    else
      @packages = Package.where(:user_id => current_user.id)
    # if !@current_user.admin
    #   redirect_to packages_new_path
    end
  end


  def destroy
    @package.destroy
    redirect_to packages_url, notice: 'Product was successfully destroyed.'
  end

private

  def package_params
    params.require(:package).permit(:country, :first_name, :last_name, :company, :street, :street2, :city, :state, :zip, :phone, :email, :tocountry, :tofirst_name, :tolast_name, :tocompany, :tostreet, :tostreet2, :tocity, :tostate, :tozip, :tophone, :toemail)
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_package
    @package = Package.find(params[:id])
  end
end
