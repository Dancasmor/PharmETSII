<?php
     
function consultarTodosProductos($conexion) {
	$consulta = "select * from producto";
	return $conexion->query($consulta);
}

function consultarProductoPorOID($conexion, $oidProducto) {
	try {	
		$consulta = "SELECT * FROM PRODUCTO WHERE OID_PRODUCTO = ".$oidProducto;
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function crear_producto($conexion, $nom, $url, $precio, $puntos, $receta) {
	try {
		$url = "./images/productos/" . $url;
		$consulta = "INSERT INTO producto(nombre, url_imagenes, precio_venta, puntos, receta) 
		VALUES('". $nom ."','". $url ."','". $precio ."','". $puntos ."','". $receta ."')";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function modificar_producto($conexion, $oid ,$nom, $precio, $puntos, $receta) {
	try {
		
		$consulta = "UPDATE producto SET nombre = '". $nom ."' where oid_producto =".$oid;
		$consulta1 = "UPDATE producto SET precio_venta = ". $precio ." where oid_producto =".$oid;
		$consulta2 = "UPDATE producto SET puntos = ". $puntos ." where oid_producto =".$oid;
		$consulta3 = "UPDATE producto SET receta = ". $receta." where oid_producto =".$oid;
		$conexion->query($consulta);
		$conexion->query($consulta1);
		$conexion->query($consulta2);
		$conexion->query($consulta3);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function borrar_producto($conexion, $oidProducto) {
	try {
		$stmt=$conexion->prepare('DELETE FROM producto WHERE OID_PRODUCTO = :oidProducto');
		$stmt->bindParam(':oidProducto',$oidProducto);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

?>