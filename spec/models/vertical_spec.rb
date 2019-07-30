require 'rails_helper'

RSpec.describe Vertical, type: :model do
  it { is_expected.to have_many(:categories).dependent(:destroy) }

  include_examples 'validates', 'vertical', 'category'
end
