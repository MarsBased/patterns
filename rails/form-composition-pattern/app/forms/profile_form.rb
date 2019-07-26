# frozen_string_literal: true

# See the SignupForm for general documentation on the pattern before inspecting
# this file.
class ProfileForm

  include ActiveModel::Model

  # For edit forms, we need attr_accessors for every entity that we want to update
  # and initialize them in the controllers or other classes before using them.
  attr_accessor :user

  def save
    user.save
  end

  # As the organization can still be accessed from the user model, we don't need to
  # create an attr_accessor.
  def organization
    @organization ||= user.organization
  end

  def organization_attributes=(attributes)
    organization.assign_attributes(attributes)
  end

  def user_attributes=(attributes)
    user.assign_attributes(attributes)
  end

end
