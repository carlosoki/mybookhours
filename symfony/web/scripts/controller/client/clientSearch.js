var editUrl = '';
var deleteUrl = '';

$(document).ready(
    function () {
        $('.search').click(
            function () {
                editUrl = $(this).attr('editUrl');
                deleteUrl = $(this).attr('deleteUrl');

                var action = $(this).attr('action');
                var names = $('.names').val();

                $('#listClient').addClass('collapse').removeClass('expand');
                $('#clientResult').removeClass('portlet-collapsed');

                $('#searchResult').empty();

                Ajaxify.submitSearchAjax(action, names );
            }
        );
    }
);

function searchResult(response) {

    $(function() {
        $.each(response, function(i, client) {

            editUrls = [];
            deleteUrls = [];

            editUrls += editUrl.replace("client_id", client.id);
            deleteUrls += deleteUrl.replace("client_id", client.id);

            if (client.isActive) {
                var active = $("<a class='disabled btn blue'>Yes<i class='fa fa-ok'></i></a>")
            } else {
                var active = $("<a class='disabled btn purple'>No<i class='fa fa-ok'></i></a>")
            }

            var tr = $('<tr>').append(
                $('<td>').text(client.name),
                $('<td>').text(client.address),
                $('<td>').append(active),
                $('<td>').append($("<a href='"+editUrls+"' class='btn btn-sm yellow'><i class='fa fa-edit'></i></a>")),
                $('<td>').append($("<a action='"+deleteUrls+"' class='deleteClient btn btn-sm red'><i class='fa fa-trash'></i></a>"))
            );
            $('#searchResult').append(tr);

        });
    });




}