class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :require_token

  private

  def require_token
    expected = ENV["MAP_ACCESS_TOKEN"]
    provided = params[:token]

    Rails.logger.debug "=== TOKEN DEBUG ==="
    Rails.logger.debug "provided: #{provided}"
    Rails.logger.debug "expected: #{expected}"
    Rails.logger.debug "==================="

    if expected.blank? || provided.blank? ||
       !ActiveSupport::SecurityUtils.secure_compare(provided, expected)
      render plain: "Unauthorized", status: :unauthorized
    end
  end

end
