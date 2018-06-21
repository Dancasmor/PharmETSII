$(document).ready(function(){
	$('#TARJETA').hide();
	
	$('#paraOcultar').hide();
	
	$('#CONTRAREEMBOLSO_TARJETA').change(function(){
		$('#TARJETA').val('');
		if($('#CONTRAREEMBOLSO_TARJETA').is(':checked')){
			$('#TARJETA').prop('required',true);
			$('#TARJETA').show();
			$('#paraOcultar').show();
		}else{
			$('#TARJETA').prop('required',false);
			$('#TARJETA').hide();
			$('#paraOcultar').hide();
		}
	});
	$('#logo_principal').click(function(){
		location.href ="?tituloPag=Portada";
	});
	
});

function cambioGrid2(){
	$('#catalogo').css("grid-template-columns", "auto auto auto");
}

function cambioGrid(){
	$('#catalogo').css("grid-template-columns", "auto auto auto auto");
}