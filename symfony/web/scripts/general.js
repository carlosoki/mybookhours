General = {
    
    init: function()
    {
		String.prototype.paddingLeft = function (width, padding ) 
		{
		    pad = function( value, width, padding )
		    {
			    return (width <= value.length) ? value : pad(width, padding + value, padding);
		    };

		    return pad( this, width, padding );
		};
		
		General.drawTables( '.data-table.auto-init' );
		General.configLogoutAjax();
		General.configSwitchImage();
                General.initResetForm();
    },

    configSwitchImage: function()
    {
    	$(document).on(
    		'click',
    		'.jersey-thumb a',
    		function()
    		{
                var container = $(this).closest('.jersey-thumb');
    			var view = $(this).data('view');
    			if ( !view )
    				view = 'front';

    			if ( 'front' == view ) {
    				
    				$('img.side', container).slideDown();
    				$('img.front', container).slideUp();

    				view = 'side';
    				$('span', this).removeClass('badge-success').addClass('badge-danger');
                    $('i', this).removeClass('fa-share').addClass('fa-reply');

    			} else {

    				$('img.front', container).slideDown();
    				$('img.side', container).slideUp();

    				view = 'front';
    				$('span', this).removeClass('badge-danger').addClass('badge-success');
                    $('i', this).removeClass('fa-reply').addClass('fa-share');
    			}

    			$(this).data('view', view);

    		}
    	);
    },

    configLogoutAjax: function()
    {
	$( document ).ajaxComplete(
	    function( event, xhr, settings ) 
	    {
		try {
		    json = $.parseJSON( xhr.responseText );
		    if ( json && json.logout )
			General.go( Routing.generate('fos_user_security_logout')  );
		} catch ( e ) {
		    
		}
	    }
	);
    },
    
    getURLParameters: function( url )
    {
	var result = {};
	var searchIndex = url.indexOf("?");
	if (searchIndex == -1 ) return result;
	var sPageURL = url.substring(searchIndex +1);
	var sURLVariables = sPageURL.split('&');
	for (var i = 0; i < sURLVariables.length; i++)
	{       
	    var sParameterName = sURLVariables[i].split('=');      
	    result[sParameterName[0]] = sParameterName[1];
	}
	return result;
    },
    
    reload: function( after )
    {
	if ( after ) {
	    window.setTimeout(
		function()    
		{
		    document.location.reload(true);
		},
		after * 1000
	    );
	} else
	    document.location.reload(true);
    },
    
    waitTo: function( exec, after )
    {
	this.waitToTimeout = window.setTimeout( exec, after * 1000 );
    },
    
    empty: function( mixed_var ) 
    {
   
	var key;
	if ( 
	    ( mixed_var === '') ||
	    ( mixed_var === 0 ) ||
	    ( mixed_var == '' ) ||
	    ( mixed_var === '0' ) ||
	    ( mixed_var === 'null' ) ||
	    ( mixed_var == 'NULL'  ) ||
	    ( mixed_var == null  ) ||
	    ( mixed_var === false  ) ||
	    ( mixed_var == 'undefined'  ) ||
	    ( mixed_var == undefined  ) ||
	    ( mixed_var === 'undefined' )
	){
	    return true;
	}

	if ( typeof mixed_var == 'object' ) {

	    for ( key in mixed_var ) {
		return false;
	    }
	    return true;
	}
	return false;
    },
    
    numberFormat: function( number, decimals, dec_point, thousands_sep ) 
    {
	dec_point = typeof dec_point !== 'undefined' ? dec_point : '.';
	thousands_sep = typeof thousands_sep !== 'undefined' ? thousands_sep : ',';

	var parts = number.toFixed( decimals ).toString().split('.');
	parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, thousands_sep);

	return parts.join(dec_point);
    },
    
    scrollTo: function( seletor, time )
    {
	if ( !$( seletor ).length )
	    return false;

	el = $( seletor );
	time = time || 1000;
	
	if (  el.closest( '.model-modal' ).length ) {
	    
	    scroller = el.closest( '.model-modal' );
	    scroll = el.position().top;
	    
	} else {
	    
	    scroller = 'html,body';
	    scroll = el.offset().top - 80;
	}

	$( scroller ).animate({scrollTop : scroll}, time );
	return true;
    },
    
    checkAll: function( master )
    {
	var dataTable = $( master ).closest( 'table' ).dataTable();
	
	$( 'input:not(:disabled)', dataTable.fnGetNodes() ).each(
	    function()
	    {
		$( this ).attr( 'checked', !!($( master ).attr( 'checked' )) );
		$.uniform.update( $( this ) );
	    }
	);
    },
    
    newWindow: function( pagina, title, largura, altura )
    {
	var config;
	var titleWindow = $.trim( title || '' );

	if ( largura && altura ) {

		var esquerda = (screen.width - largura)/2;
		var topo = (screen.height - altura)/2;

		config = 'toolbar=no,location=no,fullscreen=yes,status=no,menubar=no,scrollbars=yes,resizable=no,height=' +
			altura + ', width=' + largura + ', top=' + topo + ', left=' + esquerda;

		window.open( pagina, titleWindow , config );
	} else {
	    window.open( pagina, titleWindow );
	}
    },

    truncate: function( str, size )
    {
	size = size || 25;

	if ( str.length > size )
	    str = str.substr(0, size) + '...';

	return str;
    },

    toCamelCase: function( str )
    {
	return str.replace(/(\-[a-z])/g, function($1){return $1.toUpperCase().replace('-','');});
    },
    
    toUpperCamelCase: function( str )
    {
	str = this.toCamelCase( str );
	return str.charAt(0).toUpperCase() + str.slice(1);
    },
    
    getUrl: function( url )
    {
	return url;
    },

    go: function( url )
    {
	location.href = url;
    },
  
    execFunction: function( fnName, params )
    {
	if ( typeof fnName == 'function' ) {

	    return fnName( params );

	} else if ( typeof fnName == 'string' ) {

	    var fn = window[fnName];

	    if ( typeof fn == 'function' )
		return fn( params );
	    else
		return false;
	}

	return false;
    },

    loadCombo: function( url, selector, callback )
    {
        var combo = null;
	if ( typeof selector == 'string' )
	    combo = $( '#' + selector );
	else
	    combo = $( selector );
	
	combo.val( '' ).trigger( 'change' ).trigger( 'liszt:updated' ); 

	$.ajax({
	    type: 'GET',
	    url: url,
	    dataType: 'json',
	    beforeSend: function () 
	    {
		General.loading( true );
	    },
	    complete: function()
	    {
		General.loading( false );  
	    },
	    success: function ( response ) 
	    {
		combo.empty();

		if ( response ) {

		    for ( i in response ) {

			option = $( '<option />' );
			option.val( response[i].id );
			option.html( response[i].name );

			combo.append( option );
		    }

		    combo.removeAttr( 'disabled' );
		    combo.val( '' );
		    combo.focus();
		    
		    if ( combo.attr( 'data-value' ) ) {
			
			combo.val( combo.attr( 'data-value' ) );
			combo.removeAttr( 'data-value' );
		    }
		    
		    combo.trigger( 'change' ).trigger( 'liszt:updated' ); 

		    if ( callback )
			callback();

		} else combo.attr( 'disabled', true );
	    },
	    error: function ( response ) 
	    {
		console.log( response );
		combo.html( '<option value="">Error loading combo.</option>' );
	    }
	});

	return true;
    },

    toFloat: function( num )
    {
	num = num.toString().replace(/[^0-9.-]/g, '');
	return parseFloat( num );   
    },

    addBreadCrumb: function( label, url )
    {
	li = $( '<li />' );
	a = $( '<a />' );

	path = url ? '/' . BASE_URL + url : 'javascript:;';

	a.html( label );
	a.attr( 'href', path  );

	li.append( a );

	liPrevious = $( 'div#breadcrumb li' ).last();

	span = $( '<span />' );
	span.html( '/' ).addClass( 'divider' );

	liPrevious.append( span );

	$( 'div#breadcrumb ul' ).append( li );
    },

    drawTables: function( selector, callback, config )
    {    
	selector = selector || '.datatable';
	
	if ( !$( selector ).length )
	    return false;
	
	oTable = $( selector ).dataTable();
	if ( oTable )
	    oTable.fnDestroy(); 
	
	var settings = {
		"bJQueryUI": true,
		"sPaginationType": "full_numbers",
        "sDom": '<""l>t<"F"fp>',
		//"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6 center'p>>",
		"aLengthMenu": [
                    [10, 25, 50, 100, -1],
                    [10, 25, 50, 100, 'All'] // change per page values here
                ],
		"aoColumnDefs" : [ 
		    {
			"bSortable" : false,
			"aTargets" : [ "no-sort" ]
		    },
		    {
			"sType": "date-eu",
			"aTargets" : [ "date-column" ]
		    }
		],
	} ;
	
	if ( config )
	    settings = $.extend({}, settings, config );
	
	if ( !General.empty( callback ) )  
	    General.execFunction( callback, settings );
	
	$( selector ).dataTable( settings );
    },
    
    loadTable: function( selector, url, callback )
    {
	if ( !$( selector ).length )
	    return false;
	
	$.ajax({
	    type: 'GET',
	    url: url,
	    dataType: 'text',
	    beforeSend: function () 
	    {
		App.blockUI( selector );
	    },
	    complete: function()
	    {
		App.unblockUI( selector );
	    },
	    success: function ( response ) 
	    {
		oTable = $( selector ).dataTable();
		if ( oTable )
		    oTable.fnDestroy(); 
		
		$( selector ).find( 'tbody' ).empty().html( response );
		
		General.drawTables( selector, callback );
	    },
	    error: function () 
	    {
		$( selector ).find( 'tbody' ).empty().html( response );
		General.drawTables( selector );
	    }
	});
    },

    getFieldFloatValue: function( seletor )
    {
	var value = $( seletor ).val();
	return General.toFloat( General.empty( value ) ? 0 : value );
    },
    
    triggerParentEvent: function( event, data )
    {
	if ( parent.window[event] != undefined ) {

	    callback = parent.window[event];
	    callback( data );
	}
    },

    parseId: function( id )
    {
	return id.replace( /[^0-9a-z]/gi, '' ).toLowerCase();
    },
    
    setTabsAjax: function( seletor, callback )
    {  
	var element = $( seletor );
	element.find( '> .nav-tabs' ).bind( 'show', 
	    function( e ) 
	    {    
		if ( $( e.target ).parent().hasClass( 'disabled' ) )
		    return false;
		
		if ( $( e.target ).hasClass( 'loaded' ) || !$( e.target ).hasClass( 'ajax-tab' ) )
		    return true;
		
		var index = $( e.target ).parent().index();
		var href = $( e.target ).attr( 'data-href' );
		
		pane = element.find( '> .tab-content > .tab-pane' ).eq( index );
		
		pane.load( href, function()
		    {
			$( e.target ).addClass( 'loaded' );
			
			Form.init();
			General.execFunction( callback, pane );
		    }
		);
	    }
	);
    },
    
    releaseAndFireTab: function ( tab )
    {
	$( tab ).parent().removeClass( 'disabled' );
	$( tab ).trigger( 'click' );
    },
    
    confirm: function( text, title, callback )
    {
	if ( $( '#dialog_confirm' ).length )
	    $( '#dialog_confirm' ).remove();
	
	var divDialog = $( '<div />' );
	divDialog.addClass( 'hide' )
		 .attr( 'id', 'dialog_confirm' )
		 .attr( 'title', title || 'Confirm' );
		 
	var spanIcon = $( '<span />' );
	spanIcon.addClass( 'icon icon-warning-sign' );
	
	pText = $( '<p />' );
	pText.html( text );
	pText.prepend( spanIcon );
	
	divDialog.append( pText );
	$( 'body' ).append( divDialog );
	    
	$( "#dialog_confirm" ).dialog(
	    {
		dialogClass: 'ui-dialog-red',
		autoOpen: true,
		resizable: false,
		modal: true,
		buttons: [
		    {
			'class' : 'btn red',	
			"text" : "Yes",
			click: 
			function() 
			{
			    $(this).dialog( "close" );
			    General.execFunction( callback );
			}
		    },
		    {
			'class' : 'btn',
			"text" : "No",
			click: 
			function() 
			{
			    $(this).dialog( "close" );
			}
		    }
		]
	    }
	);
    },
    
    ajaxModal: function( settings )
    {
	urlModal = General.getUrl( settings.url );
	
	var modal = $( '#modal-root' ).clone();
	
	modal.attr( 'id', (new Date()).getTime() );
	modal.find( '.modal-header h3' ).html( settings.title );
	
	// Append to the body
	$( 'body' ).append( modal );
	
	// If there is button to be created
	if ( !General.empty( settings.buttons ) ) {
	    
	    $.each( settings.buttons, 
		function( index, obj )
		{
		    button = $( '<button />' );
		    button.attr( 'type', 'button' )
			  .addClass( 'btn ' + obj.css )
			  .html( obj.text )
			  .click( 
			    function()
			    {
				General.execFunction( obj.click, modal );
			    }
			  );
			      
		    modal.find( '.modal-footer' ).prepend( button );
		}
	    );
	}
	
	General.loading( true );
	modal.find( '.modal-body' ).load( urlModal, settings.data, 
	    function()
	    {
		modal.modal();
		General.execFunction( settings.callback, modal );
		
		modal.on( 'click', function( e )
		    {
			if ( $( e.target ).closest( '.select2-container' ).length )
			    return false;
			
			//e.stopPropagation();
			$( '.chosen' ).select2( 'close' );
		    }
		);
		    
		General.loading( false );
	    }
	);
	    
	// Remove modal when it's closed
	modal.on( 'hidden', 
	    function () 
	    {
		if ( !General.empty( settings.callbackClose ) )
		    General.execFunction( settings.callbackClose, modal );

		modal.remove();
	    }
	);
    },
    
    initResetForm: function()
    {
        $(".reset").on('click',
            function()
            {
                var url = window.location.origin + '/' + window.location.pathname.split( '/' )[1];
                $(location).attr("href", url);
            }
        );
    },
}

// General init
$(
    function()
    {
	General.init();        
    }
)