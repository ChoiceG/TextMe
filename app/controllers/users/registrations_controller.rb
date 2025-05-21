# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
def create
  super do |resource|
    if resource.errors.any?
      Rails.logger.debug "User signup errors: #{resource.errors.full_messages.join(', ')}"
      respond_to do |format|
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace('sign_up_form', partial: 'devise/registrations/form', locals: { resource: resource }) 
        }
        format.html { render :new, status: :unprocessable_entity } # fallback
      end
      return
    else
      respond_to do |format|
        format.turbo_stream { 
          # Instead of redirect_to, render a Turbo Stream that performs a redirect or update
          render turbo_stream: turbo_stream.replace('sign_up_form', partial: 'some_partial_after_success', locals: { resource: resource })
          # Or if you want to redirect, you need JS that triggers a redirect on the client.
        }
        format.html { redirect_to after_sign_up_path_for(resource) }
      end
      return
    end
  end
end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
