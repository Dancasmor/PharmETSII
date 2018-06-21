<?php	
	session_start();	
	
	if (isset($_SESSION["OID_PEDIDO"])){
		
		$linea["OID_PEDIDO"] = $_SESSION["OID_PEDIDO"];
		$linea["CANTIDAD"] = $_SESSION["CANTIDAD"];
		
		unset($_SESSION["OID_PEDIDO"]);
		unset($_SESSION["CANTIDAD"]);
		
		$opcion = $_SESSION["opcion"];
		unset($_SESSION["opcion"]);
		
		$validarCantidad = 1;
		
		if($opcion == "lote"){
			$linea["OID_LOTE"] = $_SESSION["OID_LOTE"];
			unset($_SESSION["OID_LOTE"]);
			$validarMateria = validarLote($linea["OID_LOTE"]);
		}else{
			$linea["OID_PRODUCTO"] = $_SESSION["OID_PRODUCTO"];
			unset($_SESSION["OID_PRODUCTO"]);
			$validarMateria = validarProducto($linea["OID_PRODUCTO"]);
			$validarCantidad = validarCantidad($linea["CANTIDAD"]);
		}
		
		
		if(($validarMateria == 1) && ($validarCantidad == 1)){
			require_once("../Base/gestionBD.php");
			require_once("../gestores/gestionarLineas.php");
			
			// CREAR LA CONEXIÓN A LA BASE DE DATOS
			$conexion = crearConexionBD();
			//Creamos
			
			if($opcion == "lote"){
				crear_linea_lote($conexion, $linea["OID_PEDIDO"], $linea["CANTIDAD"], $linea["OID_LOTE"]);
			}else{
				crear_linea_producto($conexion, $linea["OID_PEDIDO"], $linea["CANTIDAD"], $linea["OID_PRODUCTO"]);
			}
			
			// CERRAR LA CONEXIÓN
			cerrarConexionBD($conexion);
			// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
			// EN OTRO CASO, VOLVER A "CONSULTA_LINEAS.PHP"
			if(isset($_SESSION["excepcion"])){
				$_SESSION["destino"] = "consulta_lineas.php";
				header("Location: ../index.php?tituloPag=Excepcion");
			}else{
				header("Location: ../index.php?tituloPag=Farmacia");
			}
		}else{
			$_SESSION["excepcion"] = "Los entes introducidos deben de existir, si es una linea de proveedores debe coincidir 
				con pedido a proveedor y un lote del mismo, y si es una linea de producto, coincidir con un pedido a almacén";
			$_SESSION["destino"] = "../index.php";
			header("Location: ../index.php?tituloPag=Excepcion");
		}
	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: ../index.php"); 
		
	function validarLote($lote){
		include_once ("../validadores/validar_linea_lote.php");
		return $valido;
	}
	function validarProducto($producto){
		include_once ("../validadores/validar_linea_producto.php");
		return $valido;
	}
	function validarCantidad($cant){
		include_once ("../validadores/validar_linea_cantidad.php");
		return $valido;
	}
?>
