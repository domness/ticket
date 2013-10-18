class ItemsController < ApplicationController
  before_filter :find_project

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.creator_id = current_user.id
    @item.project_id = @project.id
    if @item.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  private

    def find_project
      @project = Project.find(params[:project_id])
    end

    def item_params
      params.require(:item).permit(:title, :description, :status, :number, :store, :who, :what, :why, :item_type, :assignee_id)
    end

end
