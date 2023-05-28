class ProjectsController < ApplicationController
  def index
    @projects = Project.order(created_at: :desc)
    @new_project = Project.new
  end

  def show
    @project = Project.find(params[:id])
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

  def update
    @project = Project.find(params[:id])
    images = project_params[:images]
    if @project.images.attach(images)
      redirect_to project_path(@project)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    raise NotImplementedError
  end

  private

  def project_params
    params.require(:project).permit(:name, images: [])
  end
end
