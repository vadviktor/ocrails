class ProjectsController < ApplicationController
  def index
    @projects = Project.order(created_at: :desc)
  end

  def show
    raise NotImplementedError
  end

  def create
    raise NotImplementedError
  end

  def destroy
    raise NotImplementedError
  end
end
