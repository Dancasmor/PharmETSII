<?php 
	session_start();
	require_once('../gestores/funciones_catalogo.php');
	$paginar['nMuestra'] = $_REQUEST['nMuestra'];
	$paginar['nPagina'] = $_REQUEST['nPagina'];
	$_SESSION['paginar'] = $paginar;
	
	/*Codigo para el control de las bolsas*/
		
	//SI NO HAY BOLSA LA CREA
	if(!isset($_SESSION['bolsas'])){
		$bolsas=array();
		$_SESSION['bolsas']= $bolsas;
	}
	
	if(isset($_REQUEST['OID_PRODUCTO'])&& isset($_REQUEST['añadir_catalogo'])){
		
		$product = $_REQUEST['OID_PRODUCTO'];
		$bolsas=$_SESSION['bolsas'];
		array_push($bolsas,$product);
		$_SESSION['bolsas']= $bolsas;
	}
	
	if(isset($_REQUEST['editar_producto'])){		
		$_SESSION["OID_PRODUCTO"] = $_REQUEST["OID_PRODUCTO"];
		$_SESSION["NOMBRE"] = $_REQUEST["NOMBRE"];
		$_SESSION["PRECIO_VENTA"] = $_REQUEST["PRECIO_VENTA"];
		$_SESSION["PUNTOS"] = $_REQUEST["PUNTOS"];
		$_SESSION["RECETA"] = $_REQUEST["RECETA"];
		
		$_SESSION["modificar"] = "modificar";
		Header("Location: ../index.php?tituloPag=Administrar productos");
	}
	else if(isset($_REQUEST['modificar'])){
		$_SESSION["OID_PRODUCTO"] = $_REQUEST["OID_PRODUCTO"];
		$_SESSION["NOMBRE"] = $_REQUEST["NOMBRE"];
		$_SESSION["PRECIO_VENTA"] = $_REQUEST["PRECIO_VENTA"];
		$_SESSION["PUNTOS"] = $_REQUEST["PUNTOS"];
		$_SESSION["RECETA"] = $_REQUEST["RECETA"];
		Header("Location: ../acciones/accion_producto_modificar.php");
	}
	else if(isset($_REQUEST['busqueda_producto'])){
		$_SESSION['buscar']=$_REQUEST['busqueda_producto'];
		Header("Location: ../index.php?tituloPag=Catalogo");
	}else{
		Header("Location: ../index.php?tituloPag=Catalogo");
	}
	



?>