class Public::ItemsController < ApplicationController
  before_action :authenticate!, except: [:index]
  before_action :customers_is_deleted, except: [:index]
  def index
    @items = Item.all

  end

  def show
  end
end
