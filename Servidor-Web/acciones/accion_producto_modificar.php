<?php

session_start();
if(isset($_SESSION["NOMBRE"])){
	$producto["OID_PRODUCTO"] = $_SESSION["OID_PRODUCTO"];
	$producto["NOMBRE"] = $_SESSION["NOMBRE"];
	$producto["PRECIO_VENTA"] = $_SESSION["PRECIO_VENTA"];
	$producto["PUNTOS"] = $_SESSION["PUNTOS"];
	$producto["RECETA"] = $_SESSION["RECETA"];
	
	unset($_SESSION["OID_PRODUCTO"]);
	unset($_SESSION["NOMBRE"]);
	unset($_SESSION["PRECIO_VENTA"]);
	unset($_SESSION["PUNTOS"]);
	unset($_SESSION["RECETA"]);
	
	require_once ("../Base/gestionBD.php");
	require_once ("../gestores/gestionarProducto.php");
	
	$conexion = crearConexionBD();
	modificar_producto($conexion, $producto["OID_PRODUCTO"], $producto["NOMBRE"], $producto["PRECIO_VENTA"], $producto["PUNTOS"], $producto["RECETA"]);
	
	cerrarConexionBD($conexion);
	if (isset($_SESSION["excepcion"])) {
		$_SESSION["destino"] = "../index.php";
		header("Location: ../index.php?tituloPag=Excepcion");
	} else {
		header("Location: ../index.php?tituloPag=Catalogo");
	}
}else{
	header("Location: ../index.php");
}
?>
