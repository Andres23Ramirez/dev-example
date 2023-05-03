class Blob < ApplicationRecord
	validates :document_id, :document_filename, :data, presence: true
end
