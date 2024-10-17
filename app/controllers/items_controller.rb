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
	@writing_note = ! params[:writing_note].nil?
	@notes = Note.where(item_id: @item.id).order('created_at DESC')
  end
  
  # add note to item
  def add_note
    @item = Item.find(params[:id])
    Note.create!({ note_id: '', item: @item, msg: params[:note_msg], user: User.find_by(id: session[:user_id]), created_at: DateTime.now, updated_at: DateTime.now})
	
	respond_to do |format|
      format.html { redirect_to item_path(@item)}
      format.json { head :no_content }
    end
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