<?php
function cambiarContraseñaUsuario($conexion,$dniUsuario,$contraseña){
	try {
		$stmt=$conexion->prepare("update usuario set contrasenya= '".$contraseña."where dni_usuario= '".$dniUsuario);
		$stmt->execute();
	}catch(PDOException $e) {
		return $e->getMessage();
	}	
}  
function consultarTodosUsuarios() {
	$consulta = "SELECT * FROM USUARIO";
    return $consulta;
}

function consultarUsuarioPorDNI($conexion, $dniUsuario) {
	try {	
		$consulta = "SELECT * FROM USUARIO WHERE DNI_USUARIO = '". $dniUsuario ."'";
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function crear_usuario($conexion, $dni, $nom, $ape, $fec_nac, $contacto, $fec_alt, $empresa, $pass, $puntos, $peso, $altura) {
	try {
		$formato = "'yyyy-MM-dd'";	
		$consulta = "INSERT INTO usuario(dni_usuario, nombre, apellidos, fecha_nacimiento, oid_contacto, fecha_alta_sistema, oid_empresa, contrasenya, puntos, peso, altura) 
		VALUES('". $dni ."','". $nom ."','". $ape ."', TO_DATE('". $fec_nac ."', ". $formato ."),'". $contacto 
		."', TO_DATE('". $fec_alt ."',". $formato ."),'". $empresa ."','". $pass ."','". $puntos ."','". $peso ."','". $altura ."')";
		$conexion->query($consulta);
		return "usuario creado";
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function borrar_usuario($conexion, $dniUsuario) {
	try {
		$stmt=$conexion->prepare('DELETE FROM usuario WHERE DNI_USUARIO = :dniUsuario');
		$stmt->bindParam(':dniUsuario',$dniUsuario);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

function existeEmpresa3($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM EMPRESA WHERE OID_EMPRESA ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

function existeContacto3($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM CONTACTO WHERE OID_CONTACTO ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

?>