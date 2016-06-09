function Ajaxify( form, obj ) {
    if (General.empty(obj.data))
        pars = $(form).serialize();
    else
        pars = obj.data.concat($(form).serializeArray());

    var action = $(form).attr('action');
    if (obj.action)
        action = obj.action;

    $.ajax({
        type: 'POST',
        data: pars,
        dataType: 'json',
        url: action,
        beforeSend: function () {
            General.scrollTo(form);
        },
        success: function (response) {

            if (obj && obj.callback) {

                response.form = form;
                General.execFunction(obj.callback, response);
                $('#alert').fadeIn();
                form[0].reset();
                $('#alert').delay(3000).fadeOut('slow');
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            var jsonReturn = null;
            if (typeof jqXHR.responseJSON !== 'undefined') {
                jsonReturn = jqXHR.responseJSON;
            } else {
                jsonReturn = $.toJSON(jqXHR.responseText);
            }

            $(form).find('span.has-error').remove();
            $(form).find('.form-group.has-error').removeClass('.has-error');

            $.each(jsonReturn.data,
                function(field, errors)
                {
                    var fieldElement = $('#'+ field, form);
                    fieldElement.parents('.form-group').addClass('has-error');
                    errors.forEach(
                        function(e){
                            var span = $('<span>');
                            span.addClass('required').html(e);
                            span.insertAfter(fieldElement);
                        }
                    );
                }
            );

        }
    });
}