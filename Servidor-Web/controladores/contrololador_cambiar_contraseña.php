<?php	
	session_start();
	
	 if (isset($_REQUEST["cambiar"])) {
		unset($_REQUEST["cambiar"]);
		$_SESSION["CONTRASEÑA"] = $_REQUEST["CONTRASEÑA"];
		$_SESSION["CONFIRMACION_CONTRASEÑA"] = $_REQUEST["CONFIRMACION_CONTRASEÑA"];
		Header("Location: ../acciones/accion_cambiar_contrasena.php");
	}
	else 
		Header("Location: ../index.php");
	
?>
