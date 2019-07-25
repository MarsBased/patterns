# frozen_string_literal: true

class UsersController < ApplicationController

  def create
    authorize User

    Users::Create.new(user_params).call.then do |result|
      if result.ok
        redirect_to dashboard_path
      else
        @user = result.user
        flash.now[:error] = t('.error')
        render :new
      end
    end
  end

  # There is no need to use a command here, since the action to perform is simple and
  # does not have side effects. Adding a command here would increase complexity.
  def update
    @user = authorize User.find(params[:id])

    if @user.update(user_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def user_params; end

end
