<?php
	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarFarmacias.php");
	require_once("./gestores/gestionarContacto.php");

	$conexion = crearConexionBD();
	$filas = consultarTodasFarmacias($conexion);
	$grado = $usuario['grado'];
	$farmacia = $usuario['OID_FARMACIA'];
	cerrarConexionBD($conexion);
?>

<div class="grid-container">
	
		<?php if($grado > 5){
			$conexion = crearConexionBD();
			$empresas = consultarTodasEmpresas($conexion);
			cerrarConexionBD($conexion);
			foreach($empresas as $empresa){?>
				<div class ="grid-item">
				<h1>EMPRESA</h1>
				<article class="farmacia">
				<div class="fila_empresa">
				<div class="datos_empresa">		
						<h1><?php echo $empresa["NOMBRE"] ?></h1>
						<?php
							$conexion = crearConexionBD();
							$contacto4 = consultarContactoPorOID($conexion, $empresa["OID_CONTACTO"])->fetch()[3];
							$contacto5 = consultarContactoPorOID($conexion, $empresa["OID_CONTACTO"])->fetch()[4];
							$contacto6 = consultarContactoPorOID($conexion, $empresa["OID_CONTACTO"])->fetch()[5];
							cerrarConexionBD($conexion);
						?>
						<div class="fila_contacto">
							<div class="datos_contacto1">
								<?php echo $contacto4?>
							</div>
							<div class="datos_contacto2">
								<?php echo $contacto5?>	
							</div>
							<div class="datos_contacto3">
								<?php echo $contacto6?>	
							</div>
							<a href="?tituloPag=Almacen&oidEmpresa=<?php echo $empresa["OID_EMPRESA"] ?>"><img id="logo_almacen" src="./images/almacen.png"/></a>
							<a href="?tituloPag=Pedidos&oidEmpresa=<?php echo $empresa["OID_EMPRESA"] ?>"><img id="logo_pedidos" src="./images/pedidos.png"/></a>
							<a href="?tituloPag=Empleados&oidFarmacia=<?php echo $farmacia ?>"><img id="logo_empleados" src="./images/empleados.png"/></a>
						</div>
					</div>				
					</div>
				</article>
				</div>
		<?php } }?>
	
	<?php
		foreach($filas as $fila) {
			if($grado == 7 || (int) $farmacia == $fila["OID_FARMACIA"]){
	?>

	<article class="farmacia">
		<form method="post" action="./controladores/controlador_farmacias.php">
			<div class="fila_farmacia">
				<div class="datos_farmacia">		
					<div class ="grid-item">
						<h1><?php echo $fila["NOMBRE"] ?></h1>
						<?php
							$conexion = crearConexionBD();
							$contacto1 = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[3];
							$contacto2 = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[4];
							$contacto3 = consultarContactoPorOID($conexion, $fila["OID_CONTACTO"])->fetch()[5];
							cerrarConexionBD($conexion);
						?>
						<div class="fila_contacto">
							<div class="datos_contacto1">
								<?php echo $contacto1?>
							</div>
							<div class="datos_contacto2">
								<?php echo $contacto2?>	
							</div>
							<div class="datos_contacto3">
								<?php echo $contacto3?>	
							</div>
							<a href="?tituloPag=Almacen&oidFarmacia=<?php echo $fila["OID_FARMACIA"] ?>"><img id="logo_almacen" src="./images/almacen.png"/></a>
							<a href="?tituloPag=Pedidos&oidFarmacia=<?php echo $fila["OID_FARMACIA"] ?>"><img id="logo_pedidos" src="./images/pedidos.png"/></a>
							<a href="?tituloPag=Empleados&oidFarmacia=<?php echo $fila["OID_FARMACIA"] ?>"><img id="logo_empleados" src="./images/empleados.png"/></a>
						</div>
					</div>				
				</div>
			</div>
		</form>
	</article>
	<?php }
} ?>
</div>