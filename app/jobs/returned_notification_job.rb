class ReturnedNotificationJob
    include Sidekiq::Job
  
    def perform(book_loan_id)
      book_loan = BookLoan.find(book_loan_id)
  
      UserMailer.returned_notification_email(book_loan).deliver_now
    end
  end
  