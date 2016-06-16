var editUrl = '';
var deleteUrl = '';
var research = '';
var researchParams = '';

$(document).ready(
    function () {
        $('.search').click(
            function () {
                editUrl = $(this).attr('editUrl');
                deleteUrl = $(this).attr('deleteUrl');

                var action = $(this).attr('action');
                var names = $('.names').val();

                research = action;
                researchParams = names;

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
            
            var tr = $('<tr>').append(
                $('<td>').text(client.name),
                $('<td>').text(client.address),
                $('<td>').text(client.isInactive),
                $('<td>').append($("<a href='"+editUrls+"' class='btn yellow'><i class='fa fa-edit'></i></a>")),
                $('<td>').append($("<a action='"+deleteUrls+"' class='delete btn red' research='"+research+"' researchParams='"+researchParams+"'><i class='fa fa-trash'></i></a>"))
            );
            $('#searchResult').append(tr);

        });
    });




}