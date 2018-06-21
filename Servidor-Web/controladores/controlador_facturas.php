<?php	
	session_start();
	
	if (isset($_REQUEST["crear_factura"])) {
		unset($_REQUEST["crear_factura"]);
		$_SESSION["OID_PEDIDO"] = $_REQUEST["OID_PEDIDO"];
		$_SESSION["OID_ALMACEN"] = $_REQUEST["OID_ALMACEN"];
		$_SESSION["OID_ENVIO"] = $_REQUEST["OID_ENVIO"];
		$_SESSION["PRECIO_ENVIO"] = $_REQUEST["PRECIO_ENVIO"];
		if($_REQUEST["eleccion"]){
			$_SESSION["eleccion"] = "eleccion";
		}
		Header("Location: ../acciones/accion_factura_crear.php");
	}
	else 
		Header("Location: ../index.php");
	
?>
