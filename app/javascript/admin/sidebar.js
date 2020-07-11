
$(document).ready (function() {
    var $items = $('.nav-main li.nav-parent');

    function expand(li) {
        li.children('ul.nav-children').slideDown('fast', function () {
            li.addClass('nav-expanded');
            $(this).css('display', '');
            ensureVisible(li);
        });
    }


    function collapse(li) {
        li.children('ul.nav-children').slideUp('fast', function () {
            $(this).css('display', '');
            li.removeClass('nav-expanded');
        });
    }

    $items.find('> a').on('click', function () {
        var prev = $(this).closest('ul.nav').find('> li.nav-expanded'),
            next = $(this).closest('li');

        if (prev.get(0) !== next.get(0)) {
            collapse(prev);
            expand(next);
        } else {
            collapse(prev);
        }
    });

    function ensureVisible( li ) {
        var scroller = li.offsetParent();
        if ( !scroller.get(0) ) {
            return false;
        }

        var top = li.position().top;
        if ( top < 0 ) {
            scroller.animate({
                scrollTop: scroller.scrollTop() + top
            }, 'fast');
        }
    }
});