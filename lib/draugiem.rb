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

    JSON.parse(Net::HTTP.post_form(URI.parse(API_URL), params).body)
  end

  def authorize auth_code
    send action: 'authorize', code: auth_code
  end

  def user_data
    send action: 'userdata'
  end

  def app_friends page = 1, limit = 20, return_ids = false
    resp = send action: 'app_friends', page: page, limit: limit, show: return_ids ? 'ids' : nil
    if return_ids && resp['userids'].any?
      resp = {'total' => resp['total'], 'userids' => resp['userids'].map{|k, v| k.to_i}}
    end
    resp
  end

  def add_activity text, prefix = nil, link = nil, params = {}
    send({action: 'add_activity', text: text, prefix: prefix, link: link}.merge(params))
  end

end