module ErrorHandleable
  extend ActiveSupport::Concern

  class InMaintenance < StandardError; end

  unless Rails.env.development?
    included do
      rescue_from StandardError, with: :render500
      rescue_from ActiveRecord::RecordNotFound, with: :render404
      rescue_from ActionController::RoutingError, with: :render404
      rescue_from InMaintenance, with: :render503
    end
  end

  private

    def render400(exception = nil, messages = nil)
      Sentry.capture_exception(exception)
      render "errors/404", status: :not_found, layout: "error"
    end

    def render404(exception = nil, messages = nil)
      Sentry.capture_exception(exception)
      render "errors/404", status: :not_found, layout: "error"
    end

    def render500(exception = nil, messages = nil)
      Sentry.capture_exception(exception)
      render "errors/404", status: :not_found, layout: "error"
    end

    def render503(exception = nil, messages = nil)
      Sentry.capture_exception(exception)
      render "errors/503", status: :not_found, layout: "error"
    end
end
