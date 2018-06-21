<?php
session_start();
$opcion = $_SESSION["opcion"];
$seccion["OID_SECCION"] = $_SESSION["OID_SECCION"];
$seccion["cantidad"] = $_SESSION["cantidad"];

unset($_SESSION["opcion"]);
unset($_SESSION["OID_SECCION"]);
unset($_SESSION["cantidad"]);


	require_once ("../Base/gestionBD.php");
	require_once ("../gestores/gestionarSeccion.php");
	$conexion = crearConexionBD();
	if($opcion == "añadir"){
		añadir_cantidad_seccion($conexion, $seccion["OID_SECCION"], $seccion["cantidad"]);
	}else{
		restar_cantidad_seccion($conexion, $seccion["OID_SECCION"], $seccion["cantidad"]);
	}
	
	cerrarConexionBD($conexion);
	
	if (isset($_SESSION["excepcion"])) {
		$_SESSION["destino"] = "../index.php";
		header("Location: ../index.php?tituloPag=Excepcion");
	} else {
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

?>
