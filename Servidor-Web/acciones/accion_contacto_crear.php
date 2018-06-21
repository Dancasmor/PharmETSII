<?php
session_start();

$contacto["TELEFONO"] = $_SESSION["TELEFONO"];
$contacto["EMAIL"] = $_SESSION["EMAIL"];
$contacto["DIRECCION"] = $_SESSION["DIRECCION"];
$contacto["CODIGO_POSTAL"] = $_SESSION["CODIGO_POSTAL"];
$contacto["CIUDAD"] = $_SESSION["CIUDAD"];

unset($_SESSION["TELEFONO"]);
unset($_SESSION["EMAIL"]);
unset($_SESSION["DIRECCION"]);
unset($_SESSION["CODIGO_POSTAL"]);
unset($_SESSION["CIUDAD"]);

$validarEmail = validateEmail($contacto["EMAIL"]);

if($validarEmail == 0){
	$_SESSION["excepcion"] = "El email es incorrecto";
	$_SESSION["destino"] = "consulta_contacto.php";
	header("Location: excepcion.php");
} else{
	require_once ("gestionBD.php");
	require_once ("gestionarContacto.php");
	$conexion = crearConexionBD();
	crear_contacto($conexion, $contacto["TELEFONO"], $contacto["EMAIL"], $contacto["DIRECCION"], $contacto["CODIGO_POSTAL"], $contacto["CIUDAD"]);
	cerrarConexionBD($conexion);
	if (isset($_SESSION["excepcion"])) {
		$_SESSION["destino"] = "consulta_contacto.php";
		header("Location: excepcion.php");
	} else {
		header("Location: consulta_contacto.php");
	}
}

function validateEmail($email) {
  	$res = '/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/';
	if (!filter_var($email, $res)) {
		return (int)0;
	} else {
		return (int)1;
	}
}
?>
