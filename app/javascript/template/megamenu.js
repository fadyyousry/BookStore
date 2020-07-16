$(function() {
    document.addEventListener("click", function(e) {
        $('.has-megamenu div, .has-megamenu a').removeClass("show");
        $('.has-megamenu a').attr("aria-expanded", false);
    });
});