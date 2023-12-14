class HelloWorldJob < ApplicationJob
  queue_as :default

  def perform(session_id:)
    Turbo::StreamsChannel.broadcast_prepend_to(
      session_id,
      target: "flash",
      partial: "layouts/flash",
      locals: { flash: { notice: "Hello World!" } }
    )
  end
end
