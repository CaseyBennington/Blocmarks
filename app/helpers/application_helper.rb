module ApplicationHelper
  require 'embedly'
  require 'json'

  def display(url)
    embedly_api = Embedly::API.new key: ENV['EMBEDLY_API_KEY']
    obj = embedly_api.oembed url: url
    obj.first
  end

  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << 'has-error' if errors.any?

    content_tag :div, capture(&block), class: css_class
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=40"
  end
end
