$(document).ready(function() {

	var divError = document.getElementById("div_error");

	$("#inOID_ALMACEN").on("input" , function() {
		var elemento = this;
		$.get("./validadores/validar_seccion_oidAlmacen.php", {oid : this.value}, function(data) {
			if (data == 0) {
				$("#inOID_ALMACEN").addClass('err');
				var error = "El almacén no existe";
				$("#error_seccion_almacen").addClass('err_p');
				$("#error_seccion_almacen").html(error);
			} else {
				var error = "";
				$("#inOID_ALMACEN").removeClass('err');
				$("#error_seccion_almacen").removeClass('err_p');
				$("#error_seccion_almacen").empty();
			}
			elemento.setCustomValidity(error);
		});
	});
	
	$("#inOID_PRODUCTO").on("input" , function() {
		var elemento = this;
		
		$.get("./validadores/validar_seccion_oidProducto.php", {oid : this.value}, function(data) {
			if (data == 0) {
				$("#inOID_PRODUCTO").addClass('err');
				var error = "El producto no existe";
				$("#error_seccion_producto").addClass('err_p');
				$("#error_seccion_producto").html(error);
			} else {
				var error = "";
				$("#inOID_PRODUCTO").removeClass('err');
				$("#error_seccion_producto").removeClass('err_p');
				$("#error_seccion_producto").empty();
			}
			elemento.setCustomValidity(error);
		});
	});

});