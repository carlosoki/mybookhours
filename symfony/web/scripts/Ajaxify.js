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
            console.log('entrou BEFORE SEND...');
            Message.setFadeOut(false).msgInfo('Loading..', form);
            General.scrollTo(form);
        },
        success: function (response) {
            console.log('IN SUCESSS...');
            //Message.clearMessages(form);

            if (obj && obj.callback) {
                response.form = form;
                General.execFunction(obj.callback, response);
            }

            Form.showErrorsForm(form, response.errors);

            if (response.fields && response.fields.length) {

                for (id in response.fields) {

                    var ele = $('#' + response.fields[id]);
                    ele.closest('.forms-group').addClass('has-error');
                }
            }

            if (!response.status) {

                if (General.empty(response.description))
                    Message.msgError('Something went wrong', form);

            } else if (General.empty(obj.nomsg)) {
                Message.msgSuccess('Operation was a success', form);
            }

            if (!General.empty(response.description)) {
                Message.msgError(response.description, form);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log('entrou aqui...');
            var jsonReturn = null;
            if (typeof jqXHR.responseJSON !== 'undefined') {
                jsonReturn = jqXHR.responseJSON;
            } else {
                jsonReturn = $.toJSON(jqXHR.responseText);
            }

            $(form).find('span.has-error').remove();
            $(form).find('.form-group.has-error').removeClass('.has-error');

            $.each(jsonReturn.errors,
                function(field, errors)
                {
                    var fieldElement = $('#'+ field, form);
                    fieldElement.parents('.form-group').addClass('has-error');
                    errors.forEach(
                        function(e)
                        {
                            var span = $('<span>');
                            span.addClass('has-error').html(e);
                            span.insertAfter(fieldElement);
                        }
                    );
                }
            );

        }
    });
}


// function Ajaxify(formElement) {
//     $('body').on('submit', '.ajaxForm', function (e) {
//         e.preventDefault();
//
//         $.ajax({
//             type: $(this).attr('method'),
//             url: $(this).attr('action'),
//             data: $(this).serialize()
//         })
//             .done(function (data) {
//
//                 // if (typeof data.message !== 'undefined') {
//                 console.log('message:' + data.message);
//                 if (data.message === 'success') {
//                     $('#alert').fadeIn();
//                     formElement[0].reset();
//                     $('#alert').delay(3000).fadeOut('slow');
//                 } else if (data.message === 'error') {
//                     console.log('error:' + data.children.name.errors);
//
//                 }
//             })
//             .fail(function (jqXHR, textStatus, errorThrown) {
//                 console.log('get in fail...');
//                 if (typeof jqXHR.responseJSON !== 'undefined') {
//                     if (jqXHR.responseJSON.hasOwnProperty('form')) {
//                         $('#form_body').html(jqXHR.responseJSON.form);
//                         // $('#alert').addClass('display-hide');
//                         console.log('form error...');
//                     }
//                     console.log('error...');
//
//                     $('.form_error').html(jqXHR.responseJSON.message);
//
//                 } else {
//                     alert(errorThrown);
//                 }
//
//             });
//     });
//
// }
