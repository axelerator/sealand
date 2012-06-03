class ApplicationController < ActionController::Base
  protect_from_forgery

  def sanitize_clean( html )
    Sanitize.clean(html, Sanitize::Config::BASIC)
  end

end
