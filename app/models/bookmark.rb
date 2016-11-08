class Bookmark < ActiveRecord::Base
  require 'embedly'
  require 'json'

  belongs_to :topic
  belongs_to :user
  has_many :likes, dependent: :destroy

  default_scope { order('created_at DESC') }

  validates_presence_of :user
  validates_presence_of :topic
  validates_presence_of :url
  validates :url, format: { with: /(http:\/\/)?(https:\/\/)?(www\.)?[a-zA-Z0-9\-\#\/\_]+[\.][a-zA-Z0-9\-\.\#\/\_]+/i }

  def embed_display(url)
    embedly_api = Embedly::API.new key: ENV['EMBEDLY_API_KEY']
    obj = embedly_api.oembed url: url
    obj.first
  end

  def add_image
    title = embed_display(url).title
    image = embed_display(url).thumbnail_url
    update_attributes(title: title, image: image)
  end
end
