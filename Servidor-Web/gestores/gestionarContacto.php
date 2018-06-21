<?php
     
function consultarTodosContactos() {
	$consulta = "SELECT * FROM CONTACTO";
    return $consulta;
}

function consultarContactoPorOID($conexion, $oidContacto) {
	try {	
		$consulta = "SELECT * FROM CONTACTO WHERE OID_CONTACTO = ".$oidContacto;
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function crear_contacto($conexion, $telefono, $email, $direccion, $codigoPostal, $ciudad) {
	try {	
		$consulta = "INSERT INTO contacto(telefono, email, direccion, codigo_postal, ciudad) 
		VALUES('". $telefono ."','". $email ."','". $direccion ."','". $codigoPostal ."','". $ciudad ."')";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function borrar_contacto($conexion, $oidContacto) {
	try {
		$stmt=$conexion->prepare('DELETE FROM contacto WHERE OID_contacto = :oidContacto');
		$stmt->bindParam(':oidContacto',$oidContacto);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

?>