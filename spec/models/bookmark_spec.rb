require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  it { should validate_presence_of :user }
  it { should validate_presence_of :topic }
end
