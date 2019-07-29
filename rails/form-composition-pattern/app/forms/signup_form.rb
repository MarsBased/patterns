# frozen_string_literal: true

# This pattern is used to have multiple models being saved in the same form without
# writing additional logic that the one Rails already provides.
class SignUpForm

  # By using ActiveModel::Model we can use this class with Rails form helpers.
  include ActiveModel::Model

  # The save method must save all the models that will contain and return true or false
  # In this specific example, saving the user saves the organization too.
  # If you need to save non related models you need to wrap the save methods inside a
  # transaction.
  # e.g.
  # def save
  #   ActiveRecord::Base.transaction do
  #     user.save && organization.save or fail ActiveRecord::Rollback
  #   end
  # end
  # Checking if the records are valid before saving is not enough as unexpected race
  # conditions could happen leaving inconsistent data in the database.
  def save
    user.save
  end

  # Getters need to be created for every model we want in the form. As this is a create
  # form, we are instantiating the models directly in the form.
  def organization
    @organization ||= user.memberships.build(role: :owner).build_organization
  end

  # For every entity we need to create a entity_attributes=(attributes) method.
  # This method will be used by Rails via ActiveModel::Model to treat the models
  # as nested forms.
  def organization_attributes=(attributes)
    organization.assign_attributes(attributes)
  end

  def user
    @user ||= User.new
  end

  def user_attributes=(attributes)
    user.assign_attributes(attributes)
  end

end
