# frozen_string_literal: true

# Contains logic for web pages which display item(s)
class ItemsController < ApplicationController
  # get all the items
  def index # rubocop:disable Metrics/AbcSize
    @items = Item.all

    if params[:query].present?
      query = params[:query].downcase
      @items = @items.select do |item|
        item.item_name.downcase.include?(query) || item.category.downcase.include?(query)
      end
    end
    return unless params[:available_only] == '1'

    @items = @items.select(&:currently_available)
  end

  # get specific item
  def show
    @item = Item.find(params[:id])
    @writing_note = !params[:writing_note].nil?
    @notes = Note.where(item_id: @item.id).order('created_at DESC')
  end

  # add note to item
  def add_note # rubocop:disable Metrics/AbcSize
    @item = Item.find(params[:id])
    Note.create!({ note_id: '', item: @item, msg: params[:note_msg], user: User.find_by(id: session[:user_id]),
                   created_at: DateTime.now, updated_at: DateTime.now })

    respond_to do |format|
      format.html { redirect_to item_path(@item) }
      format.json { head :no_content }
    end
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
    status = nil if status.blank?
    status
  end

  def update # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    @item = Item.find(params[:id])
    original_params = item_params.dup
    if @item.update(item_params)
      if params[:item][:status] == 'Not Available' || params[:item][:status] == 'Lost'
        @item.update(currently_available: false) # Update available to false
      end
      if params[:item][:status] == 'Damaged' || params[:item][:status] == 'Available'
        @item.update(currently_available: true) # Update available to false
      end
      flash[:notice] = 'Item was successfully updated.'
    else
      flash[:alert] = 'There was a problem updating the item.'
      @item.update(original_params)
    end
    redirect_to @item
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:notice] = 'Item was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete the item.'
    end
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:item_id, :serial_number, :item_name,
                                 :category, :quality_score, :currently_available, :image, :details, :status, :comment)
  end
end
