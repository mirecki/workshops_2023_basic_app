class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def loan_created_email(loan)
    @title = loan.book.title
    @due_date = loan.due_date
    @email_address = loan.user.email
    email_subject = 'bla bla bla'
    mail(to: @email_address, subject: email_subject)
  end

  def due_date_notification_email(_date, loan)
    @title = loan.book.title
    @due_date = loan.due_date
    @email_address = loan.user.email
    email_subject = 'bla bla bla 2'
    mail(to: @email_address, subject: email_subject)
  end
end
