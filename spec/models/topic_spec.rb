require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should validate_length_of(:title).is_at_least(5) }
end
