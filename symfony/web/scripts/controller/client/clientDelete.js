$(document).on("click", "a.deleteClient",
    function () {
        var formMethod = 'delete';
        var action = $(this).attr('action');
        var removeRow = $(this).closest('tr');

        console.log('on delete...');

        Ajaxify.submitDeleteAjax(formMethod, action, removeRow);
    }
);
