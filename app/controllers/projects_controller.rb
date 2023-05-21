class ProjectsController < ApplicationController
  def index
    @projects = Project.order(created_at: :desc)
    @new_project = Project.new
  end

  def show
    raise NotImplementedError
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to root_path
    else
      @projects = Project.order(created_at: :desc)
      @new_project = Project.new
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    raise NotImplementedError
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
