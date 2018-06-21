<?php	
	session_start();
	
	if (isset($_REQUEST["crear_linea_lote"])) {
		unset($_REQUEST["crear_linea_lote"]);
		$_SESSION["OID_PEDIDO"] = $_REQUEST["OID_PEDIDO"];
		$_SESSION["CANTIDAD"] = $_REQUEST["CANTIDAD"];
		$_SESSION["OID_LOTE"] = $_REQUEST["OID_LOTE"];
		$_SESSION["opcion"] = "lote";
		Header("Location: ../acciones/accion_linea_crear.php");
	}
	else if (isset($_REQUEST["crear_linea_producto"])) {
		unset($_REQUEST["crear_linea_producto"]);
		$_SESSION["OID_PEDIDO"] = $_REQUEST["OID_PEDIDO"];
		$_SESSION["CANTIDAD"] = $_REQUEST["CANTIDAD"];
		$_SESSION["OID_PRODUCTO"] = $_REQUEST["OID_PRODUCTO"];
		$_SESSION["opcion"] = "producto";
		Header("Location: ../acciones/accion_linea_crear.php");
	}
	else if (isset($_REQUEST["borrar"])) {
		unset($_REQUEST["borrar"]);
		$_SESSION["OID_LINEA"] = $_REQUEST["OID_LINEA"];
		
		Header("Location: ../acciones/accion_linea_eliminar.php");
	}
	else if (isset($_REQUEST["busqueda_por_pedido"])) {
		unset($_REQUEST["busqueda_por_pedido"]);
		$_SESSION["opcion"] = "pedido";
		$_SESSION["OID_PEDIDO"] = $_REQUEST["OID_PEDIDO"];
		
		Header("Location: ../acciones/accion_linea_buscar.php");
	}
	else if (isset($_REQUEST["busqueda_por_lote"])) {
		unset($_REQUEST["busqueda_por_lote"]);
		$_SESSION["opcion"] = "lote";
		$_SESSION["OID_LOTE"] = $_REQUEST["OID_LOTE"];
		
		Header("Location: ../acciones/accion_linea_buscar.php");
	}
	else if (isset($_REQUEST["busqueda_por_producto"])) {
		unset($_REQUEST["busqueda_por_producto"]);
		$_SESSION["opcion"] = "producto";
		$_SESSION["OID_PRODUCTO"] = $_REQUEST["OID_PRODUCTO"];
		
		Header("Location: ../acciones/accion_linea_buscar.php");
	}
	else if (isset($_REQUEST["consultar_linea"])) {
		unset($_REQUEST["consultar_linea"]);
		
		$linea["OID_PEDIDO"] = $_REQUEST["OID_PEDIDO"];
		$linea["CANTIDAD"] = $_REQUEST["CANTIDAD"];
		$linea["OID_LINEA"] = $_REQUEST["OID_LINEA"];
		
		if(isset($_REQUEST["OID_LOTE"])){
			$linea["OID_LOTE"] = $_REQUEST["OID_LOTE"];
		}else{
			$linea["OID_PRODUCTO"] = $_REQUEST["OID_PRODUCTO"];
		}
		
		$_SESSION["linea"] = $linea;
		
		Header("Location: ../index.php");
	}
	else 
		Header("Location: ../index.php");
	
?>
