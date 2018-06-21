<?php	
	session_start();	
	
	if (isset($_SESSION["opcion"])){
		
		$opcion=$_SESSION["opcion"];
		unset($_SESSION["opcion"]);
		
		$empleado["DNI_EMPLEADO"] = $_SESSION["DNI_EMPLEADO"];
		$empleado["NOMBRE"] = $_SESSION["NOMBRE"];
		$empleado["APELLIDOS"] = $_SESSION["APELLIDOS"];
		$empleado["FECHA_NACIMIENTO"] = $_SESSION["FECHA_NACIMIENTO"];
		$empleado["OID_CONTACTO"] = $_SESSION["OID_CONTACTO"];
		$empleado["FECHA_ALTA_SISTEMA"] = $_SESSION["FECHA_ALTA_SISTEMA"];
		if($opcion=="empresa") {
			$empleado["OID_EMPRESA"] = $_SESSION["OID_EMPRESA"];
			$validarExisteEntidad=validarExisteEmpresa($empleado["OID_EMPRESA"]);
		}else{
			$empleado["OID_FARMACIA"] = $_SESSION["OID_FARMACIA"];
			$validarExisteEntidad=validarExisteFarmacia($empleado["OID_FARMACIA"]);
		}
		$empleado["CONTRASENYA"] = $_SESSION["CONTRASENYA"];
		$empleado["CONFIRMACION_CONTRASENYA"] = $_SESSION["CONFIRMACION_CONTRASENYA"];
		$empleado["CARGO"] = $_SESSION["CARGO"];	
		
		//Validacion en servidor
		$validarContactoDuplicado=validarContactoDuplicado($empleado["OID_CONTACTO"]);
		$validarExisteContacto=validarExisteContacto($empleado["OID_CONTACTO"]);
		$validarExisteDni=validarExisteDni($empleado["DNI_EMPLEADO"]);
		$validarDniEmpleado=validarDniEmpleado($empleado["DNI_EMPLEADO"]);
		$validarContraseña=validarContraseña($empleado["CONTRASENYA"],$empleado["CONFIRMACION_CONTRASENYA"]);
		$validarFechaNacimiento=validarFechaNacimiento($empleado["FECHA_NACIMIENTO"]);
		$validarFechaAltaSistema=validarFechaAltaSistema($empleado["FECHA_ALTA_SISTEMA"]);
		
		if(($validarContactoDuplicado==1) && ($validarExisteContacto==1) && ($validarExisteDni==1) && ($validarExisteEntidad==1)
			&& ($validarDniEmpleado==1) && ($validarContraseña==1) && ($validarFechaNacimiento==1)
			&& ($validarFechaAltaSistema==1)){
				
			require_once("../Base/gestionBD.php");
			require_once("../gestores/gestionarEmpleados.php");
		
			// CREAR LA CONEXIÓN A LA BASE DE DATOS
			$conexion = crearConexionBD();
			//Creamos
			if($opcion=="empresa"){
				crearEmpleadoEmpresa($conexion,$empleado["DNI_EMPLEADO"],$empleado["NOMBRE"],$empleado["APELLIDOS"],$empleado["FECHA_NACIMIENTO"],
							    $empleado["OID_CONTACTO"],$empleado["FECHA_ALTA_SISTEMA"],$empleado["OID_EMPRESA"],
								$empleado["CONTRASENYA"],$empleado["CARGO"]);
			}else{
				crearEmpleadoFarmacia($conexion,$empleado["DNI_EMPLEADO"],$empleado["NOMBRE"],$empleado["APELLIDOS"],$empleado["FECHA_NACIMIENTO"],
							    $empleado["OID_CONTACTO"],$empleado["FECHA_ALTA_SISTEMA"],$empleado["OID_FARMACIA"],
								$empleado["CONTRASENYA"],$empleado["CARGO"]);
			}
		
			// CERRAR LA CONEXIÓN
		
			cerrarConexionBD($conexion);
			// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
			// EN OTRO CASO, VOLVER A "CONSULTA_EMPLEADOS.PHP"
			if(isset($_SESSION["excepcion"])){
				$_SESSION["destino"] = "../index.php";
				header("Location: ../index.php?tituloPag=Excepcion");
			}else{
				header("Location: ../index.php?tituloPag=RegistroEmpleados");
			}									
		}else{
			$_SESSION["excepcion"] = "Las parametros tienen que estar asociados a entidades existentes, al igual que deben cumplirse una serie de restricciones para cada uno de los campos.";
			$_SESSION["destino"] = "../index.php";
			header("Location: ../index.php?tituloPag=Excepcion");
		}			
	}else  
		header("Location: ../index.php?tituloPag=Excepcion");
	
	function validarExisteContacto($oidContacto){
		include_once ("../validadores/validar_existe_contacto.php");
		return $valido;
	}
	function validarContactoDuplicado($oidContacto){
		include_once ("../validadores/validar_contacto_empleado.php");
		return $valido;
	}
	function validarExisteDni($dniEmpleado){
		include_once ("../validadores/validar_existe_dni.php");
		return $valido;
	}
	function validarExisteEmpresa($oidEmpresa){
		include_once ("../validadores/validar_empresa_empleado.php");
		return $valido;
	}
	function validarExisteFarmacia($oidFarmacia){
		include_once ("../validadores/validar_farmacia_empleado.php");
		return $valido;
	}
	function validarFechaAltaSistema($fecha){
		$fechaAltaSistema = date_create_from_format('Y-m-d', $fecha);
		$fechaAltaSistema = date_format($fechaAltaSistema, 'Y-m-d');
		if($fechaAltaSistema == date('Y-m-d')){
			return (int)1;
		}else{
			return (int)0;
		}
	}
	function validarFechaNacimiento($fecha){
		$fechaNacimiento = date_create_from_format('Y-m-d', $fecha);
		$fechaNacimiento = date_format($fechaNacimiento, 'Y-m-d');
		if($fechaNacimiento < date('Y-m-d')){
			return (int)1;
		}else{
			return (int)0;
		}
	}
	function validarContraseña($pass,$confirmpass){
		if((!preg_match("/[a-z]+/", $pass)) || (!preg_match("/[A-Z]+/", $pass)) || !preg_match("/[0-9]+/", $pass)){
				return (int) 0;
		}else if($pass!=$confirmpass){
				return (int) 0;
		}else{
			return (int) 1;
		}
	}
	/*
	function validarDniEmpleado($dniEmpleado){
		$letra = substr($dniEmpleado, -1);
		$numeros = substr($dniEmpleado, 0, -1);
		if(preg_match("/^[0-9]{8}[A-Z]$/",$dniEmpleado)){
			return (int) 1;
		}else if(substr("TRWAGMYFPDXBNJZSQVHLCKE", $numeros%23, 1) == $letra && strlen($letra) == 1 && strlen ($numeros) == 8){
			return (int) 1;
		}else{
			return (int) 0;
		}		
	}
	 */
	 function validarDniEmpleado($dniEmpleado){
		$letra = substr($dniEmpleado, -1);
		$numeros = substr($dniEmpleado, 0, -1);
		if ( substr("TRWAGMYFPDXBNJZSQVHLCKE", $numeros%23, 1) == $letra && strlen($letra) == 1 && strlen ($numeros) == 8 ){
			return (int) 1;
		}else{
			return (int) 0;
		}
	}	
	
?>
