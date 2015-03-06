require 'rails_helper'

RSpec.describe Status, type: :model do
  context 'Associations' do
    it { is_expected.to have_many :tickets }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of :name }
  end
end
