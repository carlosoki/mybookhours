$().ready(
    function(){
        $('#client_type').validate({
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
            errorClass:'has-error',
            highlight: function (element, errorClass) {
                $(element).parents('.form-group').addClass(errorClass);
            },
            unhighlight: function (element, errorClass) {
                $(element).parents('.form-group').removeClass(errorClass);
            }
        });

    }
);


