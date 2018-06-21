<?php	
	session_start();	
	
	if (isset($_SESSION["lote"])) {
		$lote = $_SESSION["lote"];
		unset($_SESSION["lote"]);
		
		require_once("../Base/gestionBD.php");
		require_once("../gestores/gestionarLote.php");
		
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		// INVOCAR "QUITAR_TITULO"5
		$excepcion = crearLote($conexion, $lote['CANTIDAD_LOTE'], $lote['PRECIO_LOTE'], $lote['OID_PROVEEDOR'],$lote['OID_PRODUCTO']);
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_BOLSA.PHP"
		if($excepcion<>""){
			$_SESSION["excepcion"]=$excepcion;
			$_SESSION["destino"] = "../index.php";
			header("Location: ../index.php?tituloPag=Excepcion");
		}else {
			header("Location: ../index.php?tituloPag=Lote");
		}

	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: ../index.php"); 
?>
