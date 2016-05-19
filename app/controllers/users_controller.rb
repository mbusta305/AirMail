class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # def create
  #   @user = User.new user_params

  #   return render action: 'new' unless @user.save

  #   redirect_to root_path, notice: 'Created user'
  # end


  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Thanks for signing up #{@user.first_name}. Feel free to log in now!"
      redirect_to root_path
    else
      render 'new'
    end
  end



  private

  def user_params
    params.require(:user).permit(:username,:password,:password_confirmation,:first_name,:last_name,:phone_number,:address,:admin)
  end
end
