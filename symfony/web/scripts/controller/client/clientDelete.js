$(document).ready(function() {

    $(".delete").click(function(){
        var redirect = $(this).attr('redirect');
        var action = $(this).attr('action');

        $.ajax({
            url: action,
            type: 'delete',

            success: function(result) {
                $( location ).attr("href", redirect);
            },

            error: function(e){
                console.log(e.responseText);
            }

        });

    });
});