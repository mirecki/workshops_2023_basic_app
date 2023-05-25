class LogsWorker
  include Sneakers::Worker

  from_queue 'basic_app_book_loans',
             exchange: 'basic_app', exchange_type: :direct, routing_key: 'basic_app.book_loans'

  def work(attributes)
 
    logs_data = JSON.parse(attributes)

    ::Log.create(user_id: logs_data['id'], data: logs_data)
  end
end
