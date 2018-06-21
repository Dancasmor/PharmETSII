<?php
if(isset($usuario) and $usuario["nivel"] == 3){
	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarProducto.php");
	require_once("./gestores/gestionarSeccion.php");
	require_once("./gestores/gestionarAlmacenes.php");

	$conexion = crearConexionBD();
	$filas = consultarTodosAlmacenes($conexion);
	if(isset($_REQUEST["oidFarmacia"])){
		$oidFarmacia = $_REQUEST["oidFarmacia"];
		?>

	<div class="grid-container">
	
	<?php
		foreach($filas as $fila) {
		
			if((int)$oidFarmacia == $fila["OID_FARMACIA"]){
				$farmacia = $fila["OID_FARMACIA"];
				$almacen = (int)$fila["OID_ALMACEN"];
				$secciones = consultarSeccionPorOIDAlmacen($conexion, $fila["OID_ALMACEN"]);
				foreach($secciones as $seccion){
					$stockActual = $seccion["STOCK_ACTUAL"];
					$stockSeguridad = $seccion["STOCK_SEGURIDAD"];
					$stockMaximo = $seccion["STOCK_LIMITE"];
					$idSeccion = $seccion["OID_SECCION"];
					$nombreProducto = consultarProductoPorOID($conexion, $seccion["OID_PRODUCTO"])->fetch()[1];
					$urlProducto = consultarProductoPorOID($conexion, $seccion["OID_PRODUCTO"])->fetch()[2];
					$precioProducto = consultarProductoPorOID($conexion, $seccion["OID_PRODUCTO"])->fetch()[3];
					$recetaProducto = consultarProductoPorOID($conexion, $seccion["OID_PRODUCTO"])->fetch()[5];
	?>

	<article class="producto">
		<div class="fila_producto2">
			<div class="datos_producto">		
				<div class ="grid-item">
					<div class = "fila_producto3">
						<div class = "fila_producto"><h1><?php echo $nombreProducto?></h1></a></div>
						<div class = "img_producto"><img id = "img_producto" src = "<?php echo $urlProducto?>"/></div>
						<div class="fila_producto1">
							<div class="precio_venta">
								<?php echo $precioProducto?> €
							</div>
							<div class="datos_producto1">
								Stock actual: <font<?php
									if($stockActual < $stockSeguridad){?>
										color="red"
									<?php } ?>> <?php echo $stockActual ?>
								</font>
							</div>
							<div class="datos_producto3">
								Stock de seguridad: <?php echo $stockSeguridad?>	
							</div>
							<div class="datos_producto4">
								Stock límite: <?php echo $stockMaximo?>	
							</div>
							<?php
							if ($recetaProducto == 1) {
								echo("Necesita receta");
							}
							?>
						</div>
							</div>	
							<div class="formularios">
							<form method="post" action="./controladores/controlador_seccion.php">
								<input id = "inOID_FARMACIA" name="OID_FARMACIA" type= "hidden" value="<?php echo $farmacia; ?>"/>
								<input id = "inOID_SECCION" name="OID_SECCION" type= "hidden" value="<?php echo $idSeccion; ?>"/>
								<div class= "botones">
									<div class="div_borrar">
										</button>
												<button class="borrar" name="borrar" type="submit">
												<img src="./images/eliminar.png" alt="Borrar seccion"/>
										</button>
									</div>	
								</div>
							</form>
							<form method="post" action="./controladores/controlador_seccion.php">
								<input id = "añadir" name="añadir" type= "hidden" value="añadir"/>
								<input id = "inOID_FARMACIA" name="OID_FARMACIA" type= "hidden" value="<?php echo $farmacia; ?>"/>
								<input id = "inOID_SECCION" name="OID_SECCION" type= "hidden" value="<?php echo $idSeccion; ?>"/>
								<div class= "botones">
									<input id = "inCantidad" name="cantidad" type= "number" min="0" max="<?php echo($stockMaximo - $stockActual); ?>" />
									<div class="div_añadir">
										</button>
												<button class="añadir" name="añadir" type="submit">
												<img src="./images/añadir.png" alt="Añadir cantidad"/>
										</button>
									</div>
								</div>
							</form>
							<form method="post" action="./controladores/controlador_seccion.php">
								<input id = "restar" name="restar" type= "hidden" value="restar"/>
								<input id = "inOID_FARMACIA" name="OID_FARMACIA" type= "hidden" value="<?php echo $farmacia; ?>"/>
								<input id = "inOID_SECCION" name="OID_SECCION" type= "hidden" value="<?php echo $idSeccion; ?>"/>
								<div class= "botones">
									<input id = "inCantidad" name="cantidad" type= "number" min="0" max="<?php echo($stockActual); ?>" />
									<div class="div_restar">
										</button>
												<button class="restar" name="restar" type="submit">
												<img src="./images/restar.png" alt="Restar cantidad"/>
										</button>
									</div>
								</div>
							</form>	
							</div>			
					</div>				
				</div>
			</div>
	</article>
	<?php }}} ?>
	
	<?php
		if($grado == 3 || $grado == 6 || $grado == 7){
	?>
			
		<form method="post" action="./controladores/controlador_seccion.php">
		<article>
			<h3 style="background-color: #007777; color: white;padding:8px"><b>Crear sección</b></h3>
			<input id = "inOID_ALMACEN" name="OID_ALMACEN" type= "hidden" value="<?php echo $almacen; ?>"/>
			<input id = "inOID_FARMACIA" name="OID_FARMACIA" type= "hidden" value="<?php echo $farmacia; ?>"/>
			<label>
				OID Producto: 
				<input id = "inOID_PRODUCTO" name="OID_PRODUCTO" type= "text" required/>
			</label>
			<input type = "hidden" name = "crear" value = "crear"/>
			<div id="boton" style="padding-top: 10px">
					<button id="crear" name="crear" type="submit">
						Crear
					</button>
			</div>
			
			<div id = "div_error" >
				<p id = 'error_seccion_almacen' ></p>
				<p id = 'error_seccion_producto' ></p>
			</div>
		</article>
		</form>	
			
	<?php
	}
	?>
	
	</div>
	
	<?php } else{
		
	$oidEmpresa = $_REQUEST["oidEmpresa"];
	$almacen = almacenGeneral($conexion);
	?>
	
	
	<div class="grid-container">
	
	<?php
		foreach($filas as $fila) {

				$secciones = consultarSeccionPorOIDAlmacen($conexion, $almacen);
				foreach($secciones as $seccion){
					$stockActual = $seccion["STOCK_ACTUAL"];
					$stockSeguridad = $seccion["STOCK_SEGURIDAD"];
					$stockMaximo = $seccion["STOCK_LIMITE"];
					$conexion = crearConexionBD();
					$idSeccion = $seccion["OID_SECCION"];
					$nombreProducto = consultarProductoPorOID($conexion, $seccion["OID_PRODUCTO"])->fetch()[1];
					$urlProducto = consultarProductoPorOID($conexion, $seccion["OID_PRODUCTO"])->fetch()[2];
					$precioProducto = consultarProductoPorOID($conexion, $seccion["OID_PRODUCTO"])->fetch()[3];
					$recetaProducto = consultarProductoPorOID($conexion, $seccion["OID_PRODUCTO"])->fetch()[5];

	?>

	<article class="producto">
		<div class="fila_producto2">
			<div class="datos_producto">		
				<div class ="grid-item">
					<div class = "fila_producto3">
						<div class = "fila_producto"><h1><?php echo $nombreProducto?></h1></a></div>
						<div class = "img_producto"><img id = "img_producto" src = "<?php echo $urlProducto?>"/></div>
						<div class="fila_producto1">
							<div class="precio_venta">
								<?php echo $precioProducto?> €
							</div>
							<div class="datos_producto1">
								Stock actual: <font<?php
									if($stockActual < $stockSeguridad){?>
										color="red"
									<?php } ?>> <?php echo $stockActual ?>
								</font>
							</div>
							<div class="datos_producto3">
								Stock de seguridad: <?php echo $stockSeguridad?>	
							</div>
							<div class="datos_producto4">
								Stock límite: <?php echo $stockMaximo?>	
							</div>
							<?php
							if ($recetaProducto == 1) {
								echo("Necesita receta");
							}
							?>
						</div>
							</div>	
							<div class="formularios">
							<form method="post" action="./controladores/controlador_seccion.php">
								<input id = "inOID_EMPRESA" name="OID_EMPRESA" type= "hidden" value="<?php echo $oidEmpresa; ?>"/>
								<input id = "inOID_SECCION" name="OID_SECCION" type= "hidden" value="<?php echo $idSeccion; ?>"/>
								<div class= "botones">
									<div class="div_borrar">
										</button>
												<button class="borrar" name="borrar" type="submit">
												<img src="./images/eliminar.png" alt="Borrar seccion"/>
										</button>
									</div>	
								</div>
							</form>
							<form method="post" action="./controladores/controlador_seccion.php">
								<input id = "añadir" name="añadir" type= "hidden" value="añadir"/>
								<input id = "inOID_EMPRESA" name="OID_EMPRESA" type= "hidden" value="<?php echo $oidEmpresa; ?>"/>
								<input id = "inOID_SECCION" name="OID_SECCION" type= "hidden" value="<?php echo $idSeccion; ?>"/>
								<div class= "botones">
									<input id = "inCantidad" name="cantidad" type= "number" min="0" max="<?php echo($stockMaximo - $stockActual); ?>" />
									<div class="div_añadir">
										</button>
												<button class="añadir" name="añadir" type="submit">
												<img src="./images/añadir.png" alt="Añadir cantidad"/>
										</button>
									</div>
								</div>
							</form>
							<form method="post" action="./controladores/controlador_seccion.php">
								<input id = "restar" name="restar" type= "hidden" value="restar"/>
								<input id = "inOID_EMPRESA" name="OID_EMPRESA" type= "hidden" value="<?php echo $oidEmpresa; ?>"/>
								<input id = "inOID_SECCION" name="OID_SECCION" type= "hidden" value="<?php echo $idSeccion; ?>"/>
								<div class= "botones">
									<input id = "inCantidad" name="cantidad" type= "number" min="0" max="<?php echo($stockActual); ?>" />
									<div class="div_restar">
										</button>
												<button class="restar" name="restar" type="submit">
												<img src="./images/restar.png" alt="Restar cantidad"/>
										</button>
									</div>
								</div>
							</form>	
							</div>			
					</div>				
				</div>
			</div>
	</article>
	<?php }} ?>
	
	<?php
		if($grado == 3 || $grado == 6 || $grado == 7){
	?>
			
		<form method="post" action="./controladores/controlador_seccion.php">
		<article>
			<h3 style="background-color: #007777; color: white;padding:8px"><b>Crear sección</b></h3>
			<input id = "inOID_ALMACEN" name="OID_ALMACEN" type= "hidden" value="<?php echo $almacen; ?>"/>
			<input id = "inOID_EMPRESA" name="OID_EMPRESA" type= "hidden" value="<?php echo $oidEmpresa; ?>"/>
			
			<label>
				OID Producto: 
				<input id = "inOID_PRODUCTO" name="OID_PRODUCTO" type= "text" required/>
			</label>
			
			<div id="boton" style="padding-top: 10px">
					<button id="crear" name="crear" type="submit">
						Crear
					</button>
			</div>
			
			<div id = "div_error" >
				<p id = 'error_seccion_almacen' ></p>
				<p id = 'error_seccion_producto' ></p>
			</div>
		</article>
		</form>	
			
	<?php
	}
	?>
	
	</div>
	
	
	
	<?php
	}
	cerrarConexionBD($conexion);
?>

<?php }else{
	header("Location: ../index.php");
	}
 ?>