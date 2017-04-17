class SessionsController < ApplicationController

  def login
    auth_hash = request.env['omniauth.auth']
    # raise  # this raise will raise an error and let you see what is in the auth_hash ☺ Don’t want this all the time
    
  end
end
