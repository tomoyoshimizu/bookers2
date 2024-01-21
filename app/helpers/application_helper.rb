module ApplicationHelper

  def to_alert_type(message_type)
    case message_type
    when "notice" then
      "alert-success"
    when "alert" then
      "alert-danger"
    end
  end

  def nav_links
    if user_signed_in? then
      [
        { path: user_path(current_user), method: :get, icon: 'fa-solid fa-house', text: 'Home'},
        { path: users_path, method: :get, icon: 'fa-solid fa-users', text: 'Users'},
        { path: books_path, method: :get, icon: 'fa-solid fa-book-open', text: 'Books'},
        { path: destroy_user_session_path, method: :delete, icon: 'fa-solid fa-right-from-bracket', text: 'Log out'},
      ]
    else
      [
        { path: root_path, method: :get, icon: 'fa-solid fa-house', text: 'Home'},
        { path: about_path, method: :get, icon: 'fa-solid fa-link', text: 'About'},
        { path: new_user_registration_path, method: :get, icon: 'fa-solid fa-user-plus', text: 'Sign up'},
        { path: new_user_session_path, method: :get, icon: 'fa-solid fa-right-to-bracket', text: 'Log in'},
      ]
    end
  end

end
