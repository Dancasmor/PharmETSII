// JQUERY
$(document).ready(function() {
	// Código JQuery
	
	var divError = document.getElementById("div_error");
	//Validar pedido
	$("#form_pedido").on("input", function() {
		var elemento = this;
		$.get("../validadores/validar_factura_pedido.php", {oid : this.value}, function(data) {
			if (data == 0) {
				$("#form_pedido").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "El pedido no existe o ya ha sido enviado(factura ya creada)";
				$("#error_pedido").addClass('err_p');
				$("#error_pedido").html(error);
			} else {
				var error = "";
				$("#form_pedido").removeClass('err');
				$("#error_pedido").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_pedido").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	
	//Validar el envio 
	$("#form_envio").on("input", function() {
		var elemento = this;
		$.get("../validadores/validar_factura_envio.php", {oid : this.value}, function(data) {
			if (data == 0) {
				$("#form_envio").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "El envio no existe";
				$("#error_envio").addClass('err_p');
				$("#error_envio").html(error);
			} else {
				var error = "";
				$("#form_envio").removeClass('err');
				$("#error_envio").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_envio").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	
	//Validar almacen
	$("#form_almacen").on("input", function() {
		var elemento = this;
		$.get("../validadores/validar_factura_almacen.php", {oid : this.value}, function(data) {
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
});
