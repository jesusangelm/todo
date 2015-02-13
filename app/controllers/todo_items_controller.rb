class TodoItemsController < ApplicationController
  before_action :search_todolist, only: [ :create, :destroy, :complete ]
  before_action :search_todoitem, except: :create

  def create
    @todo_item = @todo_list.todo_items.create(todoitem_params)
    redirect_to todo_list_path(@todo_list)
  end

  def destroy
    if @todo_item.destroy
      flash[:success] = "Tarea eliminada de la lista."
    else
      flash[:error] = "Tarea no pudo ser eliminada."
    end

    redirect_to @todo_list
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Tarea completada"
  end

  private

  def search_todoitem
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def search_todolist
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todoitem_params
    params.require(:todo_item).permit(:content)
  end
end
