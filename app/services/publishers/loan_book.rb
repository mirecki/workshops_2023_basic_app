require 'bunny'

module Publishers
  # **nazwa_hasha sposob na rozpawkoanie hasha
  class LoanBook
    def initialize(message)
      @message = message
    end

    def publish
      ::Publishers::Application.new(
        routing_key: 'basic_app.book_loans',
        exchange_name: 'basic_app',
        message: @message
      ).perform
    end
  end

  attr_reader :message
end
