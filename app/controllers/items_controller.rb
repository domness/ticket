# Defines creation of items within a project
class ItemsController < ApplicationController
  before_filter :find_project
  before_filter :find_item, only:
                [:edit, :update, :start, :stop, :complete, :reject]

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

  def edit
  end

  def update
    if @item.update_attributes(item_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def start
    @item.start
    redirect_to project_path(@project)
  end

  def stop
    @item.stop
    redirect_to project_path(@project)
  end

  def complete
    @item.complete
    redirect_to project_path(@project)
  end

  def reject
    @item.start
    redirect_to project_path(@project)
  end

  private

    def find_project
      @project = Project.find(params[:project_id])
    end

    def item_params
      params.require(:item).permit(:title, :description, :status, :number,
                                   :score, :who, :what, :why, :item_type,
                                   :assignee_id)
    end

    def find_item
      @item = Item.find(params[:id])
    end

end
