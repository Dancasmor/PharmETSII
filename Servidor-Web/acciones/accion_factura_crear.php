<?php	
	session_start();	
	
	if (isset($_SESSION["OID_PEDIDO"])){
		
		$factura["OID_PEDIDO"] = $_SESSION["OID_PEDIDO"];
		$factura["OID_ALMACEN"] = $_SESSION["OID_ALMACEN"];
		$factura["OID_ENVIO"] = $_SESSION["OID_ENVIO"];
		$factura["PRECIO_ENVIO"] = $_SESSION["PRECIO_ENVIO"];
		
		
			require_once("../Base/gestionBD.php");
			require_once("../gestores/gestionarFacturas.php");
			// CREAR LA CONEXIÓN A LA BASE DE DATOS
			$conexion = crearConexionBD();
			//Creamos
			crear_factura($conexion, $factura["PRECIO_ENVIO"], $factura["OID_PEDIDO"], $factura["OID_ALMACEN"], $factura["OID_ENVIO"]);
			
			// CERRAR LA CONEXIÓN
			cerrarConexionBD($conexion);
			// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
			// EN OTRO CASO, VOLVER A "CONSULTA_FACTURAS.PHP"
			if(isset($_SESSION["excepcion"])){
				$_SESSION["destino"] = "../index.php";
				header("Location: ../index.php?tituloPag=Excepcion");
			}else{
				if(isset($_SESSION["eleccion"])){
					unset($_SESSION["eleccion"]);
					header("Location: ../index.php?tituloPag=Pedidos");
				}else{
					$pedido = $_SESSION["OID_PEDIDO"];
					header("Location: ../index.php?tituloPag=Perfil&idPedidoProveedor=$pedido");
				}
				
			}
		
	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: ../index.php"); 
	
?>
