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
      redirect_to projects_path
    else
      @projects = Project.order(created_at: :desc)
      @new_project = Project.new
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])
    images = project_params[:images].reject(&:blank?)
    if images.blank?
      redirect_to project_path(@project)
    elsif @project.images.attach(images)
      ExtractTextFromImagesJob.perform_later(@project.id)
      redirect_to project_path(@project)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    redirect_to projects_path, status: :see_other
  end

  private

  def project_params
    params.require(:project).permit(:name, images: [])
  end
end
