<?php
	/*=============================================================================
     	Fichero con las funciones de gestión de bolsas de la capa de acceso a datos 		
     ==============================================================================*/

	function consultarTodosPedidosUsuario($conexion){
		$consulta = "SELECT * FROM PEDIDO_USUARIO ORDER BY OID_PEDIDO_USUARIO";
		return $conexion->query($consulta);
	}
	function consultarPedido($conexion,$oid_pedido_usuario){
		$consulta = "SELECT * FROM PEDIDO_USUARIO WHERE OID_PEDIDO_USUARIO= :oid_pedido_usuario";
		return $conexion->query($consulta);
	}
	function consultarPedidosUsuarioDNI($conexion,$dni){
		$consulta = "SELECT * FROM PEDIDO_USUARIO WHERE DNI_USUARIO='".$dni."'"."ORDER BY FECHA_SOLICITUD DESC";
		return $conexion->query($consulta);
	}
	 
	function consultarMaxOIDpedido($conexion,$dni){
		$consulta = "SELECT max(TO_NUMBER(OID_PEDIDO_USUARIO)) FROM PEDIDO_USUARIO WHERE DNI_USUARIO='".$dni."' ORDER BY FECHA_SOLICITUD DESC";
		RETURN $pedidos=$conexion->query($consulta)->fetch()[0];
	}
	
	function existenBolsas($conexion,$oid_pedido_usuario){
		$consulta = "SELECT COUNT(*) FROM BOLSA WHERE OID_PEDIDO_USUARIO='".$oid_pedido_usuario."'";
		return !$conexion->query($consulta)->fetch()[0]>0;
	}
	
	function borrarPedidoUsuario($conexion, $oid_pedido_usuario){
		try{
			$stmt=$conexion->prepare('CALL ELIMINAR_PEDIDO_USUARIO(:oid_pedido_usuario)');
			$stmt->bindParam(':oid_pedido_usuario', $oid_pedido_usuario);
			$stmt->execute();
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	function setPedidoPreparado($conexion, $oid_pedido_usuario){
		try{
			$stmt=$conexion->prepare('CALL SET_PREPARADO(:oid_pedido_usuario,1)');
			$stmt->bindParam(':oid_pedido_usuario', $oid_pedido_usuario);
			$stmt->execute();
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	
	function crearPedidoUsuario($conexion, $dni_usuario, $fecha_solicitud, $contrareembolso_tarjeta, $tarjeta){
		try{
			$formato = "'YYYY-MM-DD'";
			$consulta = "CALL CREAR_PEDIDO_USUARIO('".$dni_usuario."', ". "TO_DATE('".$fecha_solicitud."', "."'YYYY-MM-DD'"."),'".$contrareembolso_tarjeta."','".$tarjeta."')";
			$conexion->query($consulta);
		}catch(PDOException $e){
			return $e->getMessage();
		}	
	}
	
	function comprueba_dni($conexion,$dni){
		$consulta = "SELECT COUNT(*) FROM USUARIO WHERE dni_usuario = '".$dni."'";
		return $conexion->query($consulta)->fetch()[0];
	}
?>
