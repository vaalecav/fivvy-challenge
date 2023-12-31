# frozen_string_literal: true

# AcceptancesController class
class AcceptancesController < ApplicationController
  def index
    render json: acceptances
  end

  def create
    created_acceptance = Acceptance.create!(create_params)
    render json: created_acceptance, status: :created
  end

  private

  def acceptances
    @acceptances ||= Acceptance.where(params.permit(:user_id))
  end

  def create_params
    acceptances_params = %i[disclaimer_id user_id]
    params.require(acceptances_params)
    params.permit(acceptances_params)
  end
end
