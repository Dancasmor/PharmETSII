<?php
	/*=============================================================================
     	Fichero con las funciones de gestión de bolsas de la capa de acceso a datos 		
     ==============================================================================*/

	function consultarTodosLotes($conexion){
		$consulta = "SELECT * FROM LOTE ORDER BY OID_LOTE";
		return $conexion->query($consulta);
	}
	function consultarLotesProducto($conexion,$oid_producto){
		$consulta = "CALL VER_LOTES_PROVEEDOR(".$oid_producto.")";
		return $conexion->query($consulta);
	}
	function quitarLote($conexion, $oid_lote){
		try{
			$stmt=$conexion->prepare('CALL DELETE_LOTE(:oid_lote)');
			$stmt->bindParam(':oid_lote', $oid_lote);
			$stmt->execute();
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	function cambiarCantidadPrecioLote($conexion, $oid_lote, $cantidad, $precio){
		try{
			$stmt=$conexion->prepare('CALL CAMBIAR_CANTIDADPRECIO_LOTE(:oid_lote,:cantidad, :precio)');
			$stmt->bindParam(':oid_lote', $oid_lote);
			$stmt->bindParam(':cantidad', $cantidad);
			$stmt->bindParam(':precio', $precio);
			$stmt->execute();
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	function crearLote($conexion, $cantidad, $precio, $proveedor, $producto){
		try{
			$stmt=$conexion->prepare('CALL NEW_LOTE(:cantidad,:precio,:proveedor,:producto)');
			$stmt->bindParam(':precio', $precio);
			$stmt->bindParam(':cantidad', $cantidad);
			$stmt->bindParam(':producto', $producto);
			$stmt->bindParam(':proveedor', $proveedor);
			$stmt->execute();
			return"";
		}catch(PDOException $e){
			return $e->getMessage();
		}	
	}
?>
