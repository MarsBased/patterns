# frozen_string_literal: true

class ProfilesController < ApplicationController

  # We are using the ProfileForm user attr_accessor to configure the user to be edited.
  def edit
    @profile_form = ProfileForm.new(user: current_user)
  end

  def update
    @profile_form = ProfileForm.new(user: current_user)
    @profile_form.attributes = profile_params

    if @profile_form.save
      redirect_to profile_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile_form).permit(
      user_attributes: %i(email),
      organization_attributes: %i(name)
    )
  end

end
