require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to belong_to(:vertical) }
  it { is_expected.to have_many(:courses).dependent(:destroy) }

  include_examples 'validates', 'category', 'vertical'
end
