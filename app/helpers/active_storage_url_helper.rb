module ActiveStorageUrlHelper
  def self.storage_url_ofs(file, host = ENV['HOST'])
    return nil unless file.attached?

  end
end
