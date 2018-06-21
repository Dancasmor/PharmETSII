<?php	
	session_start();
	
	if (isset($_REQUEST["crear"])) {
		unset($_REQUEST["crear"]);
		
		$_SESSION["OID_ALMACEN"] = $_REQUEST["OID_ALMACEN"];
		if(isset($_REQUEST["OID_EMPRESA"])){
			$_SESSION["OID_EMPRESA"] = $_REQUEST["OID_EMPRESA"];
		} else{
			$_SESSION["OID_FARMACIA"] = $_REQUEST["OID_FARMACIA"];
		}
		$_SESSION["OID_PRODUCTO"] = $_REQUEST["OID_PRODUCTO"];
		Header("Location: ../acciones/accion_seccion_crear.php");
	}
	else if (isset($_REQUEST["consultar_seccion"])) {
		unset($_REQUEST["consultar_seccion"]);
		$_SESSION["OID_SECCION"] = $_REQUEST["OID_SECCION"];
		Header("Location: ../acciones/accion_seccion_buscar.php");
	}
	else if (isset($_REQUEST["borrar"])) {
		unset($_REQUEST["borrar"]);
		if(isset($_REQUEST["OID_EMPRESA"])){
			$_SESSION["OID_EMPRESA"] = $_REQUEST["OID_EMPRESA"];
		} else{
			$_SESSION["OID_FARMACIA"] = $_REQUEST["OID_FARMACIA"];
		}
		$_SESSION["OID_SECCION"] = $_REQUEST["OID_SECCION"];
		Header("Location: ../acciones/accion_seccion_eliminar.php");
	}
	else if (isset($_REQUEST["añadir"])) {
		unset($_REQUEST["añadir"]);
		$_SESSION["opcion"] = "añadir";
		if(isset($_REQUEST["OID_EMPRESA"])){
			$_SESSION["OID_EMPRESA"] = $_REQUEST["OID_EMPRESA"];
		} else{
			$_SESSION["OID_FARMACIA"] = $_REQUEST["OID_FARMACIA"];
		}
		$_SESSION["OID_SECCION"] = $_REQUEST["OID_SECCION"];
		$_SESSION["cantidad"] = $_REQUEST["cantidad"];
		Header("Location: ../acciones/accion_seccion_modificar.php");
	}
	else if (isset($_REQUEST["restar"])) {
		unset($_REQUEST["añadir"]);
		$_SESSION["opcion"] = "restar";
		if(isset($_REQUEST["OID_EMPRESA"])){
			$_SESSION["OID_EMPRESA"] = $_REQUEST["OID_EMPRESA"];
		} else{
			$_SESSION["OID_FARMACIA"] = $_REQUEST["OID_FARMACIA"];
		}
		$_SESSION["OID_SECCION"] = $_REQUEST["OID_SECCION"];
		$_SESSION["cantidad"] = $_REQUEST["cantidad"];
		Header("Location: ../acciones/accion_seccion_modificar.php");
	}
	else 
		Header("Location: ../index.php");
	
?>
