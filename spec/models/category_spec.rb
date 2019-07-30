require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to belong_to(:vertical) }

  include_examples 'validates', 'category', 'vertical'
end
