class WebhooksController < ApplicationController
  before_action :authorize_request, only: %i[]
  def calendly
    payload = JSON.parse(request.body.read)
    puts
    puts
    print(payload)
    puts
    puts
  end
end
