 class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_user
  after_action :store_location
  before_action :set_promo_code_cookie_and_session

#TO REFACTOR LATER - CUSTOMIZED METHODS TO INTERCEPT DEFAULT ERROR HANDLING FOR 404s and 500s
  # rescue_from ActiveRecord::RecordNotFound, :with => :houston_we_have_a_problem
  # unless Rails.application.config.consider_all_requests_local
  #   rescue_from ActionController::RoutingError, :with => :houston_we_have_500_routing_problems
  #   rescue_from ActionController::UnknownController, :with => :houston_we_have_500_routing_problems
  # end
  # rescue_from Exception, :with => :houston_we_have_an_exceptional_problem

def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  return unless request.get?
  if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      request.path != "/apply" &&
      request.path != "/thank_you" &&
      !request.xhr? # don't store ajax calls
      )
    session[:previous_url] = request.fullpath
  end
end

def after_sign_in_path_for(resource)
  session[:previous_url] || root_path
end

def after_sign_up_path_for(resource)
  session[:previous_url] || root_path
end

def after_confirmation_path_for(resource)
  session[:previous_url] || root_path
end


def set_user
  if current_user
    cookies[:userId] = current_user.id
    else
      cookies[:userId] = 'guest'
    end
end

def authenticate_from_cookie!
  puts "!!! params for :allow are #{params[:allow]}"
  cookie_expected = @lesson.id + 30
  unless cookies[:lesson].to_i == cookie_expected.to_i || (current_user && current_user.user_type == 'Snow Schoolers Employee') || (current_user && current_user.instructor) || params[:allow] == 'true'
    puts "!!! current cookie value for lesson is: #{cookies[:lesson]} and expected value is: #{cookie_expected}"
    session[:must_sign_in] = true
    redirect_to root_path
  end
  if params[:allow] == 'true'
    cookies[:lesson] = {
      value: @lesson.id + 30,
      expires: 1.year.from_now
    }
    puts"!!!! cookie has been set to: #{cookies[:lesson]}."
  end
end


def houston_we_have_a_problem
  render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  HOUSTON_WE_HAVE_A_404_PROBLEM
end

def houston_we_have_500_routing_problems
  render :file => "#{Rails.root}/public/500.html", :status => 500, :layout => false
  HOUSTON_WE_HAVE_500_ROUTING_PROBLEMS
end

def houston_we_have_an_exceptional_problem
  render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  HOUSTON_WE_HAVE_EXCEPTIONAL_PROBLEMS
end

def confirm_admin_permissions
  return if current_user.email == 'brian@snowschoolers.com' || current_user.user_type == 'Ski Area Partner' || current_user.user_type == "Granlibakken Employee"
  redirect_to root_path, notice: 'You do not have permission to view that page.'
end

def set_promo_code_cookie_and_session
  if params[:promo_code]
    puts "!!! detected params for :promo code are #{params[:promo_code]}"
    cookies[:promo_code] = {
      value: params[:promo_code],
      expires: 1.year.from_now
    }
    session[:promo_code] = params[:promo_code]
    puts"!!!! cookie has been set to: #{cookies[:promo_code]}."
  end
end

end
