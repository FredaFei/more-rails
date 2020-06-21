class ApplicationController < ActionController::API
  # include ActionView::Layouts

  def render_resource(resource)
    if resource.errors.empty?
      render json: {resource: resource}, status: 200
    else
      render json: {errors: resource.errors}, status: 400
    end
  end
end
