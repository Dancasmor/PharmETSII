// JQUERY
$(document).ready(function() {
	// Código JQuery
	
	var divError = document.getElementById("div_error");
	
	$("#form_confirmpass").parent().hide();

	//Validar que no existe el proveedor al crear uno nuevo
	$("#form_prov_lab").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_nombre_proveedor.php", {nombreLab : this.value}, function(data) {
			if (data == 0) {
				$("#form_prov_lab").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "El proveedor ya existe";
				$("#error_prov_lab").addClass('err_p');
				$("#error_prov_lab").html(error);
			} else {
				var error = "";
				$("#form_prov_lab").removeClass('err');
				$("#error_prov_lab").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_prov_lab").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	//Validar la informacion de contacto del proveedor
		$("#form_prov_contacto").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_existe_contacto_proveedor.php", {oidContacto : this.value}, function(data) {
			if (data == 0) {
				$("#form_prov_contacto").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "La información de contacto dada no existe";
				$("#error_existe_contacto_proveedor").addClass('err_p');
				$("#error_existe_contacto_proveedor").html(error);
			} else {
				var error = "";
				$("#form_prov_contacto").removeClass('err');
				$("#error_existe_contacto_proveedor").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_existe_contacto_proveedor").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	//	
	$("#form_prov_contacto").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_contacto_proveedor.php", {oidContacto : this.value}, function(data) {
			if (data == 0) {
				$("#form_prov_contacto").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "La información de contacto dada pertecene a otra entidad";
				$("#error_contacto_proveedor").addClass('err_p');
				$("#error_contacto_proveedor").html(error);
			} else {
				var error = "";
				$("#form_prov_contacto").removeClass('err');
				$("#error_contacto_proveedor").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_contacto_proveedor").empty();
			}
			elemento.setCustomValidity(error);
		});
	});

});
//Funcion para validar la contraseña
function validar_contraseña_proveedor() {
	var pass = document.getElementById("form_pass");
  	var res = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/;
  	
	if (!pass.value.match(res)) {
		var error = "La contraseña debe contener al menos 1 número, una mayúscula/minúscula y 8 caracteres de longitud.";
		$("#error_contrasenya_proveedor").addClass('err_p');
		$("#error_contrasenya_proveedor").html(error);
	} else {
		var error = "";
		$("#error_contrasenya_proveedor").removeClass('err_p');
		$("#error_contrasenya_proveedor").empty();
	}
	if (error == "")
		$("#form_confirmpass").parent().show();
	else {
		$("#form_confirmpass").parent().hide();
	}
	pass.setCustomValidity(error);
	return error;
}
//Funcion para validar la confirmacion de la contraseña
function validar_confirmacion_contraseña_proveedor() {
	var pass = document.getElementById("form_pass");
	var cpass = document.getElementById("form_confirmpass");
  	
	if (pass.value!=cpass.value) {
		var error = "Las contraseñas no coinciden";
		$("#error_confirmacion_contrasenya_proveedor").addClass('err_p');
		$("#error_confirmacion_contrasenya_proveedor").html(error);
	} else {
		var error = "";
		$("#error_confirmacion_contrasenya_proveedor").removeClass('err_p');
		$("#error_confirmacion_contrasenya_proveedor").empty();
	}
	cpass.setCustomValidity(error);
	return error;
}
