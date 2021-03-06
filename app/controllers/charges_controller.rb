class ChargesController < ApplicationController
  require "stripe"

  Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]


  def new
    @package = Package.find(params[:package])
  end

  def create
    # Amount in cents
    # @amount = 500
    @amount = ((params[:package][:shipping].to_f + 5) * 100).to_i
    @final_amount = '%.02f' % (@amount/100.00)
    p @amount

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'

    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
