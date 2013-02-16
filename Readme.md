# Draugiem api ruby client

Ruby wrapper for the [Draugiem](http://www.draugiem.lv/applications/dev/docs/pages/).

## Rails Gemfile

    gem 'draugiem'

## Usage

    app_key = '...'
    client = Draugiem.new(app_key).authorize(params[:dr_auth_code])

    user_key = client['apikey']

    draugiem = Draugiem.new(app_key, user_key)

    friend_ids = draugiem.app_friends(1, 200, true)['userids']