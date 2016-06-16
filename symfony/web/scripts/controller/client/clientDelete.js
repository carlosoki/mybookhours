$(document).ready(function() {

    $(".delete").click(function(){
        var formMethod = 'delete';
        var action = $(this).attr('action');
        var research = $(this).attr('research');
        var researchParams = $(this).attr('researchParams');

        console.log('on delete...');

        Ajaxify.submitDeleteAjax(formMethod, action, research, researchParams);

    });
});