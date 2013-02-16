require 'net/http'
require 'uri'
require 'json'

class Draugiem

  API_URL = 'http://api.draugiem.lv/json/'
  attr_accessor :app_key, :user_key

  def initialize app_key, user_key = nil
    @app_key, @user_key = app_key, user_key
  end

  def send(params = {})
    params[:app]    = app_key
    params[:apikey] = user_key

    response = JSON.parse(Net::HTTP.post_form(URI.parse(API_URL), params).body)
    raise ServerError.new self, params, response['error'] if response['error']
    response
  end

  def authorize auth_code
    send({action: 'authorize', code: auth_code})
  end

  def user_data
    send({action: 'userdata'})
  end

  def add_activity text, prefix = nil, link = nil, params = {}
    send({action: 'add_activity', text: text, prefix: prefix, link: link}.merge(params))
  end

  class Error < ::StandardError; end

  class ServerError < Error
    attr_accessor :session, :params, :error
    def initialize(session, params, error)
      super "Server side error calling Draugiem action: #{session}, #{params}, #{error}"
      @session, @params, @error = session, params, error
    end
  end

end