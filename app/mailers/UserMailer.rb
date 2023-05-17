class UserMailer < ApplicationMailer
    default from: 'from@example.com'

    # def initialize

    # end

    def loan_created_email(loan)
        @title = loan.book.title
        @due_date = loan.due_date
        @email_address = loan.user.email
        email_subject = "bla bla bla"
        mail(to: @email_address, subject: email_subject)
    end

end
