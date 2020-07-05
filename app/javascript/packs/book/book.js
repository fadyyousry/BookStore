$(function() {
    var $mybook;
    /*execute a function when someone clicks in the document:*/
    document.addEventListener("click", function(e) {
        $(".autocomplete-items").remove();
    });

    $('#search_google_book_input').on('input', function() {
        var inp = this;
        var a, b, val = this.value;
        /*close any already open lists of autocompleted values*/
        $(".autocomplete-items").remove();
        if (!val) { return false; }
        currentFocus = -1;
        /*create a DIV element that will contain the items (values):*/
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        /*append the DIV element as a child of the autocomplete container:*/
        this.parentNode.appendChild(a);

        var $title = $(this).val().replace(/\s+/g, '+');

        $.ajax({
            type: 'GET',
            url: 'https://www.googleapis.com/books/v1/volumes',
            data: { "q": $title, "maxResults": "3" },
            success: function(books) {
                var list = $("#search_google_book_list");
                list.empty();
                $mybook = books.items[0];
                $.each(books.items, function(i, book) {
                    /*create a DIV element for each matching element:*/
                    b = document.createElement("DIV");
                    b.innerHTML = "<p>" + book.volumeInfo.title + "</p>";
                    /*insert a input field that will hold the current array item's value:*/
                    b.innerHTML += "<input type='hidden' value='" + i + "'>";
                    /*execute a function when someone clicks on the item value (DIV element):*/
                    b.addEventListener("click", function(e) {
                        /*insert the value for the autocomplete text field:*/
                        inp.value = this.getElementsByTagName("p")[0].outerText;
                        $mybook = books.items[this.getElementsByTagName('input')[0].value];
                        /*close the list of autocompleted values,
                        (or any other open lists of autocompleted values:*/
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