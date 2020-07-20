import $ from 'jquery';
global.$ = jQuery;

$(document).ready(function() {

    'use strict';

    var datatableInit = function() {
        var $table = $('.table-with-details');

        // format function for row details
        var fnFormatDetails = function( datatable, tr ) {
            return tr.querySelector("#table_hidden_data").innerHTML;
        };

        // insert the expand/collapse column
        var th = document.createElement( 'th' );
        var td = document.createElement( 'td' );
        td.innerHTML = '<i data-toggle class="fa fa-plus-square-o text-primary h5 m-none" style="cursor: pointer;"></i>';
        td.className = "text-center";

        $table
            .find( 'thead tr' ).each(function() {
                this.insertBefore( th, this.childNodes[0] );
            });

        $table
            .find( 'tbody tr' ).each(function() {
                this.insertBefore(  td.cloneNode( true ), this.childNodes[0] );
            });

        // initialize
        var datatable = $table.dataTable({
            aoColumnDefs: [{
                    bSortable: false,
                    aTargets: [ 0 ]
                },
            ],
            aaSorting: [
                [1, 'asc']
            ]
        });

        // add a listener
        $table.on('click', 'i[data-toggle]', function() {
            var $this = $(this),
                tr = $(this).closest( 'tr' ).get(0);

            if ( datatable.fnIsOpen(tr) ) {
                $this.removeClass( 'fa-minus-square-o' ).addClass( 'fa-plus-square-o' );
                datatable.fnClose( tr );
            } else {
                $this.removeClass( 'fa-plus-square-o' ).addClass( 'fa-minus-square-o' );
                datatable.fnOpen( tr, fnFormatDetails( datatable, tr), 'details' );
            }
        });
    };

    $(function() {
        datatableInit();
    });

});
