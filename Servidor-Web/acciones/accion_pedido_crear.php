<?php	
	session_start();	
	
	if (isset($_SESSION["opcion"])){
		
		$opcion = $_SESSION["opcion"];
		unset($_SESSION["opcion"]);
		
		if($opcion == "proveedor"){
			$pedido["OID_PROVEEDOR"] = $_SESSION["OID_PROVEEDOR"];
			unset($_SESSION["OID_PROVEEDOR"]);
		} else{
			$pedido["OID_ALMACEN"] = $_SESSION["OID_ALMACEN"];
			unset($_SESSION["OID_ALMACEN"]);
		}
		
		
			require_once("../Base/gestionBD.php");
			require_once("../gestores/gestionarPedidos.php");
			
			// CREAR LA CONEXIÓN A LA BASE DE DATOS
			$conexion = crearConexionBD();
			//Creamos
			if($opcion == "farmacia"){
				crear_pedido_farmacia($conexion, $pedido["OID_ALMACEN"]);
			}else{
				crear_pedido_proveedor($conexion, $pedido["OID_PROVEEDOR"]);
			}
			// CERRAR LA CONEXIÓN
			cerrarConexionBD($conexion);
			// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
			// EN OTRO CASO, VOLVER A "CONSULTA_PEDIDOS.PHP"
			if(isset($_SESSION["excepcion"])){
				$_SESSION["destino"] = "../index.php";
				header("Location: ../index.php?tituloPag=Excepcion");
			}else{
				header("Location: ../index.php?tituloPag=Farmacia");
			}
		
	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: ../index.php");
		 
?>
