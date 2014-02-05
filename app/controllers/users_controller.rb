class UsersController < ApplicationController
  before_filter :require_user, :except => [:new, :create]
  include ApplicationHelper
 
  def index 
    @users = User.search(params[:search]).order("name").page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
    render :layout => false
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        UserMailer.registration_confirmation(@user).deliver
        if current_user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
        else
        format.html { redirect_to root_url,notice: 'User was successfully created... Login details Sent to Entered email address' }
      end
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to request.env['HTTP_REFERER'], notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
