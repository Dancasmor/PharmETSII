<?php
session_start();

$seccion["OID_ALMACEN"] = $_SESSION["OID_ALMACEN"];
$seccion["OID_PRODUCTO"] = $_SESSION["OID_PRODUCTO"];

unset($_SESSION["OID_ALMACEN"]);
unset($_SESSION["OID_PRODUCTO"]);

$validarAlmacen = validateAlmacen($seccion["OID_ALMACEN"]);
$validarProducto = validateProducto($seccion["OID_PRODUCTO"]);

if($validarAlmacen == 0 || $validarProducto == 0){
	$_SESSION["excepcion"] = "El almacén y/o producto no existe";
	$_SESSION["destino"] = "../index.php";
	header("Location: ../index.php?tituloPag=Excepcion");
} else{
	require_once ("../Base/gestionBD.php");
	require_once ("../gestores/gestionarSeccion.php");
	$conexion = crearConexionBD();
	crear_seccion($conexion, $seccion["OID_ALMACEN"], $seccion["OID_PRODUCTO"]);
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
}

function validateAlmacen($oid){
	include_once ("../validadores/validar_seccion_oidAlmacen.php");
	return $valido;
}

function validateProducto($oid){
	include_once ("../validadores/validar_seccion_oidProducto.php");
	return $valido;
}
?>
