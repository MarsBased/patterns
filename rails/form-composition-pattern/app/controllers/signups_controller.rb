# frozen_string_literal: true

class SignUpsController < ApplicationController

  def new
    @sign_up_form = SignUpForm.new
  end

  def create
    @sign_up_form = SignUpForm.new(signup_params)

    if @sign_up_form.save
      sign_in(@sign_up_form.user)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def signup_params
    params.require(:sign_up_form).permit(
      user_attributes: %i(email password),
      organization_attributes: %i(name)
    )
  end

end
