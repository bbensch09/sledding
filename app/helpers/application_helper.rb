module ApplicationHelper

# lib/google_analytics_api.rb
require 'rest_client'

def resource_name
  :user
end

def resource
  @resource ||= User.new
end

def devise_mapping
  @devise_mapping ||= Devise.mappings[:user]
end

def confirm_admin_permissions
  unless current_user && (current_user.email == 'brian@snowschoolers.com' ||current_user.email == 'AlexDominguez@granlibakken.com' ||current_user.email == 'brian+sledding@granlibakken.com' || current_user.user_type == 'Ski Area Partner' || current_user.user_type == "Granlibakken Employee")    
    redirect_to root_path, notice: 'You must be signed in as an administrator to view this page.'
  end
end

def title(title = nil)
    if title.present?
      content_for :title, title + ' | Granlibakken '
    else
      content_for?(:title) ? content_for(:title) : 'Granlibakken'
    end
end

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text='Browse instructors, compare prices, and book lessons at your favorite resort.')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end


end
