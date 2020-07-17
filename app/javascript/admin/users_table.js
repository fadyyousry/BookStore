import $ from 'jquery';
global.$ = jQuery;

$(document).ready(function() {

    'use strict';

    var datatableInit = function() {
        var $table = $('#datatable-user');

        // initialize
        var datatable = $table.dataTable({

        });
    };

    $(function() {
        datatableInit();
    });

});
