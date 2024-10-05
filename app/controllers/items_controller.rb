# frozen_string_literal: true

# Contains logic for web pages which display item(s)
class ItemsController < ApplicationController
  # get all the items
  def index
    @items = Item.all
  end

  # get specific item
  def show
    @item = Item.find(params[:id])
  end

  # create new item

  # def create
  #   @item = Item.new(item_params)
  #   if @item.save
  #     redirect_to @item
  #   else
  #     render :new
  #   end
  # end


  # edit item
  # def edit
  #   @item = Item.find(params[:id])
  # end


  # def item_params
  #   params.require(:item).permit(:item_id, :serial_number, :item_name,
  #                                  :category, :quality_score, :currently_available, :image, :details)
  # end
end
