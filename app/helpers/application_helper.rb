module ApplicationHelper
  def default_meta_tags
    {
      charset: 'utf-8',
      site: Settings.site.name,
      reverse: true,
      title: @page_title || Settings.site.meta.title,
      description: @page_description || Settings.site.meta.description,
      canonical: url_for(only_path: false, protocol: 'https'),
      # icon: Settings.site.meta.favicon,
      og: default_og
      # twitter: default_twitter
    }
  end

  def default_og
    {
      title: @og_title || Settings.site.meta.og.title,
      description: @og_description || Settings.site.meta.og.description,
      type: Settings.site.meta.og.type,
      url: :canonical,
      image: page_og_image,
      site_name: Settings.site.name,
      locale: 'ja_JP'
    }
  end

  def page_og_image
    @page_image || image_url(Settings.site.meta.og.image)
  end

  # def default_twitter
  #   {
  #     card: "summary_large_image",
  #     title: @twitter_title || Settings.site.meta.twitter.title,
  #     description: @twitter || Settings.site.meta.twitter.description,
  #     image: page_twitter_image
  #   }
  # end

  # def page_twitter_image
  #   @page_image || image_url(Settings.site.meta.twitter.image)
  # end
end
