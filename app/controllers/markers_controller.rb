class MarkersController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def index
    @markers = Marker.all
    respond_to do |format|
      format.html
      format.json { render json: @markers }
    end
  end

  def create
    marker = Marker.create(marker_params)
    render json: marker
  end

  private

  def marker_params
    params.require(:marker).permit(:lat, :lng)
  end
end
