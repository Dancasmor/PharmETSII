
<?php
	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarFarmacias.php");
	require_once("./gestores/gestionarContacto.php");

	$conexion = crearConexionBD();
	$filas = consultarTodasFarmacias($conexion);
	cerrarConexionBD($conexion);
?>

<div id = "farmcias">
	<h2>Busca tu farmacia mas cercana</h2>
</div>

<div class="grid-container">
	
	<?php
		foreach($filas as $fila) {
	?>

	<article class="farmacia">
			<div class="fila_farmacia">
				<div class="datos_farmacia">		
					<div class ="grid-item">
						<h3><?php echo $fila["NOMBRE"]?></h3>
						<?php
							$conexion = crearConexionBD();
							$telefono = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[1];
							$email = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[2];
							$direccion = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[3];
							$cp = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[4];
							$ciudad = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[5];
							cerrarConexionBD($conexion);
						?>
						<div class="fila_contacto">
							<div class="telefono">
								Teléfono:
								<?php echo $telefono?>
							</div>
							<div class="email">
								Email: 
								<?php echo $email?>	
							</div>
							<div class="direccion">
								Direccion:
								<?php echo $direccion?>	
							</div>
							<div class="ciudad">
								Ciudad:
								<?php echo $ciudad?>	
							</div>
							<div class="cp">
								CP:
								<?php echo $cp?>	
							</div>
						</div>
					</div>				
				</div>
			</div>
	</article>
	<?php 
} ?>
</div>
