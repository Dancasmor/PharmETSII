<?php 
	
	if(isset($_SESSION["excepcion"])){
		$excepcion = $_SESSION["excepcion"];
		unset($_SESSION["excepcion"]);
	}else{
		Header("Location: ./index.php");
	}
	
	if (isset ($_SESSION["destino"])) {
		$destino = "index.php";
		unset($_SESSION["destino"]);	
	} else 
		$destino = "index.php";
?>

	<div>
		<h2>Ups!</h2>
		<?php if ($destino<>"") { ?>
		<p>Ocurrió un problema durante el procesado de los datos. Pulse <a href="<?php echo $destino ?>">aquí</a> para volver a la página principal.</p>
		<?php } else { ?>
		<p>Ocurrió un problema para acceder a la base de datos. </p>
		<?php } ?>
	</div>
		
	<div class='excepcion'>	
		<?php echo "Información relativa al problema: $excepcion;" ?>
	</div>

