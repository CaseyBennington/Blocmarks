class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  default_scope { order('created_at DESC') }
end
