Ajaxify = {
    
    processRequests: function (form, obj, formName, formMethod) {

        if (General.empty(obj.data))
            pars = $(form).serialize();
        else
            pars = obj.data.concat($(form).serializeArray());

        var action = $(form).attr('action');

        if (obj.action)
            action = obj.action;

        if (formMethod === 'post' || formMethod === 'put') {
            Ajaxify.submitPostPutAjax(form, formName, formMethod, obj, pars, action);
        }

        if (formMethod === 'delete') {
            this.submitDeleteAjax(formMethod, action);
        }
    },

    submitDeleteAjax: function (formMethod, action, redirect) {
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

    },

    submitPostPutAjax: function (form, formName, formMethod, obj, pars, action) {
        $.ajax({
            type: formMethod,
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

                    if (formMethod === 'post'){
                        form[0].reset();
                    }

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

                $.each(jsonReturn.errors,
                    function(field, errors){
                        var fieldElement = $('#'+formName+'_'+field, form);
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


}