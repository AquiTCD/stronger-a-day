if Rails.env.development?
  OmniAuth.config.test_mode = !Rails.env.production? && ENV["MOCK_AUTH"] == "true"
  OmniAuth.config.mock_auth[:twitter2] = OmniAuth::AuthHash.new(
    {
      provider: "twitter2",
      uid: "11111111",
      info: {
        name: "ユーザー表示名",
        email: nil,
        nickname: "this_is_account_name",
        description: "プロフィールの説明",
        image: "https://example.com/profile.jpg",
        urls: {
          Website: "https://example.com/plkoAh5s9r", Twitter: "https://twitter.com/this_is_account_name"
        }
      },
      credentials: {
        token: "aaaabbbbbccccddddeeeeffffgggghhhh",
        expires_at: (Time.current + 1.day).to_i,
        expires: true
      },
      extra:{
        raw_info: {
          data: {
            description: "プロフィールの説明",
            entities: {
              url: {
                urls: [
                  {
                    start: 0,
                    end: 23,
                    url: "http://example.com",
                    expanded_url: "http://example.com",
                    display_url: "example.com"
                  }
                ]
              },
              description: { hashtags: [{start: 103, end: 108, tag: "ゲーマー"}] }
            },
            protected: false,
            id: "11111111",
            public_metrics: {
              followers_count: 750, following_count: 698, tweet_count: 29173, listed_count: 27, like_count: 4489},
            name: "ユーザー表示名",
            verified: false,
            profile_image_url: "https://example.com/normal.jpg",
            pinned_tweet_id: "111111111",
            username: "this_is_account_name",
            created_at: "2007-10-23T11:38:25.000Z",
            location: "some where",
            url: "http://example.com"
          }
        }
      }
    }
  )
end
