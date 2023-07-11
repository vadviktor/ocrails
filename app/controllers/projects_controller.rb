class ProjectsController < ApplicationController
  before_action :get_project, only: [:show, :update, :destroy, :upload]

  def index
    @projects = Project.order(created_at: :desc)
    @new_project = Project.new
  end

  def show
    images = @project.processed_images_in_order
    return redirect_to upload_project_path(@project), status: :see_other if images.blank?
    redirect_to project_image_path(@project, images.first)
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
    uploaded_images = project_params[:images].reject(&:blank?)
    if uploaded_images.present?
      uploaded_images.each do |data|
        image = Image.new(project: @project)
        image.document.attach(data)
        image.save!
      end
      ExtractTextFromImagesJob.perform_now(@project.id)
    end

    redirect_to project_path(@project), status: :see_other
  end

  def upload
  end

  def destroy
    @project.destroy
    redirect_to projects_path, status: :see_other
  end

  private

  def get_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, images: [])
  end
end
