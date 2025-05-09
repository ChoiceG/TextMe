# This is a custom controller that inherits from ApplicationController
# It's designed to make Devise (authentication) work better with Turbo Streams in Rails.
class TurboDeviseController < ApplicationController

  # This defines a custom Responder class specifically for handling Turbo Stream responses.
  class Responder < ActionController::Responder
    
    # This method tells Rails how to respond to Turbo Stream format requests.
    def to_turbo_stream
      # Try rendering the HTML version of the response even if Turbo Stream was requested.
      controller.render(options.merge(formats: :html))
    
    # If a template for Turbo Stream is missing...
    rescue ActionView::MissingTemplate => error
      if get?
        # ...and the request is a GET request, re-raise the error.
        raise error
      elsif has_errors? && default_action
        # ...and it's a form with errors, render the HTML version with error status.
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        # Otherwise, redirect to wherever the user was supposed to go next.
        redirect_to navigation_location
      end
    end
  end

  # Set this controller to use the custom Responder class above.
  self.responder = Responder

  # Tell Rails this controller can respond to both HTML and Turbo Stream formats.
  respond_to :html, :turbo_stream
end
