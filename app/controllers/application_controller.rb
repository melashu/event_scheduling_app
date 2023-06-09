class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameteres, if: :devise_controller?
    protect_from_forgery with: :exception # help to generate, encrypt and descrypt CSRF tooken 
# protect_from_forgery is defined RequestForgeryProtection concern 
    def configure_permitted_parameteres
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name booking_link])
        devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name booking_link])
    end
end
