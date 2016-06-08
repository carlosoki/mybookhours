function Ajaxify(formElement) {
    $('body').on('submit', '.ajaxForm', function (e) {
        console.log('just here.');
        e.preventDefault();

        $.ajax({
            type: $(this).attr('method'),
            url: $(this).attr('action'),
            data: $(this).serialize()
        })
            .done(function (data) {
                console.log('data saved.');
                if (typeof data.message !== 'undefined') {
                    $('#alert').fadeIn();
                    formElement[0].reset();
                    $('#alert').delay(3000).fadeOut('slow');
                }
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                if (typeof jqXHR.responseJSON !== 'undefined') {
                    if (jqXHR.responseJSON.hasOwnProperty('form')) {
                        $('#form_body').html(jqXHR.responseJSON.form);
                        // $('#alert').addClass('display-hide');
                        console.log('form error...');
                    }
                    console.log('error...');

                    $('.form_error').html(jqXHR.responseJSON.message);

                } else {
                    alert(errorThrown);
                }

            });
    });

}