<?php
	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarEmpleados.php");
	require_once("./gestores/gestionarContacto.php");

	$conexion = crearConexionBD();
	$filas = consultarTodosEmpleados2($conexion);
	$oidFarmacia = $_REQUEST["oidFarmacia"];
	cerrarConexionBD($conexion);
?>

<div class="grid-container">
	
	<?php
		foreach($filas as $fila) {
			if((int)$oidFarmacia == $fila["OID_FARMACIA"]){
				$conexion = crearConexionBD();
				$email = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[2];
				$dir = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[3];
				$cod = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[4];
				$ciud = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[5];
				cerrarConexionBD($conexion);
	?>

	<article class="empleado">
		<div class="fila_empleado2">
			<div class="datos_empleado">		
				<div class ="grid-item">
					<div class = "fila_empleado3">
						<div><h1><?php echo $fila["DNI_EMPLEADO"]?></h1></div>
						<div><?php echo $fila["NOMBRE"]?> <?php echo $fila["APELLIDOS"]?></div>	
						<div><?php echo $fila["CARGO"]?></div>
						<div><?php echo $email?></div>
						<div><?php echo $dir?>, <?php echo $cod?>, <?php echo $ciud?></div>
						<div><a href="?tituloPag=Nominas&dniEmpleado=<?php echo $fila["DNI_EMPLEADO"] ?>"><img id="logo_nomina" src="./images/nomina.png"/></a></div>
					</div>					
				</div>				
			</div>
		</div>
	</article>
	<?php }}?>
	
</div>