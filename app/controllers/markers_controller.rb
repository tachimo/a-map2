class MarkersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @markers = Marker.all
  end

  def create
    Marker.create(lat: params[:lat], lng: params[:lng])
    head :ok
  end
end
