<?php	
	session_start();	
	
	if (isset($_SESSION["OID_PRODUCTO"])){
		$producto = $_SESSION["OID_PRODUCTO"];
		unset($_SESSION["OID_PRODUCTO"]);
		
		require_once("gestionBD.php");
		require_once("gestionarProducto.php");

		$conexion = crearConexionBD();
		$excepcion = borrar_producto($conexion, $producto);
		cerrarConexionBD($conexion);
		
		if($excepcion <> ""){
			$_SESSION["excepcion"] = $excepcion;
			$_SESSION["destino"] = "consulta_producto.php";
			header("Location: excepcion.php");
		}else{
			header("Location: consulta_producto.php");
		}
	}
	else
		Header("Location: consulta_producto.php"); 
?>
