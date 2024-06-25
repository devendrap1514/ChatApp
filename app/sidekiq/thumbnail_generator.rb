require 'sidekiq'

class ThumbnailGenerator
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find(post_id) # Assuming you have a Video model

    video_tempfile = Tempfile.new(['video', File.extname(post.video.blob.filename.to_s)])
    video_tempfile.binmode

    # Stream the video file to the temporary file
    post.video.download { |chunk|
      video_tempfile.write(chunk)
    }
    video_tempfile.rewind

    # Generate a thumbnail using FFMPEG
    movie = FFMPEG::Movie.new(video_tempfile.path)
    screenshot_tempfile = Tempfile.new(['thumbnail', '.jpg'])
    movie.screenshot(screenshot_tempfile.path, seek_time: 1) # Capture a frame at 5 seconds

    # Attach the screenshot to the video record
    post.video_thumbnail.attach(io: screenshot_tempfile, filename: 'thumbnail.jpg')

    # Clean up
    video_tempfile.close
    video_tempfile.unlink
    screenshot_tempfile.close
    screenshot_tempfile.unlink
  end
end
