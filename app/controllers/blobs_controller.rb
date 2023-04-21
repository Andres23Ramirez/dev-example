class BlobsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: Rails.configuration.file_api.basic_auth_username, password: Rails.configuration.file_api.basic_auth_password

  # POST /blobs/create
  def create
    json = params["blob"].as_json
    uuid = SecureRandom.uuid
    filename = uuid + ".json"

    if File.write("received_files/" + filename, JSON.pretty_generate(json))
      json["document_id"] = uuid
      json["document_filename"] = filename
      blob = Blob.new(
        document_id: uuid,
        document_filename: filename,
        data: json.to_json
      )
      if blob.save
        render json: json, status: 201
      else
        render json: { error: "unprocessible_entry" }, status: 422
      end
    else
      render json: {error: "unprocessible_entry"}, status: 422
    end
  end

  # GET /blobs/show

  def show
    @blob = Blob.find_by(id: params[:id])
    if @blob
      render json: @blob.to_json
    else
      render json: { error: 'Blob not found' }, status: :not_found
    end
  end
end
