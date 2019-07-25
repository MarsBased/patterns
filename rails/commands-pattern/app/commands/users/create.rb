# frozen_string_literal: true

# Notice that commands are scoped into a module referencing the entity they are working
# with. There are situations where the command might not refer to a single entity.
# The name of the module doesn't need to match the name of a Rails model.
module Users
  class Create

    # Every command can build the Result object as they wish. We greatly recommend
    # to always use the 'ok' and 'errors' keywords for coherence.
    Result = Struct.new(:ok, :errors, :user, :other_param, keyword_init: true)

    # All the parameters needed for the command to work must be passed
    # to the initializer.
    # The initializer should not contain any logic. It's only meant to be used for
    # instance variable assignments.
    def initialize(params:)
      @params = params
    end

    # This is the only public method of the command. It doesn't accept parameters.
    # The idea behind a command is a chainable class used to perform a single operation
    # that is complex enough to require private methods or to depend on other commands or
    # classes. The call method should always return a Result.
    def call
      if user.save
        some_private_method
        Result.new(ok: true, user: user)
      else
        some_more_stuff
        Result.new(errors: user.errors)
      end
    end

    private

    def user
      @user ||= User.new(params)
    end

    def some_private_method
      user.something
    end

  end
end
