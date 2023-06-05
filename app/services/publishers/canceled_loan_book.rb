require 'bunny'

module Publishers
  class CanceledLoanBook
    def initialize(message)
      @message = message
    end

    def publish
      ::Publishers::Application.new(
        routing_key: 'basic_app.book_loans_canceled',
        exchange_name: 'basic_app',
        message: @message
      ).perform
    end
  end

  attr_reader :message
end
