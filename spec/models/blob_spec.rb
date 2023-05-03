require 'rails_helper'

require 'rails_helper'

RSpec.describe Blob, type: :model do

  subject { described_class.new(document_id: '1234', document_filename: 'test.txt', data: {name: 'test'}) }

  it 'validates presence of required attributes' do
    required_attributes = [:document_id, :document_filename, :data]
    required_attributes.each do |attr|
      subject[attr] = nil
      expect(subject).not_to be_valid
      expect(subject.errors[attr]).to include("can't be blank")
    end
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
