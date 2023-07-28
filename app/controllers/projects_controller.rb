# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :project, except: %i[index create]

  def index
    @projects = Project.order(created_at: :desc).page params[:page]
    @new_project = Project.new
  end

  def show
    return redirect_to upload_project_path(@project), status: :see_other if @project.images.empty?

    return redirect_to upload_progress_project_path(@project), status: :see_other if @project.images.unprocessed.any?

    redirect_to project_image_path(@project, @project.processed_images_in_order.first), status: :see_other
  end

  def upload_progress
    upload_progress_state
  end

  def upload_progress_poll
    upload_progress_state
    if @image_count == @processed_image_count
      return redirect_to project_image_path(@project, @project.processed_images_in_order.first), status: :see_other
    end

    render template: 'projects/upload_progress', layout: false
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path, status: :see_other
    else
      @projects = Project.order(created_at: :desc)
      @new_project = Project.new
      render :index, status: :unprocessable_entity
    end
  end

  def update
    uploaded_images = project_params[:images].compact_blank
    if uploaded_images.present?
      uploaded_images.each do |data|
        image = Image.new(project: @project)
        image.document.attach(data)
        image.save!
      end
      ExtractTextFromImagesJob.perform_later(@project.id)
    else
      flash[:error] = 'No images selected'
      return redirect_to upload_project_path(@project), status: :see_other
    end

    redirect_to project_path(@project), status: :see_other
  end

  def upload; end

  def destroy
    @project.destroy
    redirect_to projects_path, status: :see_other
  end

  private

  def project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, images: [])
  end

  def upload_progress_state
    @image_count = @project.images.count
    @processed_image_count = @project.images.processed.count
    @progress = ((@processed_image_count.to_f / @image_count) * 100).round
  end
end
