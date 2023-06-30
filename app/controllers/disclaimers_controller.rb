# frozen_string_literal: true

# DisclaimersController class
class DisclaimersController < ApplicationController
  def index
    render json: list_disclaimers
  end

  def show
    render json: disclaimer
  end

  def create
    created_disclaimer = Disclaimer.create!(create_params)
    render json: created_disclaimer, status: :created
  end

  def update
    disclaimer.update!(update_params)
    render json: disclaimer
  end

  def destroy
    disclaimer.destroy!
    head :no_content
  end

  private

  def disclaimer
    @disclaimer ||= Disclaimer.find(params.require(:id))
  end

  def list_disclaimers
    text_param = params.permit(:text)
    return Disclaimer.where('text ILIKE ?', "%#{params[:text]}%") if text_param.present?

    Disclaimer.all
  end

  def create_params
    params.require(disclaimer_params)
    params.permit(disclaimer_params)
  end

  def update_params
    params.permit(disclaimer_params)
  end

  def disclaimer_params
    %i[name text version]
  end
end
