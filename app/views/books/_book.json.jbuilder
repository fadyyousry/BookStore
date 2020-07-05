json.extract! book, :id, :title, :publisher_id, :published_date, :description, :isbn, :page_count, :image_link, :language, :is_pdf, :quantity,:price, :created_at, :updated_at
json.url book_url(book, format: :json)
