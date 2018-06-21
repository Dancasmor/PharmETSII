// JQUERY
$(document).ready(function() {
	// Código JQuery
	
	var divError = document.getElementById("div_error");
	
	$("#form_cantidad").parent().hide();
	
	//Estos errores los declaramos fuera pues es necesario que sean conocidos para desbloquear el campo cantidad
	var errorProducto = null;
	
	//Validar lote
	$("#form_lote").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_linea_lote.php", {oid : this.value}, function(data) {
			if (data == 0) {
				$("#form_lote").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "El lote no existe o no pertenece al proveedor al que pides";
				$("#error_lote").addClass('err_p');
				$("#error_lote").html(error);
			} else {
				var error = "";
				$("#form_lote").removeClass('err');
				$("#error_lote").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_lote").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	
	//Validar producto
	$("#form_producto").on("click", function() {
		var elemento = this;
		$.get("./validadores/validar_linea_producto.php", {oid : this.value}, function(data) {
			if (data == 0) {
				$("#form_producto").addClass('err');
				// Introducimos el parrafo en el div de errores
				errorProducto = "El producto no existe";
				$("#error_producto").addClass('err_p');
				$("#error_producto").html(errorProducto);
			} else {
				errorProducto = "";
				$("#form_producto").removeClass('err');
				$("#error_producto").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_producto").empty();
			}
			//Si se ha introducidp correctamente pedido y producto, mostraremos para introducir cantidad
			if (errorProducto == "")
				$("#form_cantidad").parent().show();
			else {
				$("#form_cantidad").parent().hide();
			}
			
			elemento.setCustomValidity(errorProducto);
		});
	});
	
	//Validar cantidad
	$("#form_cantidad").on("input", function() {
		var elemento = this;
		$.get("./validadores/validar_linea_cantidad.php", {cantidad : this.value}, function(data) {
		
			if (data == 0) {
				$("#form_cantidad").addClass('err');
				// Introducimos el parrafo en el div de errores
				var error = "No puedes pedir más de lo que puedes almacenar";
				$("#error_cantidad").addClass('err_p');
				$("#error_cantidad").html(error);
			} else {
				var error = "";
				$("#form_cantidad").removeClass('err');
				$("#error_cantidad").removeClass('err_p');
				//Eliminamos en el caso de que exista errores del div
				$("#error_cantidad").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
});
