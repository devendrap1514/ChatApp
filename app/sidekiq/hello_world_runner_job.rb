class HelloWorldRunnerJob
  include Sidekiq::Job

  def perform(*args)
    puts("Hello World")
  end
end
