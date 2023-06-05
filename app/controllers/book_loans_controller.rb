class BookLoansController < ApplicationController
  before_action :set_book_loan, only: %i[cancel return]
  before_action :prepare_book_loan, only: %i[create]

  def create
    respond_to do |format|
      if @book_loan.save
        creat_loan(@book_loan)
        format.html { redirect_to book_url(book), notice: flash_notice }
        format.json { render :show, status: :created, location: @book_loan }
      else
        format.html { redirect_to book_url(book), alert: @book_loan.errors.full_messages.join(', ') }
        format.json { render json: @book_loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    respond_to do |format|
      if @book_loan.cancelled!
        cancel_loan(@book_loan)
        format.html { redirect_to book_requests_path, notice: flash_notice }
        format.json { render :show, status: :ok, location: book }
      end
    end
  end

  def return
    respond_to do |format|
      if @book_loan.checked_out?
        delete_loan(@book_loan)
        @book_loan.destroy
        format.html { redirect_to books_url, notice: 'Book was successfully returned.' }
        format.json { head :no_content }
      end
    end
  end

  private

  delegate :book, to: :@book_loan
  def creat_loan(book_loan)
    notice_calendar
    LoanCreatedJob.perform_async(book_loan.id)
    publish_create_log(book_loan)
  end

  def delete_loan(book_loan)
    ReturnedNotificationJob.perform_async(book_loan.id)
    delete_calendar_event(book_loan.event_id)
  end

  def cancel_loan(book_loan)
    LoanCanceledJob.perform_async(book_loan.id)
    delete_calendar_event(book_loan.event_id)
    publish_cancel_log(book_loan)
  end

  def notice_calendar
    UserCalendarNotifier.new(current_user, book).insert_event
  end

  def delete_calendar_event(event_id)
    UserCalendarNotifier.new(current_user, book).delete_event(event_id)
  end

  def publish_create_log(book_loan)
    Publishers::LoanBook.new(book_loan.attributes).publish
  end

  def publish_cancel_log(book_loan)
    Publishers::CanceledLoanBook.new(book_loan.attributes).publish
  end

  def prepare_book_loan
    @book_loan = current_user.book_loans.new(book_id: book_loan_params, due_date: Time.zone.now + 5.minutes)
  end

  def set_book_loan
    @book_loan = current_user.book_loans.find(params[:id])
  end

  def book_loan_params
    params.require(:book_id)
  end
end
