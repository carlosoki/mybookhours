$().ready(
    function (){
        var form  = $( '#client_type' );

        submit = function(){
            var obj = {
                callback: function( response )
                {
                    if ( response.status )
                        General.go( Routing.generate('pattern') );

                }
            };

            Ajaxify( form, obj );
            return false;
        };

        form.validate({
            rules: {
                name: {
                    required: true,
                    minlength: 2
                },
                address: "required"
            },
            messages: {
                name: {
                    required: "Client name is mandatory",
                    minlength: "Name need at least 2 chars"
                },
                address: "Address is mandatory"
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


