class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.
            find_by(username: params[:username]).
            try(:authenticate, params[:password])

    return render action: 'new' unless @user

    session[:user_id] = @user.id
    if current_user.admin
      redirect_to packages_index_path
    else
      redirect_to packages_new_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
