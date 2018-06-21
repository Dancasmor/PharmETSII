<?php	
	session_start();
	$pedidoUsuario['OID_PEDIDO_USUARIO'] = $_REQUEST['OID_PEDIDO_USUARIO'];
	$pedidoUsuario['DNI_USUARIO'] = $_REQUEST['DNI_USUARIO'];
	$pedidoUsuario['FECHA_SOLICITUD'] = $_REQUEST['FECHA_SOLICITUD'];
	$pedidoUsuario['PREPARADO'] = $_REQUEST['PREPARADO'];
	$pedidoUsuario['TARJETA'] = $_REQUEST['TARJETA'];
	$pedidoUsuario['nMuestra'] = $_REQUEST['nMuestra'];
	$pedidoUsuario['nPagina'] = $_REQUEST['nPagina'];
	
	if($_REQUEST['CONTRAREEMBOLSO_TARJETA'] == on){
		$pedidoUsuario['CONTRAREEMBOLSO_TARJETA'] = 1;
	}else{
		$pedidoUsuario['CONTRAREEMBOLSO_TARJETA'] = 0;
	};
	
	$_SESSION['pedidoUsuario'] = $pedidoUsuario;
	
	
	if (isset($_REQUEST["editar_pedidoUsuario"])) Header("Location: accion_modificar_pedidoUsuario.php"); 
		
	else if (isset($_REQUEST["borrar_pedidoUsuario"])) Header("Location: accion_borrar_pedidoUsuario.php");
	
	else if (isset($_REQUEST["crear_pedidoUsuario"])) Header("Location: accion_crear_pedidoUsuario.php");
	
	else Header("Location: consulta_pedidoUsuario.php");
	
?>
