# frozen_string_literal: true

# Contains logic for web pages which display item(s)
class ItemsController < ApplicationController
  # get all the items
  def index
    @items = Item.all
    puts(@items.inspect)
  end

  # get specific item
  def show
    @item = Item.find(params[:id])
  end

  # create new item
  def new
    @item = Item.new
    render :new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category, :quantity, :quality_score, :currently_available, :serial_number, :details)
  end

  # edit item
  # def edit
  #   @item = Item.find(params[:id])
  # end

  # def item_params
  #   params.require(:item).permit(:item_id, :serial_number, :item_name,
  #                                  :category, :quality_score, :currently_available, :image, :details)
  # end
end