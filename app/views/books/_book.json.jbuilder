json.extract! book, :id, :title, :publisher_id, :published_date, :description, :isbn, :page_count, :image, :image_link, :language, :price, :created_at, :updated_at
json.url book_url(book, format: :json)
