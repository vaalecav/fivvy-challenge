# frozen_string_literal: true

# ApplicationController class
class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing

  private

  def render_parameter_missing(error)
    render json: { error: error.message }, status: :bad_request
  end
end
