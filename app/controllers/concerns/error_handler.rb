module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from StandardError, with: :standard_error_handler
  end

  private

  def record_not_found(exception)
    logger.warn "Record not found: #{exception.message}"
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, alert: "Registro não encontrado." }
      format.json { render json: { success: false, message: "Registro não encontrado." }, status: :not_found }
    end
  end

  def standard_error_handler(exception)
    logger.error "Erro inesperado: #{exception.message}"
    logger.error exception.backtrace.join("\n")
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, alert: "Ocorreu um erro inesperado. Tente novamente." }
      format.json { render json: { success: false, message: "Erro interno do servidor." }, status: :internal_server_error }
    end
  end
end
