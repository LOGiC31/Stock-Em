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

  def set_status
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item, notice: 'Item status updated successfully.'
    else
      flash[:alert] = 'Error updating status.'
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_id, :serial_number, :item_name,
                                 :category, :quality_score, :currently_available, :image, :details, :status, :comment)
  end
end
