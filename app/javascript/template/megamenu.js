$(document).on('turbolinks:load', function() {
    $(".dropdown").hover(
        function() { $('.dropdown-menu', this).stop().fadeIn(500);
        },
        function() { $('.dropdown-menu', this).stop().fadeOut(500);
    });
});
