class SocialPostsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    if params['hub.mode'] == 'subscribe'
      render text: params['hub.challenge']
    else
      render text: 'No challenge parameter sent.'
    end
  end

  def create
    begin
      Instagram.process_subscription(request.body) do |handler|
        handler.on_user_changed do |user_id, data|
          client = Instagram.client(access_token: ENV['INSTAGRAM_TOKEN'])
          post = client.media_item(data['data']['media_id'])
          SocialPost.create!(
            service: 'instagram',
            service_id: post['id'],
            link: post['link'],
            oembed: HTTParty.get("https://api.instagram.com/oembed?url=#{post['link']}&omitscript=true")['html']
          )
          render text: "user_id: #{user_id} media_id: #{data['data']['media_id']}"
        end
      end
    rescue
      render text: 'looks like there is something wrong with your request...'
    end
  end
end
