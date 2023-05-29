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
    uploaded_images = project_params[:images].reject(&:blank?)
    if uploaded_images.present?
      uploaded_images.each do |ui|
        image = Image.new(project: @project)
        image.document.attach(ui)
        image.save!
      end
      ExtractTextFromImagesJob.perform_later(@project.id)
    end

    redirect_to project_path(@project)
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
