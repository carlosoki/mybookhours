$(document).ready(function() {

    $(".delete").click(function(){
        var formMethod = 'delete';
        var action = $(this).attr('action');
        var redirect = $(this).attr('redirect');

        Ajaxify.submitDeleteAjax(formMethod, action, redirect);

    });
});