# frozen_string_literal: true

# Decorates the user passed to the presenter class.
# A presenter is meant to be used from the views. If there are methods that are meant
# to be used from services or commands, the method should be placed in the model or
# another class instead.
class UserPresenter < Keynote::Presenter

  presents :user

  def full_name
    [user.title, user.first_name, user.middle_name, user.last_name].compact.join(' ')
  end

  def city_state_zip
    [user.city, user.state, user.zip_code].compact.join(', ')
  end

  # Rails View Helpers are available on the presenters
  def formatted_phone
    number_to_phone(user.phone, area_code: true)
  end

end
