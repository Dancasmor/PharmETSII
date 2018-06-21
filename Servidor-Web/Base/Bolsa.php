<?php

	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarBolsa.php");
	require_once("./Base/paginacion_consulta.php");
	require_once("./gestores/func_extras.php");
	
	if (isset($_SESSION["bolsa"])){
		$bolsa = $_SESSION["bolsa"];
		unset($_SESSION["bolsa"]);
	}
	////////////////////////Propiedades de ajuste de la paginacion///////////////////////
	$defectoNpag=1;
	$defectoNmuestra=25;
	/////////////////////////////////////////////////////////////////////////////////////
	$conexion = crearConexionBD();
	$query = "SELECT * FROM BOLSA ORDER BY OID_PEDIDO_USUARIO";
	$filas= consultarTodasBolsas($conexion);
	cerrarConexionBD($conexion);
?>

<body>
<main>
	<h2>Gestión de bolsas</h2>
	
	<?php
		foreach($filas as $fila) {
	?>
	
	<article class="bolsa">
		<form method="post" action="controlador_bolsa.php">
			<div class="fila_bolsa">
				<div class="datos_bolsa">	
					<!-- Controles de los campos que quedan ocultos:
						OID_LIBRO, OID_AUTOR, OID_AUTORIA, NOMBRE, APELLIDOS -->
						
						<input id=="OID_BOLSA" name="OID_BOLSA" type="hidden" value="<?php echo $fila["OID_BOLSA"];?>" />
						<input id=="OID_PEDIDO_USUARIO" name="OID_PEDIDO_USUARIO" type="hidden" value="<?php echo $fila["OID_PEDIDO_USUARIO"];?>" />
						<input id=="OID_PRODUCTO" name="OID_PRODUCTO" type="hidden" value="<?php echo $fila["OID_PRODUCTO"];?>" />
						<input id=="CANTIDAD" name="CANTIDAD" type="hidden" value="<?php echo $fila["CANTIDAD"];?>" />
				<?php
					if ( isset($bolsa) and ($bolsa["OID_BOLSA"]==$fila["OID_BOLSA"])) { ?>
						<!-- Editando cantidad -->
						<label for='CANTIDAD'>Introduce nueva cantidad:</label>
						<h3> <input id ="CANTIDAD" name = "CANTIDAD" type="number" value="<?php echo $fila["CANTIDAD"];?>"/></h3>
						<h4><?php echo $fila["CANTIDAD"]."uds. de ".$fila["OID_PRODUCTO"]; ?></h4>
						<?php }	else { ?>
						<!-- mostrando título -->
						<div class="OID_BOLSA">Oid_bolsa: <em><?php echo $fila["OID_BOLSA"];?></em>
												Oid_pedido_usuario: <em><?php echo $fila["OID_PEDIDO_USUARIO"];?></em>
												Cantidad: <em><?php echo $fila["CANTIDAD"];?></em>
												Oid_producto: <em><?php echo $fila["OID_PRODUCTO"];?></em>
												
						

				<?php } ?>

				<?php if (isset($bolsa) and ($bolsa["OID_BOLSA"]==$fila["OID_BOLSA"])) { ?>
						<!-- Botón de grabar -->
						<button id="guardar_bolsa" name="guardar_bolsa" type="submit" class="editar_fila">
							<img src="/FARMA/images/guardar.png" class="editar_fila" alt="Guardar" width="20" height="20">
						</button>
				<?php } else {?>
						<!-- Botón de editar -->
						<button id="editar_bolsa" name="editar_bolsa" type="submit" class="editar_fila">
							<img src="/FARMA/images/editar.ico" class="editar_fila" alt="Editar bolsa" width="20" height="20">
						</button>
				<?php } ?>
					<button id="borrar_bolsa" name="borrar_bolsa" type="submit" class="editar_fila">
						<img src="/FARMA/images/elimina.png" class="editar_fila" alt="Borrar bolsa" width="20" height="20">
					</button>
					</div>
				</div>
			</div>
			<br />
		</form>
	</article>

	<?php } ?>
</main>
</body>