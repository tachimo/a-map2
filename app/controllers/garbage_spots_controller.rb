class GarbageSpotsController < ApplicationController
  # 一覧・詳細は閲覧トークンだけでOK
  skip_before_action :require_token, only: [:index, :show]

  # 編集系だけ別トークン要求
  before_action :require_edit_token, only: [:create, :update, :destroy]

  def index
    render json: GarbageSpot.all
  end

  def show
    render json: GarbageSpot.find(params[:id])
  end

  def create
    spot = GarbageSpot.create!(spot_params)
    render json: spot
  end

  def update
    spot = GarbageSpot.find(params[:id])
    spot.update!(spot_params)
    render json: spot
  end

  def destroy
    spot = GarbageSpot.find(params[:id])
    spot.destroy
    head :no_content
  end

  private

  def require_edit_token
    token = request.headers["X-EDIT-TOKEN"]

    unless ActiveSupport::SecurityUtils.secure_compare(
      token.to_s,
      ENV["EDIT_TOKEN"].to_s
    )
      render json: { error: "forbidden" }, status: :forbidden
    end
  end

  def spot_params
    params.require(:garbage_spot).permit(:name, :lat, :lng, :status, :rules)
  end
end
