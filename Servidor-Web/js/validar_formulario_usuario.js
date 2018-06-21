$(document).ready(function() {
	$('#Rcontraseña_usuario').change(function(){
		var elemento=this;
		if($('#Rcontraseña_usuario').val()!=$('#contraseña_usuario').val()){
			elemento.setCustomValidity('Las contraseñas no coinciden');
			$('#Rcontraseña_usuario').addClass('err');
		}else if($('#Rcontraseña_usuario').val()==$('#contraseña_usuario').val()){
			$('#Rcontraseña_usuario').removeClass('err');
			elemento.setCustomValidity('');
		}
		
	});
	
});