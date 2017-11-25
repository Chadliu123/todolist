class ListsController < ApplicationController
  before_action :set_list, :only => [:show, :edit, :update, :destroy, :complete]

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_url
    else
      render  :action => :new
    end
  end

  def update
    if @list.update_attributes(list_params)
      redirect_to list_path(@list)
    else
      render :edit
    end
  end

  def destroy
    @list.destroy

    redirect_to lists_url
  end

  def complete
    @list.update(complete: !(@list.complete))
  end

 
  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :date, :note, :completed)
  end
end