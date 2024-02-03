module MetaTagsHelper
  def default_meta_tags
    {
      charset: "utf-8",
      site: Settings.site.name,
      reverse: true,
      title: @page_title,
      description: description_for(@page_description),
      keywords: @page_keywords || Settings.site.keywords,
      canonical: @page_title.present? ? url_for(only_path: false, protocol: "https") : root_url,
      icon: Settings.site.favicon,
      og: default_og,
      twitter: default_twitter
    }
  end

  def noindex?
    !action_name.in?(%w[index show])
  end

  private

    def default_og
      return if noindex?

      {
        title: title_for(og_title),
        description: description_for(og_description),
        type: Settings.site.meta.og.type,
        url: :canonical,
        image: image_for(@og_image),
        site_name: Settings.site.name,
        locale: "ja_JP"
      }
    end

    def default_twitter
      return if noindex?

      {
        card: "summary", # or "summary_large_image"
        title: title_for(twitter_title),
        description: description_for(twitter_description),
        image: image_for(twitter_image)
      }
    end

    def og_title
      @og_title || @page_title
    end

    def og_description
      @og_description || @page_description
    end

    def twitter_title
      @twitter_title || og_title
    end

    def twitter_description
      @twitter_description || og_description
    end

    def twitter_image
      @twitter_image || @og_image
    end

    def title_for(title)
      if title
        "#{title} | #{Settings.site.title}"
      else
        Settings.site.title
      end
    end

    def description_for(description)
      description || Settings.site.description
    end

    def image_for(image)
      image || image_url(Settings.site.meta.og.image)
    end
end
