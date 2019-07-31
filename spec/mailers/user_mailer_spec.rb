require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'user mailer delivery' do
    subject(:delivery) { described_class.new_course(user, course).deliver_now }

    let(:user)   { create :user }
    let(:course) { create :course }

    its(:subject) { is_expected.to eq('New course!') }
    its(:to)      { is_expected.to eq([user.email]) }
    its(:from)    { is_expected.to eq(['from@example.com']) }
    its(:body)    { is_expected.to match(/Created new course #{course.name}/i) }

    it 'delivers' do
      expect { delivery }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end
