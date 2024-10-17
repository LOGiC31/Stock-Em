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
    valid_statuses = [nil, 'Damaged', 'Lost', 'Not Available']

    status = get_valid_status(item_params[:status])
    if valid_statuses.include?(status) && @item.update(item_params)
      flash[:notice] = 'Item status updated successfully.'
      redirect_to @item
    else
      flash[:alert] = 'Error updating status. Status must be nil, Damaged, Lost, or Not Available.'
      render :show
    end
  end

  def get_valid_status(status)
    status = nil if status.empty?
    status
  end

  private

  def item_params
    params.require(:item).permit(:item_id, :serial_number, :item_name,
                                 :category, :quality_score, :currently_available, :image, :details, :status, :comment)
  end
end
