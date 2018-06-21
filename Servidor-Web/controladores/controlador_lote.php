<?php	
	session_start();
	$lote['OID_LOTE'] = $_REQUEST['OID_LOTE'];
	$lote['CANTIDAD_LOTE'] = $_REQUEST['CANTIDAD_LOTE'];
	$lote['PRECIO_LOTE'] = $_REQUEST['PRECIO_LOTE'];
	$lote['OID_PROVEEDOR'] = $_REQUEST['OID_PROVEEDOR'];
	$lote['OID_PRODUCTO'] = $_REQUEST['OID_PRODUCTO'];
	$lote['nMuestra'] = $_REQUEST['nMuestra'];
	$lote['nPagina'] = $_REQUEST['nPagina'];
	$_SESSION['lote'] = $lote;
		
	if (isset($_REQUEST["crear_lote"])) Header("Location: ../acciones/accion_crear_lote.php");
	
	else Header("Location: ../index.php");
	
?>
