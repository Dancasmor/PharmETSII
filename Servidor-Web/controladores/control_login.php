<?php
	require_once("../Base/gestionBD.php");
	require_once("../gestores/funciones_login.php");
	
	session_start();
	
	$usr=$_REQUEST['usuario_login'];
	$cntr=$_REQUEST['contraseña_login'];
	
	$conexion = crearConexionBD();
	
	$estado = comprobarLogin($conexion, $usr, $cntr);
	
	
	if($estado=="0"||$estado=="1"){

	}else if($estado == "usuario"){
		$login=1;
		rescataUSUARIO($conexion, $usr);
	}else if($estado == "proveedor"){
		$login=1;
		rescataPROVEEDOR($conexion, $usr);
	}else if($estado == "empleado"){
		$login=1;
		rescataEMPLEADO($conexion, $usr);
	}
	
	cerrarConexionBD($conexion);
	
	$_SESSION['login']=$login;

	header("Location: ../index.php");
	
?>