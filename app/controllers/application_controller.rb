class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf])
	end

	def after_sign_in_path_for(resource)
		if current_user.admin
			lots_path
		else
			root_path
		end
	end
	

	def is_admin?
		redirect_to root_path, notice: 'Não possui autorização' unless current_user.admin
	end

	def not_admin?
		redirect_to lots_path, notice: 'Não possui autorização' if !current_user.nil? && current_user.admin
	end
end
