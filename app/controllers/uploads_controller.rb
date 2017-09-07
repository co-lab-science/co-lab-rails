class UploadsController < ApplicationController
  def upload
    @file = params[:file].tempfile

    Aws.config.update({
      region: 'us-east-1',
      credentials: Aws::Credentials.new(ENV["AWS_ID"], ENV["AWS_SECRET"])
    })

    s3 = Aws::S3::Resource.new
    random = SecureRandom.hex
    obj = s3.bucket('colab-upload').object(random)
    obj.upload_file(@file,acl:'public-read')

    render(json: {public_url: obj.public_url})
  end

  def file_upload
    @file = params["files"][0].tempfile
    name = params["files"][0].original_filename


    Aws.config.update({
      region: 'us-east-1',
      credentials: Aws::Credentials.new(ENV["AWS_ID"], ENV["AWS_SECRET"])
    })

    s3 = Aws::S3::Resource.new
    random = SecureRandom.hex
    obj = s3.bucket('colab-upload').object(random)
    obj.upload_file(@file,acl:'public-read')
    url = obj.public_url

    LabFile.create(name: name, url: url, lab_id: params["lab_id"], hypothesis_id: params["hypothesis_id"], question_id: params["question_id"])
    render(json: { name: name, url: url })
  end
end

