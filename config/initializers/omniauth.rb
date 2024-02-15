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
  OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(
    {
      provider: "discord",
      uid: "22222222222222",
      info:  {
      name: "discord_tarou",
        email: nil,
        image:  "https://example.com/normal.jpg"
      },
      credentials:  {
        token: "xxxxxxxxxxxxxxxxxxxxxx",
        refresh_token: "yyyyyyyyyyyyyyyyyyyyyy",
        expires_at: (Time.current + 1.day).to_i,
        expires: true
      },
      extra:  {
        raw_info:  {
          id: "222222222222222222",
          username: "discord_tarou",
          avatar: "xyzxyzxyzxyz",
          discriminator: "0",
          public_flags: 0,
          premium_type: 0,
          flags: 0,
          banner: nil,
          accent_color: 16720418,
          global_name: "ディスコ太郎",
          avatar_decoration_data: nil,
          banner_color: "#ff2222",
          mfa_enabled: true,
          locale: "ja"
        }
      }
    }
  )
  OmniAuth.config.mock_auth[:steam] = OmniAuth::AuthHash.new(
    {
      provider: "steam",
      uid: "3333333333333333",
      info:  {
        nickname: "steam_jirou",
        name: "スチーム次郎",
        location: "",
        image:  "https://example.com/normal.jpg",
        urls:  {
          Profile: "https://example.com",
          FriendList:  ""
          }
        },
      credentials: {},
      extra:  {
        raw_info:  {
          steamid: "3333333333333333",
          communityvisibilitystate: 3,
          profilestate: 1,
          personaname: "steam_jirou",
          profileurl: "https://example.com/",
          avatar: "https://example.com/normal.jpg",
          avatarmedium: "https://example.com/medium.jpg",
          avatarfull: "https://example.com/full.jpg",
          avatarhash: "xyzxyzxyzxyzxyz",
          lastlogoff: 1707910119,
          personastate: 0,
          realname: "スチーム次郎",
          primaryclanid: "123123123123123",
          timecreated: 1679529113,
          personastateflags: 0
        }
      }
    }
  )
end
