require 'rails_helper'

RSpec.describe Blob, type: :model do
  describe "validations" do
    it "is invalid without a document_id" do
      blob = Blob.new(document_filename: "test.json", data: "some data")
      expect(blob).to_not be_valid
    end

    it "is invalid without a document_filename" do
      blob = Blob.new(document_id: "1234", data: "some data")
      expect(blob).to_not be_valid
    end

    it "is invalid without data" do
      blob = Blob.new(document_id: "1234", document_filename: "test.json")
      expect(blob).to_not be_valid
    end

    it "is valid with all required attributes" do
      blob = Blob.new(document_id: "1234", document_filename: "test.json", data: "some data")
      expect(blob).to be_valid
    end
  end
end

