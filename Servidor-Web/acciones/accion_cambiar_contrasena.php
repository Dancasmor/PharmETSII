<?php	
	session_start();	
	
	if (isset($_SESSION["usuario"])) {
		$usuario=$_SESSION["usuario"];
		$contraseña=$_REQUEST["CONTRASEÑA"];
		$confirmacionContraseña=$_REQUEST["CONFIRMACION_CONTRASEÑA"];
		
		$validarContraseña=validarContraseña($contraseña,$confirmacionContraseña);
		
		if($validarContraseña==1){
			
			require_once("../Base/gestionBD.php");
			require_once("../gestores/gestionarUsuario.php");
			require_once("../gestores/gestionarEmpleados.php");
			require_once("../gestores/gestionarProveedores.php");
			
			$conexion = crearConexionBD();
			
			if($usuario["nivel"]==1){
				cambiarContraseñaUsuario($conexion, $usuario["DNI_USUARIO"], $_REQUEST["CONTRASEÑA"]);
			}else if($usuario["nivel"]==2){
				cambiarContraseñaProveedor($conexion, $usuario["NOMBRE_LAB"], $_REQUEST["CONTRASEÑA"]);
			}else if($usuario["nivel"]==3){
				cambiarContraseñaEmpleado($conexion, $usuario["DNI_EMPLEADO"], $_REQUEST["CONTRASEÑA"]);		
			}
			
			cerrarConexionBD($conexion);
			if(isset($_SESSION["excepcion"])){
				$_SESSION["destino"] = "../index.php";
				header("Location: ../index.php?tituloPag=Excepcion");
			}else{
				header("Location: ../index.php?tituloPag=Contrasena");
			}
		} else { 
			$_SESSION["excepcion"] = "La contraseña tiene que cumplir con los requisitos solicitados y la confirmación debe coincidir con la misma.";
			$_SESSION["destino"] = "../index.php";
			header("Location: ../index.php?tituloPag=Excepcion"); 
		}
	}else{
		Header("Location: ../index.php"); 
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
?>