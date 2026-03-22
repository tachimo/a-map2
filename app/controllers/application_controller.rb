class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :require_token

  private

  def require_token
    token = params[:token] || request.headers["X-ACCESS-TOKEN"]

    unless ActiveSupport::SecurityUtils.secure_compare(
      token.to_s,
      ENV["MAP_ACCESS_TOKEN"].to_s
    )
      render plain: "Unauthorized", status: :unauthorized
    end
  end

end
