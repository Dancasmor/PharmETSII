// JQUERY
$(document).ready(function() {
	// Código JQuery
	var divError = document.getElementById("div_error");
	//Validar el envio a almacenes
	$("#form_almacen").on("input" , function() {
		var elemento = this;
		$.get("./validadores/validar_envio.php", {oid : this.value}, function(data) {
			if (data == 0) {
				$("#form_almacen").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "El almacén no existe";
				$("#error_almacen").addClass('err_p');
				$("#error_almacen").html(error);
			} else {
				var error = "";
				$("#form_almacen").removeClass('err');
				$("#error_almacen").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_almacen").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	
	//Validar el envio de proveedores
	$("#form_proveedor").on("input" , function() {
		var elemento = this;
		$.get("../validadores/validar_envio_proveedor.php", {oid : this.value}, function(data) {
			if (data == 0) {
				$("#form_proveedor").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "El proveedor no existe";
				$("#error_proveedor").addClass('err_p');
				$("#error_proveedor").html(error);
			} else {
				var error = "";
				$("#form_proveedor").removeClass('err');
				$("#error_proveedor").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_proveedor").empty();
			}
			elemento.setCustomValidity(error);
		});
	});

});