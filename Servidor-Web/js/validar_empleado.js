// JQUERY
$(document).ready(function() {
	// Código JQuery
	
	var divError = document.getElementById("div_error");
	
	$("#form_confirmpass_emp").parent().hide();
	$("#form_confirmpass_farm").parent().hide();

	//Validar que no existe el empleado al crear uno nuevo
	$("#form_dni_empleado_emp").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_existe_dni.php", {dniEmpleado : this.value}, function(data) {
			if (data == 0) {
				$("#form_dni_empleado_emp").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "El empleado ya existe";
				$("#error_existe_dni_emp").addClass('err_p');
				$("#error_existe_dni_emp").html(error);
			} else {
				var error = "";
				$("#form_dni_empleado_emp").removeClass('err');
				$("#error_existe_dni_emp").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_existe_dni_emp").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	$("#form_dni_empleado_farm").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_existe_dni.php", {dniEmpleado : this.value}, function(data) {
			if (data == 0) {
				$("#form_dni_empleado_farm").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "El empleado ya existe";
				$("#error_existe_dni_farm").addClass('err_p');
				$("#error_existe_dni_farm").html(error);
			} else {
				var error = "";
				$("#form_dni_dni_empleado_farm").removeClass('err');
				$("#error_existe_dni_farm").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_existe_dni_farm").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	//Validar la informacion de contacto del empleado
	//Empresa
		$("#form_contacto_empresa").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_existe_contacto.php", {oidContacto : this.value}, function(data) {
			if (data == 0) {
				$("#form_contacto_empresa").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "La información de contacto dada no existe";
				$("#error_existe_contacto_empresa").addClass('err_p');
				$("#error_existe_contacto_empresa").html(error);
			} else {
				var error = "";
				$("#form_contacto_empresa").removeClass('err');
				$("#error_existe_contacto_empresa").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_existe_contacto_empresa").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	//	
	$("#form_contacto_empresa").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_contacto_empleado.php", {oidContacto : this.value}, function(data) {
			if (data == 0) {
				$("#form_contacto_empresa").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "La información de contacto dada pertecene a otra entidad";
				$("#error_contacto_empresa").addClass('err_p');
				$("#error_contacto_empresa").html(error);
			} else {
				var error = "";
				$("#form_contacto_empresa").removeClass('err');
				$("#error_contacto_empresa").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_contacto_empresa").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	//Validar la informacion de contacto del empleado
	//Farmacia
		$("#form_contacto_farmacia").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_existe_contacto.php", {oidContacto : this.value}, function(data) {
			if (data == 0) {
				$("#form_contacto_farmacia").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "La información de contacto dada no existe";
				$("#error_existe_contacto_farmacia").addClass('err_p');
				$("#error_existe_contacto_farmacia").html(error);
			} else {
				var error = "";
				$("#form_contacto_farmacia").removeClass('err');
				$("#error_existe_contacto_farmacia").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_existe_contacto_farmacia").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	//	
	$("#form_contacto_farmacia").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_contacto_empleado.php", {oidContacto : this.value}, function(data) {
			if (data == 0) {
				$("#form_contacto_farmacia").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "La información de contacto dada pertecene a otra entidad";
				$("#error_contacto_farmacia").addClass('err_p');
				$("#error_contacto_farmacia").html(error);
			} else {
				var error = "";
				$("#form_contacto_farmacia").removeClass('err');
				$("#error_contacto_farmacia").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_contacto_farmacia").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	//Funcion para validar que existe la empresa dada
	$("#form_oid_empresa").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_empresa_empleado.php", {oidEmpresa : this.value}, function(data) {
			if (data == 0) {
				$("#form_oid_empresa").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "La empresa dada no existe";
				$("#error_existe_oid_empresa").addClass('err_p');
				$("#error_existe_oid_empresa").html(error);
			} else {
				var error = "";
				$("#form_oid_empresa").removeClass('err');
				$("#error_existe_oid_empresa").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_existe_oid_empresa").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	//Funcion para validar que existe la farmacia dada
	$("#form_oid_farmacia").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_farmacia_empleado.php", {oidFarmacia : this.value}, function(data) {
			if (data == 0) {
				$("#form_oid_farmacia").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "La farmacia dada no existe";
				$("#error_existe_oid_farmacia").addClass('err_p');
				$("#error_existe_oid_farmacia").html(error);
			} else {
				var error = "";
				$("#form_oid_farmacia").removeClass('err');
				$("#error_existe_oid_farmacia").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_existe_oid_farmacia").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
});
//Funcion para validar la fecha de nacimiento de los empleados
function validarFechaNacimientoEmp(){
	var fecha_nacimiento = new Date (document.getElementById("form_fecha_nacimiento_emp").value);
	var fecha_actual = new Date();
	
	if(fecha_nacimiento > fecha_actual){
		var error = "Introduzca una fecha válida";
		$("#error_fecha_nac_emp").addClass('err_p');
		$("#error_fecha_nac_emp").html(error);
	} else{
		var error = "";
		$("#error_fecha_nac_emp").removeClass('err_p');
		$("#error_fecha_nac_emp").empty();
	}
	
	fecha_nacimiento.setCustomValidity(error);
	return error;
}
function validarFechaNacimientoFarm(){
	var fecha_nacimiento = new Date (document.getElementById("form_fecha_nacimiento_farm").value);
	var fecha_actual = new Date();
	
	if(fecha_nacimiento > fecha_actual){
		var error = "Introduzca una fecha válida";
		$("#error_fecha_nac_farm").addClass('err_p');
		$("#error_fecha_nac_farm").html(error);
	} else{
		var error = "";
		$("#error_fecha_nac_farm").removeClass('err_p');
		$("#error_fecha_nac_farm").empty();
	}
	
	fecha_nacimiento.setCustomValidity(error);
	return error;
}
//Funcion para validar la contraseña
function validar_contraseña_emp() {
	var pass = document.getElementById("form_pass_emp");
  	var res = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/;
  	
	if (!pass.value.match(res)) {
		var error = "La contraseña debe contener al menos 1 número, una mayúscula/minúscula y 8 caracteres de longitud.";
		$("#error_contrasenya_empleado").addClass('err_p');
		$("#error_contrasenya_empleado").html(error);
	} else {
		var error = "";
		$("#error_contrasenya_empleado").removeClass('err_p');
		$("#error_contrasenya_empleado").empty();
	}
	if (error == "")
		$("#form_confirmpass_emp").parent().show();
	else {
		$("#form_confirmpass_emp").parent().hide();
	}
	pass.setCustomValidity(error);
	return error;
}
function validar_contraseña_farm() {
	var pass = document.getElementById("form_pass_farm");
  	var res = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/;
  	
	if (!pass.value.match(res)) {
		var error = "La contraseña debe contener al menos 1 número, una mayúscula/minúscula y 8 caracteres de longitud.";
		$("#error_contrasenya_empleado").addClass('err_p');
		$("#error_contrasenya_empleado").html(error);
	} else {
		var error = "";
		$("#error_contrasenya_empleado").removeClass('err_p');
		$("#error_contrasenya_empleado").empty();
	}
	if (error == "")
		$("#form_confirmpass_farm").parent().show();
	else {
		$("#form_confirmpass_farm").parent().hide();
	}
	pass.setCustomValidity(error);
	return error;
}
//Funcion para validar la confirmacion de la contraseña
function validar_confirmacion_contraseña_emp() {
	var pass = document.getElementById("form_pass_emp");
	var cpass = document.getElementById("form_confirmpass_emp");
  	
	if (pass.value!=cpass.value) {
		var error = "Las contraseñas no coinciden";
		$("#error_confirmacion_contrasenya_empleado").addClass('err_p');
		$("#error_confirmacion_contrasenya_empleado").html(error);
	} else {
		var error = "";
		$("#error_confirmacion_contrasenya_empleado").removeClass('err_p');
		$("#error_confirmacion_contrasenya_empleado").empty();
	}
	cpass.setCustomValidity(error);
	return error;
}
function validar_confirmacion_contraseña_farm() {
	var pass = document.getElementById("form_pass_farm");
	var cpass = document.getElementById("form_confirmpass_farm");
  	
	if (pass.value!=cpass.value) {
		var error = "Las contraseñas no coinciden";
		$("#error_confirmacion_contrasenya_empleado").addClass('err_p');
		$("#error_confirmacion_contrasenya_empleado").html(error);
	} else {
		var error = "";
		$("#error_confirmacion_contrasenya_empleado").removeClass('err_p');
		$("#error_confirmacion_contrasenya_empleado").empty();
	}
	cpass.setCustomValidity(error);
	return error;
}
//Funcion para validar el dni del empleado
function validarDNI_emp(){
	var dni = document.getElementById("form_dni_empleado_emp").value;
	var res = /^\d{8}[a-zA-Z]$/;
	var numero;
	var letra;
	
	if(res.test(dni)){
		numero = (dni.substr(0, dni.length - 1)) % 23;
		letra = 'TRWAGMYFPDXBNJZSQVHLCKET'.substring(numero, numero + 1);
		if(letra != (dni.substr(dni.length - 1, 1)).toUpperCase()){
			var error = "DNI Incorrecto";
			$("#error_dni_empleado").addClass('err_p');
			$("#error_dni_empleado").html(error);
		} else{
			var error = "";
			$("#error_dni_empleado").removeClass('err_p');
			$("#error_dni_empleado").empty();
		}
	} else{
		var error = "";
		$("#error_dni_empleado").removeClass('err_p');
		$("#error_dni_empleado").empty();
	}
	
	dni.setCustomValidity(error);
	return error;
}
function validarDNI_farm(){
	var dni = document.getElementById("form_dni_empleado_farm").value;
	var res = /^\d{8}[a-zA-Z]$/;
	var numero;
	var letra;
	
	if(res.test(dni)){
		numero = (dni.substr(0, dni.length - 1)) % 23;
		letra = 'TRWAGMYFPDXBNJZSQVHLCKET'.substring(numero, numero + 1);
		if(letra != (dni.substr(dni.length - 1, 1)).toUpperCase()){
			var error = "DNI Incorrecto";
			$("#error_dni_empleado").addClass('err_p');
			$("#error_dni_empleado").html(error);
		} else{
			var error = "";
			$("#error_dni_empleado").removeClass('err_p');
			$("#error_dni_empleado").empty();
		}
	} else{
		var error = "";
		$("#error_dni_empleado").removeClass('err_p');
		$("#error_dni_empleado").empty();
	}
	
	dni.setCustomValidity(error);
	return error;
}
function validarFechaAltaEmp(){
	var fecha_alta = new Date (document.getElementById("form_fecha_alta_emp").value);
	var fecha_actual = new Date();
	
	if(fecha_alta.getDay() != fecha_actual.getDay() || fecha_alta.getMonth() != fecha_actual.getMonth() || fecha_alta.getYear() != fecha_actual.getYear()){
		var error = "La fecha de alta del usuario debe ser hoy.";
		$("#error_fecha_alta_emp").addClass('err_p');
		$("#error_fecha_alta_emp").html(error);
	} else{
		var error = "";
		$("#error_fecha_alta_emp").removeClass('err_p');
		$("#error_fecha_alta_emp").empty();
	}
	
	fecha_alta.setCustomValidity(error);
	return error;
}
function validarFechaAltaFarm(){
	var fecha_alta = new Date (document.getElementById("form_fecha_alta_farm").value);
	var fecha_actual = new Date();
	
	if(fecha_alta.getDay() != fecha_actual.getDay() || fecha_alta.getMonth() != fecha_actual.getMonth() || fecha_alta.getYear() != fecha_actual.getYear()){
		var error = "La fecha de alta del usuario debe ser hoy.";
		$("#error_fecha_alta_farm").addClass('err_p');
		$("#error_fecha_alta_farm").html(error);
	} else{
		var error = "";
		$("#error_fecha_alta_farm").removeClass('err_p');
		$("#error_fecha_alta_farm").empty();
	}
	
	fecha_alta.setCustomValidity(error);
	return error;
}