require 'draugiem'

describe Draugiem do

  before(:all) do
    @app_key  = 'f496b7721fe4aefc48392fc3c8ef9146'
    @dr_auth  = 'af8aaa2ca7962643c741'
    @user_key = '38a8a804ddbcbcb674cb9a3fa2474fe7'
    # @user_key = nil
    @draugiem = Draugiem.new(@app_key, @user_key)
  end

  # it "should return apikey" do
  #   puts @draugiem.authorize(@dr_auth)['apikey']
  # end

  it "should return userdata" do
    @draugiem.user_data.should_not == ''
    @draugiem.user_data['uid']     == 162925
  end

  it "should post activity" do
    @draugiem.add_activity('test').should == {"status"=>"OK"}
  end

  it "should return app_friends" do
    @draugiem.app_friends(1, 20, false)['users'].should == []
    @draugiem.app_friends(1, 20, true)['total'].should  == 0
  end

  it "should post activity with link on page" do
    @draugiem.add_activity('test', nil, nil, {page_id: 123}).should == {"status"=>"OK"}
  end

end
