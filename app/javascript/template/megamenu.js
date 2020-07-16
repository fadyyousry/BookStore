$(document).ready(function() {
    $("#authors_list a")[0].click()
    $("#categories_list a")[0].click();

    $(".dropdown").hover(
        function() { $('.dropdown-menu', this).stop().fadeIn(500);
        },
        function() { $('.dropdown-menu', this).stop().fadeOut(500);
    });
});
