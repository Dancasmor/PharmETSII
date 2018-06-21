function validar_contraseña() {
	var pass = document.getElementById("form_pass");
  	var res = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/;
  	
	if (!pass.value.match(res)) {
		var error = "La contraseña debe contener al menos 1 número, una mayúscula/minúscula y 8 caracteres de longitud.";
		$("#error_cambiar_contraseña").addClass('err_p');
		$("#error_cambiar_contraseña").html(error);
	} else {
		var error = "";
		$("#error_cambiar_contraseña").removeClass('err_p');
		$("#error_cambiar_contraseña").empty();
	}if (error == "")
		$("#form_confirmpass").parent().show();
	else {
		$("#form_confirmpass").parent().hide();
	}
	pass.setCustomValidity(error);
	return error;
}
function validar_confirmacion_contraseña() {
	var pass = document.getElementById("form_pass");
	var cpass = document.getElementById("form_confirmpass");
  	
	if (pass.value!=cpass.value) {
		var error = "Las contraseñas no coinciden";
		$("#error_cambiar_contraseña_confirmacion").addClass('err_p');
		$("#error_cambiar_contraseña_confirmacion").html(error);
	} else {
		var error = "";
		$("#error_cambiar_contraseña_confirmacion").removeClass('err_p');
		$("#error_cambiar_contraseña_confirmacion").empty();
	}
	cpass.setCustomValidity(error);
	return error;
}