<?php
	/*=============================================================================
     	Fichero con las funciones de gestión de bolsas de la capa de acceso a datos 		
     ==============================================================================*/

	function consultarTodasBolsas($conexion){
		$consulta = "SELECT * FROM BOLSA ORDER BY OID_PEDIDO_USUARIO";
		return $conexion->query($consulta);
	}
	
	function consultarBolsasPedido($conexion,$oid_pedido_usuario){
		$consulta = "SELECT * FROM BOLSA WHERE OID_PEDIDO_USUARIO=".$oid_pedido_usuario
					." ORDER BY OID_BOLSA";
		return $conexion->query($consulta);
	}
	
	function consultarBolsasDNI($conexion,$dni){
		$consulta = "SELECT * FROM PEDIDO_USUARIO WHERE OID_PEDIDO_USUARIO=".$oid_pedido_usuario
					." ORDER BY OID_BOLSA";
		return $conexion->query($consulta);
	}
	function quitarBolsa($conexion, $oid_bolsa){
		try{
			$stmt=$conexion->prepare('CALL ELIMINAR_BOLSA(:oid_bolsa)');
			$stmt->bindParam(':oid_bolsa', $oid_bolsa);
			$stmt->execute();
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	function cambiarCantidadBolsa($conexion, $oid_bolsa, $cantidad){
		try{
			$stmt=$conexion->prepare('CALL CAMBIAR_CANTIDAD_BOLSA(:oid_bolsa,:cantidad)');
			$stmt->bindParam(':oid_bolsa', $oid_bolsa);
			$stmt->bindParam(':cantidad', $cantidad);
			$stmt->execute();
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	function crearBolsa($conexion, $oid_producto, $oid_pedido_usuario, $cantidad){
		try{
			$stmt=$conexion->prepare('INSERT INTO BOLSA (oid_bolsa,oid_pedido_usuario,oid_producto,cantidad) VALUES (0,:oid_pedido_usuario,:oid_producto,:cantidad)');
			$stmt->bindParam(':oid_pedido_usuario', $oid_pedido_usuario);
			$stmt->bindParam(':cantidad', $cantidad);
			$stmt->bindParam(':oid_producto', $oid_producto);
			$stmt->execute();
			return "bolsa creada";
		}catch(PDOException $e){
			return $e->getMessage();
		}	
	}
	//VALIDACIONES
	function comprueba_oidPedidoUsuario($conexion, $oid_pedido_usuario){
		$consulta = "SELECT COUNT(*) FROM BOLSA WHERE oid_pedido_usuario = ".$oid_pedido_usuario;
		return $conexion->query($consulta)->fetch()[0];
	}
	
	function comprueba_oidProducto($conexion, $oid_producto){
		$consulta = "SELECT COUNT(*) FROM BOLSA WHERE oid_producto= ".$oid_producto;
		return $conexion->query($consulta)->fetch()[0];
	}
	
?>
