require 'rails_helper'

RSpec.describe Course, type: :model do
  it { is_expected.to belong_to(:category) }

  include_examples 'name_validate'
end
