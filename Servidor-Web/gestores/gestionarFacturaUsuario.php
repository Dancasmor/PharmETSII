<?php
	/*=============================================================================
     	Fichero con las funciones de gestión de bolsas de la capa de acceso a datos 		
     ==============================================================================*/

	function consultarTodasFacturaUsuario($conexion){
		$consulta = "SELECT * FROM FACTURA_USUARIO ORDER BY OID_FACTURA_USUARIO";
		return $conexion->query($consulta);
	}
	function consultarFacturaUsuario($conexion,$oid_factura_usuario){
		$consulta = "SELECT * FROM FACTURA_USUARIO WHERE OID_FACTURA_USUARIO=".$oid_factura_usuario
					." ORDER BY OID_FACTURA_USUARIO";
		return $conexion->query($consulta);
	}
	function consultarFacturaUsuarioDNI($conexion,$dni){
		$consulta="select * from factura_usuario where dni_usuario= '".$dni."'";
		return $conexion->query($consulta);
	}
	function quitarFacturaUsuario($conexion, $oid_factura_usuario){
		try{
			$stmt=$conexion->prepare('CALL ELIMINAR_FACTURA_USUARIO(:oid_factura_usuario)');
			$stmt->bindParam(':oid_factura_usuario', $oid_factura_usuario);
			$stmt->execute();
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	function crearFacturaUsuario($conexion, $oid_pedido_usuario, $fecha_venta, $oid_almacen){
		try{
			$formato = "'YYYY-MM-DD'";
			$consulta = "CALL CREAR_FACTURA_USUARIO('".$oid_pedido_usuario."', ". "TO_DATE('".$fecha_venta."', "."'YYYY-MM-DD'"."),'".$oid_almacen."')";
			$conexion->query($consulta);
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}	
	}
	
	function setFacturaEnviado($conexion, $oid_factura_usuario){
		try{
			$stmt=$conexion->prepare('CALL SET_ENVIADO(:oid_factura_usuario,1)');
			$stmt->bindParam(':oid_factura_usuario', $oid_factura_usuario);
			$stmt->execute();
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	
?>
