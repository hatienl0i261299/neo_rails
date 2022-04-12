# frozen_string_literal: true

require 'yaml'
require_relative '../../common/helper'

# Application controller
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token
  rescue_from Exception, with: :server_internal_error
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from NoMethodError, with: :bad_request
  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from AbstractController::ActionNotFound, with: :not_found
  rescue_from ActionController::MethodNotAllowed, with: :server_internal_error
  rescue_from ActionController::UnknownHttpMethod, with: :server_internal_error
  rescue_from ActionController::NotImplemented, with: :bad_request
  rescue_from ActionController::UnknownFormat, with: :bad_request
  rescue_from ActionController::InvalidAuthenticityToken, with: :bad_request
  rescue_from ActionController::InvalidCrossOriginRequest, with: :bad_request
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
  rescue_from ActionController::BadRequest, with: :bad_request
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from Rack::QueryParser::ParameterTypeError, with: :bad_request
  rescue_from Rack::QueryParser::InvalidParameterError, with: :bad_request
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::StaleObjectError, with: :server_internal_error
  rescue_from ActiveRecord::RecordInvalid, with: :bad_request
  rescue_from ActiveRecord::RecordNotSaved, with: :bad_request

  before_action :authenticate_user, :set_locale

  def router_not_found
    render json: {
      error: I18n.t('exception.not_found'),
      error_detail: "Routing doesn't work"
    }, status: :not_found
  end

  private

  def set_locale
    locale = request.headers[:locale]
    I18n.locale = locale || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def server_internal_error(error = '', message = '')
    render json: {
      error: I18n.t('exception.server_internal_error'),
      error_detail: message,
      exception: Rails&.env&.production? ? '' : error
    }, status: :internal_server_error
  end

  def bad_request(error = '')
    render json: {
      error: I18n.t('exception.bad_request'),
      error_detail: error
    }, status: :bad_request
  end

  def not_found(error = '')
    render json: {
      error: I18n.t('exception.not_found'),
      error_detail: error
    }, status: :not_found
  end

  def forbidden(_error = '')
    head :forbidden
  end

  def permission?(group, role)
    return true if @current_user.group.group_role == group && (@current_user.group.roles.pluck('name').include? role)

    false
  end

  def authenticate_user
    @current_user ||= AuthorizeApiRequest.new(request.headers).call
    # data_permission = YAML.load_file('common/permission.yaml')
    # original_fullpath = request.original_fullpath.to_s.gsub(%r{(/\?|\?).*}, '').split('/').map(&:strip).reject(&:empty?)
    if @current_user
      # user_group_role = @current_user.group.group_role
      # unless user_group_role == GroupRole.new.admin
      #   temp_data = data_permission
      #   original_fullpath.each do |url|
      #     return forbidden unless temp_data.present?
      #
      #     temp_data = temp_data[url] || temp_data['<param>']
      #   end
      #
      #   return forbidden unless temp_data.present?
      #
      #   roles = temp_data[request.method]
      #   return if (roles.present? && (roles.include? user_group_role)) || roles == ['ALL']
      #
      #   forbidden
      # end
    else
      head :unauthorized unless @current_user
    end
  rescue StandardError => _e
    forbidden
  end
end
