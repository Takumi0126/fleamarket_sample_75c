class ItemsController < ApplicationController
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  
  def get_category_children
    @category_children = Category.find(params[:parent_name]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  


  def index
    @items = Item.includes(:images).order('created_at DESC')
    
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def show
  end



  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    @item.images.new
    @grandchild_category = @item.category
    @child_category = @grandchild_category.parent 
    @category_parent = @child_category.parent
  
    @category = Category.find(params[:id])
    
    @category_children = @item.category.parent.parent.children
    @category_grandchildren = @item.category.parent.children
  end

  def update
    @item = Item.update(item_params)
    if @item.save
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description,:brand,:condition_id,:shipping_area_id,:shipping_method_id,:shipping_burden_id,:category_id,:seller_id,:buyer_id,:shipping_data,:price,:image_cache,images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_category  
    @category_parent_array = Category.where(ancestry: nil)
  end

  

end

