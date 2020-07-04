class GoogleBooks include HTTParty
	base_uri 'https://www.googleapis.com/books/v1/volumes'
	format :json

	def self.for term
		term ||= ''
		term = term.split.join('+')
		get('', query: {q: term})['items']||[]
	end
end