class PostSerializer < ApplicationSerializer
  attributes :id

  attributes :video_url do |object|
    AttachementUrl.new(file: object.video).url
  end

  attributes :video_thumbnail_url do |object|
    AttachementUrl.new(file: object.video_thumbnail).url
  end
end
