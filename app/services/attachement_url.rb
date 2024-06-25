class AttachementUrl
  def initialize(params)
    @file = params[:file]
    @host = params[:host]
  end

  def url
    return nil unless @file.attached?
    (Rails.env.test?) ? (host + Rails.application.routes.url_helpers.rails_blob_url(@file, only_path: true)) : @file.service.send(:object_for, @file.key).public_url
  end
end
