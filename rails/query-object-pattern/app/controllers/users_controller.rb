# frozen_string_literal: true

class UsersController < ApplicationController

  # We call the query object with only the active users, so
  # all the filters apply on top of that scope.
  def index
    @users = SearchUsers.new(User.active).call(search_params)
  end

  private

  def search_params
    params.require(:search).permit(:email, :language)
  end

end
