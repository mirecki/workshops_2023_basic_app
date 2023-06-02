class BookLoan < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum status: { checked_out: 'checked_out', cancelled: 'cancelled' }

  scope :ongoing_by_book, ->(book) { checked_out.where(book:) }

  validate :loan_not_available, on: :create
  validate :return_not_available, on: :post

  def loan_not_available
    errors.add(:book, 'loan is not available for you') unless book.loan_available_for?(user)
  end

  def return_not_available
    errors.add(:book, 'You can not return book that you haven not loaned') unless book.return_available_for?(user)
  end

  def return_available_for?(user)
    by_user?(user) && checked_out?
  end

  def by_user?(user)
    self.user == user
  end
end
