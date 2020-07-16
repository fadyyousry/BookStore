class AuthorsController < ApplicationController
  layout 'application'
  load_and_authorize_resource
end