class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save { self.role ||= :standard }
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :lockable, :timeoutable, :trackable, :validatable
  has_many :topics, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy

  enum role: [:standard, :moderator, :admin]

  def liked(bookark)
    likes.where(bookmark_id: bookmark.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
