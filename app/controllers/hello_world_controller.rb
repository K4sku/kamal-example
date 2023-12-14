class HelloWorldController < ApplicationController
  def create
    HelloWorldJob.perform_later(session_id: session.id.to_s)
  end
end
