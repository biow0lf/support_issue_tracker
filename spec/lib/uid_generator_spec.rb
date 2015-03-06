require 'spec_helper'
require 'uid_generator'

RSpec.describe UidGenerator do
  context '#generate' do
    subject(:uid_generator) { UidGenerator.new }

    it 'should return uid in valid format' do
      expect(uid_generator.generate)
        .to match(/[A-Z]{3}-[A-F0-9]{2}-[A-Z]{3}-[A-F0-9]{2}-[A-Z]{3}/)
    end
  end
end
