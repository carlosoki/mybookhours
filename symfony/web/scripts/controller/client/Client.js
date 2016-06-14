$().ready(
    function (){
        var formName = 'client_type';
        var form  = $( '#'+formName );
        var formMethod = $(form).attr('method');

        submit = function(){
            var obj = {
                callback: function( response )
                {
                    if ( response.status )
                        General.go( Routing.generate('pattern') );

                }
            };

            Ajaxify.processRequests( form, obj, formName, formMethod );
            return false;
        };

        form.validate({
            rules: {
                'client_type[name]': {
                    required: true,
                    minlength: 2
                },
                'client_type[address]': "required"
            },
            messages: {
                'client_type[name]': {
                    required: "Client name is mandatory",
                    minlength: "Name need at least 2 chars"
                },
                'client_type[address]': "Address is mandatory"
            },
            errorClass:'required',
            errorElement: 'span',
            highlight: function (element, errorClass) {
                $(element).parents('.form-group').addClass('has-error');
            },
            unhighlight: function (element, errorClass) {
                $(element).parents('.form-group').removeClass('has-error');
            },
            submitHandler: submit
        });
    }
);


