$(function() {
    $('#book_title').on('input', function() {
        var $title = $(this).val().replace(/\s+/g, '+');

        $.ajax({
            type: 'GET',
            url: 'https://www.googleapis.com/books/v1/volumes',
            data: { "q": $title, "maxResults": "1" },
            success: function(books) {
                book = books.items[0];
                $('#book_description').val(book.volumeInfo.description);
                $('#book_isbn').val(book.volumeInfo.industryIdentifiers[1].identifier);
                $('#book_image_link').val(book.volumeInfo.imageLinks.thumbnail);
                $('#book_language').val(book.volumeInfo.language);
            },
            error: function() {}
        });
    });
});