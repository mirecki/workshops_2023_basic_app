class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def loan_created_email(loan)
    @title = loan.book.title
    @due_date = loan.due_date
    @email_address = loan.user.email
    email_subject = "Loan has been created for of Book#{loan.book.title}"
    mail(to: @email_address, subject: email_subject)
  end

  def loan_canceled_email(loan)
    @title = loan.book.title
    @due_date = loan.due_date
    @email_address = loan.user.email
    email_subject = "Loan has been canceled for of Book#{loan.book.title}"
    mail(to: @email_address, subject: email_subject)
  end

  def due_date_notification_email(_date, loan)
    @title = loan.book.title
    @due_date = loan.due_date
    @email_address = loan.user.email
    email_subject = "Due date of Book#{loan.book.title}"
    mail(to: @email_address, subject: email_subject)
  end

  def returned_notification_email(loan)
    @title = loan.book.title
    @due_date = loan.due_date
    @email_address = loan.user.email
    email_subject = "Book#{loan.book.title} has been returned"
    mail(to: @email_address, subject: email_subject)
  end
end
