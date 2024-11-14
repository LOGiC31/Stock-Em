# frozen_string_literal: true

# Contains logic for web pages which display item(s)
class ItemsController < ApplicationController
  include EventLogger
  # get all the items
  def index # rubocop:disable Metrics/AbcSize
    @items = Item.all

    apply_keyword_search if params[:query].present?
    apply_category_filter if params[:category].present?
    apply_status_filter if params[:status].present?
    apply_availability_filter if params[:available_only] == '1'

    @categories = Item.distinct.pluck(:category)
    @statuses = Item.distinct.pluck(:status)
  end

  def apply_keyword_search
    keywords = params[:query].split(' ')
    query_conditions = generate_query_conditions(keywords)
    query_params = generate_query_params(keywords)

    @items = @items.where(query_conditions, *query_params)
  end

  def generate_query_conditions(keywords)
    condition = <<-SQL.strip_heredoc
      (LOWER(item_name) LIKE :keyword OR#{' '}
      LOWER(category) LIKE :keyword OR#{' '}
      LOWER(status) LIKE :keyword OR#{' '}
      LOWER(CASE WHEN currently_available THEN 'available'#{' '}
      ELSE 'not available' END) LIKE :keyword)
    SQL

    keywords.map { condition }.join(' AND ')
  end

  def generate_query_params(keywords)
    keywords.flat_map { |keyword| { keyword: "%#{keyword.downcase}%" } }
  end

  def apply_category_filter
    @items = @items.where(category: params[:category])
  end

  def apply_status_filter
    @items = if params[:status] == 'unknown'
               @items.where(status: nil)
             else
               @items.where(status: params[:status])
             end
  end

  def apply_availability_filter
    @items = @items.select(&:currently_available)
  end

  # def index
  #   @items = Item.all

  #   # if params[:query].present?
  #   #   query = params[:query].downcase
  #   #   @items = @items.select do |item|
  #   #     item.item_name.downcase.include?(query) || item.category.downcase.include?(query)
  #   #   end
  #   # end

  #   @categories = Item.distinct.pluck(:category)
  #   @statuses = Item.distinct.pluck(:status)

  #   if params[:query].present?
  #     keywords = params[:query].split(' ')

  #     condition = <<-SQL.strip_heredoc
  #       (LOWER(item_name) LIKE :keyword OR#{' '}
  #       LOWER(category) LIKE :keyword OR#{' '}
  #       LOWER(status) LIKE :keyword OR#{' '}
  #       LOWER(CASE WHEN currently_available THEN 'available'#{' '}
  #       ELSE 'not available' END) LIKE :keyword)
  #     SQL

  #     # Map keywords to SQL conditions and join them with 'AND'
  #     query_conditions = keywords.map { condition }.join(' AND ')

  #     # Map each keyword into a hash format to be used in the query
  #     query_params = keywords.flat_map { |keyword| { keyword: "%#{keyword.downcase}%" } }

  #     # Apply the query
  #     @items = @items.where(query_conditions, *query_params)

  #   end

  #   @items = @items.where(category: params[:category]) if params[:category].present?

  #   if params[:status].present?
  #     @items = if params[:status] == 'unknown'
  #                @items.where(status: nil)
  #              else
  #                @items.where(status: params[:status])
  #              end
  #   end

  #   return unless params[:available_only] == '1'

  #   @items = @items.select(&:currently_available)
  # end

  # get specific item
  def show
    @item = Item.find(params[:id])
    @writing_note = !params[:writing_note].nil?
    @notes = Note.where(item_id: @item.id).order('created_at DESC')
    @events = Event.where(item_id: @item.id).order('created_at DESC')
  end

  # create new item
  def new
    @item = Item.new
    render :new
  end

  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    if current_user.auth_level != 0
      if Item.exists?(serial_number: @item.serial_number)
        flash[:alert] = 'Item already exists with this serial number.'
        render :new
      elsif @item.save
        redirect_to items_path, notice: 'Item was successfully created.'
      else
        render :new
      end
    else
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to items_path
  end

  # add note to item
  def add_note # rubocop:disable Metrics/AbcSize
    @item = Item.find(params[:id])
  
    if current_user.auth_level == 1 || current_user.auth_level == 2  # Assuming auth_level 2 is for admins
      Note.create!({
        note_id: '',
        item: @item,
        msg: params[:note_msg],
        user: User.find_by(id: session[:user_id]),
        created_at: DateTime.now,
        updated_at: DateTime.now
      })
  
      flash[:notice] = 'Note successfully added.'
    else
      flash[:alert] = 'You need to be an admin or assistant to update the status of this item.'
    end
  
    respond_to do |format|
      format.html { redirect_to item_path(@item) }
      format.json { head :no_content }
    end
  end

  def update # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/PerceivedComplexity
    @item = Item.find(params[:id])
    Rails.logger.info("Current user auth level: #{current_user.auth_level}")
    if current_user.auth_level == 2
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
    else
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to item_path(@item)
    end
  end

  def destroy
    @item = Item.find(params[:id])
    Rails.logger.info("Current user auth level: #{current_user.auth_level}")
    if current_user.auth_level == 2
      if @item.destroy
        flash[:notice] = 'Item was successfully deleted.'
        redirect_to items_path
      else
        flash[:alert] = 'Failed to delete the item.'
        redirect_to item_path(@item)
      end
    else
      flash[:alert] = 'You need to be an admin to delete items.'
      redirect_to item_path(@item)
    end
  end

  def set_status # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    @item = Item.find(params[:id])
    @notes = Note.where(item_id: @item.id).order('created_at DESC')

    if current_user.auth_level == 0
      flash[:alert] = 'You need to be an admin or assistant to update the status of this item.'
      redirect_to item_path(@item) and return
    end

    valid_statuses = [nil, 'Damaged', 'Lost', 'Not Available', 'Intact']
    status = get_valid_status(item_params[:status])

    if valid_statuses.include?(status) && @item.update(item_params)
      log_event(params[:id], 'status_update', "Status Updated to #{status}", session[:user_id])
      flash[:notice] = 'Item status updated successfully.'
      redirect_to @item
    else
      flash[:notice] = 'Error updating status. Status must be nil, Damaged, Lost, Not Available, or Intact.'
      render :show
    end
  end

  def get_valid_status(status)
    status = nil if status.blank?
    status
  end

  def item_params
    params.require(:item).permit(:item_id, :serial_number, :item_name,
                                 :category, :quality_score, :currently_available, :image, :details, :status, :comment)
  end
end
