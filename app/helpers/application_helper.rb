require 'capybara/rspec'

module ApplicationHelper
  def reserve_book_button(book, css_class: '')
    return unless book.reservation_available_for?(current_user)

    button_to(
      'Reserve (book is already loaned)',
      book_reservations_path(book_id: book.id),
      method: :post,
      class: "btn #{css_class}"
    )
  end

  def loan_book_button(book, css_class: '')
    return unless book.loan_available_for?(current_user)

    button_to(
      'Loan',
      book_loans_path(book_id: book.id),
      method: :post,
      class: "btn #{css_class}"
    )
  end

  def return_book_button(book, css_class: '')
    return unless book.return_available_for?(current_user)

    button_to(
      'Return book',
      return_book_loan_path(book.book_loans.last),
      method: :post,
      class: "btn #{css_class}"
    )
  end

  def weather_data
    @weather_data ||= ::WeatherApiConnector.new.weather_data
  end
end
