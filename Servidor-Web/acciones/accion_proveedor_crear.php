<?php	
	session_start();	
				
		$proveedor["NOMBRE_LAB"] = $_SESSION["NOMBRE_LAB"];
		$proveedor["PRECIO_ENVIO_SIN_GASTOS"] = $_SESSION["PRECIO_ENVIO_SIN_GASTOS"];
		$proveedor["OID_CONTACTO"] = $_SESSION["OID_CONTACTO"];
		$proveedor["CONTRASEÑA"] = $_SESSION["CONTRASEÑA"];
		$proveedor["CONFIRMACION_CONTRASEÑA"] = $_SESSION["CONFIRMACION_CONTRASEÑA"];
		
		//Validacion en servidor
		$validarNombreProveedor=validarNombreProveedor($proveedor["NOMBRE_LAB"]);
		$validarExisteContactoProveedor=validarExisteContactoProveedor($proveedor["OID_CONTACTO"]);
		$validarContactoDuplicadoProveedor=validarContactoDuplicadoProveedor($proveedor["OID_CONTACTO"]);
		$validarContraseñaProveedor=validarContraseñaProveedor($proveedor["CONTRASEÑA"],$proveedor["CONFIRMACION_CONTRASEÑA"]);
		
		if(($validarNombreProveedor==1) && ($validarExisteContactoProveedor==1) && ($validarContactoDuplicadoProveedor==1) 
			&& ($validarContraseñaProveedor==1)){
					
			require_once("../Base/gestionBD.php");
			require_once("../gestores/gestionarProveedores.php");
		
			// CREAR LA CONEXIÓN A LA BASE DE DATOS
			$conexion = crearConexionBD();
			//Creamos		
			crearProveedor($conexion,$proveedor["NOMBRE_LAB"],$proveedor["PRECIO_ENVIO_SIN_GASTOS"],$proveedor["OID_CONTACTO"], 
					  $proveedor["CONTRASEÑA"]);
			
			// CERRAR LA CONEXIÓN
			cerrarConexionBD($conexion);
			// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
			// EN OTRO CASO, VOLVER A "CONSULTA_PROVEEDORES.PHP"
			if(isset($_SESSION["excepcion"])){
				$_SESSION["destino"] = "../index.php";
				header("Location: ../index.php?tituloPag=Excepcion");
			}else{
				header("Location: ../index.php?tituloPag=RegistroProveedores");
			}
		}else{
			$_SESSION["excepcion"] = "Las parametros tienen que estar asociados a entidades existentes, al igual que deben cumplirse una serie de restricciones para cada uno de los campos.";
			$_SESSION["destino"] = "../index.php";
			header("Location: ../index.php?tituloPag=Excepcion");
		}		
	
	function validarNombreProveedor($nombreLab){
		include_once ("../validadores/validar_nombre_proveedor.php");
		return $valido;
	}
	function validarExisteContactoProveedor($oidContacto){
		include_once ("../validadores/validar_existe_contacto_proveedor.php");
		return $valido;
	}
	function validarContactoDuplicadoProveedor($oidContacto){
		include_once ("../validadores/validar_contacto_proveedor.php");
		return $valido;
	}
	function validarContraseñaProveedor($pass,$confirmpass){
		if((!preg_match("/[a-z]+/", $pass)) || (!preg_match("/[A-Z]+/", $pass)) || !preg_match("/[0-9]+/", $pass)){
				return (int) 0;
		}else if($pass!=$confirmpass){
				return (int) 0;
		}else{
			return (int) 1;
		}
	}	
?>
