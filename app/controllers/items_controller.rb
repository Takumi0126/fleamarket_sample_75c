class ItemsController < ApplicationController
  
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
  end

  
end
