class UsersController < ApplicationController
  before_action :signed_in, except: [ :index, :new, :create ]
  before_action :find_correct_user, except: [ :index ]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user), notice: "You have successfully created account!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have successfully updated your aaccount!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def find_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :mobile_number, :password, :password_confirmation)
  end
end
