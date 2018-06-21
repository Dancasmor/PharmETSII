<?php	
	session_start();	
	
	if (isset($_SESSION["OID_SECCION"])){
		$seccion = $_SESSION["OID_SECCION"];
		unset($_SESSION["OID_SECCION"]);
		
		require_once("../Base/gestionBD.php");
		require_once("../gestores/gestionarSeccion.php");

		$conexion = crearConexionBD();
		$excepcion = borrar_seccion($conexion, $seccion);
		cerrarConexionBD($conexion);
		
		if($excepcion <> ""){
			$_SESSION["excepcion"] = $excepcion;
			$_SESSION["destino"] = "../index.php";
			header("Location: ../index.php?tituloPag=Excepcion");
		}else{
			if(isset($_SESSION["OID_EMPRESA"])){
			$empresa = $_SESSION["OID_EMPRESA"];
			unset($_SESSION["OID_EMPRESA"]);
			header("Location: ../index.php?tituloPag=Almacen&oidEmpresa=$empresa");
		} else{
			$farmacia = $_SESSION["OID_FARMACIA"];
			unset($_SESSION["OID_FARMACIA"]);
			header("Location: ../index.php?tituloPag=Almacen&oidFarmacia=$farmacia");
		}
		}
	}
	else
		Header("Location: ../index.php"); 
?>
