require 'draugiem'

describe Draugiem do

  before(:all) do
    @app_id     = 15012395
    @app_key    = 'f496b7721fe4aefc48392fc3c8ef9146'
    @dr_auth    = 'af8aaa2ca7962643c741'
    @user_key   = '38a8a804ddbcbcb674cb9a3fa2474fe7'
    # @user_key     = nil
    @draugiem = Draugiem.new(@app_id, @app_key, @user_key)
  end

  # it "should return apikey" do
  #   puts @draugiem.authorize(@dr_auth)['apikey']
  # end

  it "should return userdata" do
    @draugiem.user_data.should_not == ''
    @draugiem.user_data['uid']     == 162925
  end

end
