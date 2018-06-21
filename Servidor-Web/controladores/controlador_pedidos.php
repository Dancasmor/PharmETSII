<?php	
	session_start();
	
	if (isset($_REQUEST["crea_pedido_farmacia"])) {
		unset($_REQUEST["crea_pedido_farmacia"]);
		$_SESSION["OID_ALMACEN"] = $_REQUEST["OID_ALMACEN"];
		$_SESSION["opcion"] = "farmacia";
		Header("Location: ../acciones/accion_pedido_crear.php");
	}
	else if (isset($_REQUEST["crear_pedido_proveedor"])) {
		unset($_REQUEST["crear_pedido_proveedor"]);
		$_SESSION["OID_PROVEEDOR"] = $_REQUEST["OID_PROVEEDOR"];
		$_SESSION["opcion"] = "proveedor";
		Header("Location: ../acciones/accion_pedido_crear.php");
	}
	else if (isset($_REQUEST["enviar"])) {
		unset($_REQUEST["enviar"]);
		$_SESSION["OID_PEDIDO"] = $_REQUEST["OID_PEDIDO"];
		Header("Location: ../acciones/accion_pedido_enviar.php");
	}
	else if (isset($_REQUEST["borrar"])) {
		unset($_REQUEST["borrar"]);
		$_SESSION["OID_PEDIDO"] = $_REQUEST["OID_PEDIDO"];
		
		Header("Location: ../acciones/accion_pedido_eliminar.php");
	}
	else if (isset($_REQUEST["busqueda_por_proveedor"])) {
		unset($_REQUEST["busqueda_por_proveedor"]);
		$_SESSION["opcion"] = "proveedor";
		$_SESSION["OID_PROVEEDOR"] = $_REQUEST["OID_PROVEEDOR"];
		
		Header("Location: ../acciones/accion_pedido_buscar.php");
	}
	else if (isset($_REQUEST["busqueda_por_fecha"])) {
		unset($_REQUEST["busqueda_por_fecha"]);
		$_SESSION["opcion"] = "fecha";
		$_SESSION["FECHA_PEDIDO"] = $_REQUEST["FECHA_PEDIDO"];
		
		Header("Location: ../acciones/accion_pedido_buscar.php");
	}
	else if (isset($_REQUEST["busqueda_por_almacen"])) {
		unset($_REQUEST["busqueda_por_almacen"]);
		$_SESSION["opcion"] = "almacen";
		$_SESSION["OID_ALMACEN"] = $_REQUEST["OID_ALMACEN"];
		
		Header("Location: ../acciones/accion_pedido_buscar.php");
	}
	else 
		Header("Location: ../index.php");
	
?>
