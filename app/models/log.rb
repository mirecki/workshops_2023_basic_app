class Log < ApplicationRecord
  include ActiveModel::Serializers::JSON

  validates :user_id, presence: true
  validates :data, presence: true
end
