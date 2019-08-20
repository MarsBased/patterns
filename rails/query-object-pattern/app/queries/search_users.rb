# frozen_string_literal: true

# This pattern is used to encapsulate complex queries in an isolated and testable object.
class SearchUsers

  # The initializer takes an scope to start from. This allows to compose it
  # with other query objects and/or regular ActiveRecord methods.
  def initialize(scope = User.all)
    @scope = scope
  end

  # The class has a single call method which takes the additional parameters needed
  # to perform the query, if any.
  # The method calls a number of private methods to incrementally build the query in
  # small steps. In the end it adds an order clause to make sure the query
  # always returns the same results having the same data in the DB.
  def call(filters: {})
    filter_by_email(filters[:email]) if filters[:email]
    filter_by_language(filters[:language]) if filters[:language]

    @scope.order(created_at: :desc)
  end

  private

  def filter_by_email(email)
    @scope = @scope.where('email ILIKE %?%', email)
  end

  def filter_by_language(language)
    @scope = @scope.joins(:profile).where(profile: { language: language })
  end

end
