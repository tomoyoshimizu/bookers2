class ApplicationController < ActionController::Base

  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_alert_type
  before_action :set_nav_links

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def set_alert_type
    @alert_type = { 'notice' => 'alert-success', 'alert' => 'alert-danger'}
  end

  def set_nav_links
    @nav_links = Array.new
    if user_signed_in?
      @nav_links.push(
        { path: user_path(current_user), method: :get, icon: 'fa-solid fa-house', text: 'Home'},
        { path: users_path, method: :get, icon: 'fa-solid fa-users', text: 'Users'},
        { path: books_path, method: :get, icon: 'fa-solid fa-book-open', text: 'Books'},
        { path: destroy_user_session_path, method: :delete, icon: 'fa-solid fa-right-from-bracket', text: 'Log out'},
      )
    else
      @nav_links.push(
        { path: root_path, method: :get, icon: 'fa-solid fa-house', text: 'Home'},
        { path: about_path, method: :get, icon: 'fa-solid fa-link', text: 'About'},
        { path: new_user_registration_path, method: :get, icon: 'fa-solid fa-user-plus', text: 'Sign up'},
        { path: new_user_session_path, method: :get, icon: 'fa-solid fa-right-to-bracket', text: 'Log in'},
      )
    end
  end

end
