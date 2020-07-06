$(function() {
    var $mybook;

    document.addEventListener("click", function(e) {
        $(".autocomplete-items").remove();
    });

    $('#search_google_book_input').on('input', function() {
        var inp = this;
        var a, b, val = this.value;
        $(".autocomplete-items").remove();
        if (!val) { return false; }
        currentFocus = -1;
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        this.parentNode.appendChild(a);

        var $title = $(this).val().replace(/\s+/g, '+');

        $.ajax({
            type: 'GET',
            url: 'https://www.googleapis.com/books/v1/volumes',
            data: { "q": $title, "maxResults": "3" },
            success: function(books) {
                $mybook = books.items[0];
                $.each(books.items, function(i, book) {
                    b = document.createElement("DIV");
                    b.innerHTML = "<p>" + book.volumeInfo.title + "</p>";
                    b.innerHTML += "<input type='hidden' value='" + i + "'>";

                    b.addEventListener("click", function(e) {
                        inp.value = this.getElementsByTagName("p")[0].outerText;
                        $mybook = books.items[this.getElementsByTagName('input')[0].value];

                        $(".autocomplete-items").remove();
                    });
                    a.appendChild(b);
                });
            },
            error: function() {}
        });
    });

    $('#search_google_book_submit').on('click', function() {
        $('#book_title').val($mybook.volumeInfo.title);
        $('#book_description').val($mybook.volumeInfo.description);
        $('#book_isbn').val($mybook.volumeInfo.industryIdentifiers[1].identifier);
        $('#book_page_count').val($mybook.volumeInfo.pageCount);
        $('#book_image_link').val($mybook.volumeInfo.imageLinks.thumbnail);
        $('#book_language').val($mybook.volumeInfo.language);
    });
});