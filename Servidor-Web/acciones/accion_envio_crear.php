<?php	
	session_start();	
	
	if (isset($_SESSION["opcion"])){
		
		$opcion = $_SESSION["opcion"];
		unset($_SESSION["opcion"]);
		$validarOID = 1;
		if($opcion == "proveedor"){
			$envio["OID_PROVEEDOR"] = $_SESSION["OID_PROVEEDOR"];
			unset($_SESSION["OID_PROVEEDOR"]);
			
		} else{
			$envio["OID_ALMACEN"] = $_SESSION["OID_ALMACEN"];
			unset($_SESSION["OID_ALMACEN"]);
			$validarOID = validarAlmacen($envio["OID_ALMACEN"]);
		}
		
		$envio["FECHA_ENVIO"] = $_SESSION["FECHA_ENVIO"];
		unset($_SESSION["FECHA_ENVIO"]);
		
		if(($validarOID == 1)){
			require_once("../Base/gestionBD.php");
			require_once("../gestores/gestionarEnvios.php");
			// CREAR LA CONEXIÓN A LA BASE DE DATOS
			$conexion = crearConexionBD();
			//Creamos
			if($opcion == "almacen_general"){
				crear_envio_almacen_general($conexion, $envio["OID_ALMACEN"], $envio["FECHA_ENVIO"]);
			}else{
				crear_envio_proveedor($conexion, $envio["OID_PROVEEDOR"], $envio["FECHA_ENVIO"]);
			}
			// CERRAR LA CONEXIÓN
			cerrarConexionBD($conexion);
			// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
			// EN OTRO CASO, VOLVER A "CONSULTA_ENVIOS.PHP"
			if(isset($_SESSION["excepcion"])){
				$_SESSION["destino"] = "../index.php";
				header("Location: ../index.php?tituloPag=Excepcion");
			}else{
				if($opcion == "almacen_general"){
					$empresa = $_SESSION["OID_EMPRESA"];
					header("Location: ../index.php?tituloPag=Pedidos&oidEmpresa=$empresa");
				} else{
				$pedido = $_SESSION["OID_PEDIDO"];
				header("Location: ../index.php?tituloPag=Perfil&idPedidoProveedor=$pedido");}
			}
			
			}else{
			$_SESSION["excepcion"] = "El almacén o proveedor deben de existir y la fecha debe ser posterior a hoy";
			$_SESSION["destino"] = "../index.php";
			header("Location: ../index.php?tituloPag=Excepcion");
		}
		
	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: ../index.php?tituloPag=Excepcion"); 


function validarAlmacen($almacen){
		include_once ("../validadores/validar_envio.php");
		return $valido;
	}
?>
