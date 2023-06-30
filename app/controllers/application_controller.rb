# frozen_string_literal: true

# ApplicationController class
class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  private

  def render_parameter_missing(error)
    render json: { error: error.message }, status: :bad_request
  end

  def render_unprocessable_entity(error)
    render json: { error: error.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
end
