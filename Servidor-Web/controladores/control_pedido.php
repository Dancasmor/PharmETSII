<?php
	session_start();
	require_once('../gestores/funciones_catalogo.php');
	require_once('../base/gestionBD.php');
	require_once('../gestores/gestionarPedidoUsuario.php');
	require_once('../gestores/gestionarBolsa.php');
	
	$bols['OID_PRODUCTO']=$_REQUEST['OID_PRODUCTO'];
	$bols['CANTIDAD']=$_REQUEST['CANTIDAD'];
	$_SESSION['oid_muestra']=$_REQUEST['OID_PEDIDO_USUARIO'];
	
	if(isset($_REQUEST['CONTRAREEMBOLSO_TARJETA'])){
		$bols['CONTRAREEMBOLSO_TARJETA']=1;
	}else{$bols['CONTRAREEMBOLSO_TARJETA']=0;}
	
	if(isset($_REQUEST['TARJETA'])){
		$bols['TARJETA']=$_REQUEST['TARJETA'];
	}else{$bols['TARJETA']=0;}
	
	$bolsas=$_SESSION['bolsas'];
	$usuario=$_SESSION['usuario'];
	
	if(isset($_REQUEST['eliminar_bolsa'])){
		$max=cuenta2($bolsas);
		$bolsasR = actualizaClaves($bolsas);
		for($i=0;$i<$max;$i++){
			if($bolsasR[$i]==$bols['OID_PRODUCTO']){
				unset($bolsasR[$i]);
				
			};
		}
		$_SESSION['bolsas']=$bolsasR;
		Header("Location: ../index.php?tituloPag=Pedidos usuario");
	}else if(isset($_REQUEST['cambiar_bolsa'])){
		$bolsas=actualizarProductoHastaCantidad($bolsas, $bols['OID_PRODUCTO'], $bols['CANTIDAD']);
		$_SESSION['bolsas']=$bolsas;
		Header("Location: ../index.php?tituloPag=Pedidos usuario");
	};
	
	if(isset($_REQUEST['boton_desplegar'])){
		Header("Location: ../index.php?tituloPag=Bolsas del pedido");
	}
	
	if(isset($_REQUEST['realizar_pedido'])){
		$conexion = crearConexionBD();
		
		$hoy=date('Y-m-d');
		if(isset($usuario['DNI_USUARIO'])){
			crearPedidoUsuario($conexion, $usuario['DNI_USUARIO'], $hoy, $bols['CONTRAREEMBOLSO_TARJETA'], $bols['TARJETA']);
		}elseif(isset($usuario['DNI_EMPLEADO'])){
			crearPedidoUsuario($conexion, $usuario['DNI_EMPLEADO'], $hoy, $bols['CONTRAREEMBOLSO_TARJETA'], $bols['TARJETA']);
		}
		$bolsas2=depuraProductos($bolsas);
		if(isset($usuario['DNI_USUARIO'])){
			foreach($bolsas2 as $obj){
				echo(consultarMaxOIDpedido($conexion,$usuario['DNI_USUARIO']));
				echo(crearBolsa($conexion, $obj, consultarMaxOIDpedido($conexion,$usuario['DNI_USUARIO']), cuentaProducto($bolsas,$obj)));
			}
			unset($_SESSION['bolsas']);
			Header("Location: ../index.php?tituloPag=Pedidos usuario");
			
		}elseif(isset($usuario['DNI_EMPLEADO'])){
			foreach($bolsas2 as $obj){
				crearBolsa($conexion, $obj, consultarMaxOIDpedido($conexion,$usuario['DNI_EMPLEADO']), cuentaProducto($bolsas,$obj));
			}
			unset($_SESSION['bolsas']);
			Header("Location: ../index.php?tituloPag=Pedidos usuario");
		}
	
		cerrarConexionBD($conexion);
		
	}
	
	


?>