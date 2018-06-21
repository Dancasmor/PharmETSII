<?php
	include_once("./Base/gestionBD.php");
	include_once("./gestores/gestionarLote.php");
	include_once("./gestores/func_extras.php");

	$conexion = crearConexionBD();
	$filas = consultarTodosLotes($conexion);
	cerrarConexionBD($conexion);
?>

<fieldset >
		<legend>Crea tu lote</legend>
		<form method="post" action="./controladores/controlador_lote.php">
			<div>				
				<input type="hidden" name="OID_PROVEEDOR" value="<?php echo $_SESSION["usuario"]["OID_PROVEEDOR"] ?>" />
				<label for="OID_PRODUCTO">Oid del producto:</label>
				<select id="F_OID_PRODUCTO" name="OID_PRODUCTO" size="3" REQUIRED>
					<?php 
						$fililla = consultarTodosProductosB($conexion);
						foreach($fililla as $prod){
							echo "<option label='".$prod['NOMBRE']."' value='".$prod['OID_PRODUCTO']."'></option>";
						}
					?>
				</select>
				</label>
				
				<label for="CANTIDAD_LOTE">Cantidad de producto:</label>
				<input id=="CANTIDAD_LOTE" name="CANTIDAD_LOTE" type="number" min="1" max="10000" placeholder="Cantidad" REQUIRED/>
				
				<label for="PRECIO_LOTE">Precio lote:</label>
				<input id=="PRECIO_LOTE" name="PRECIO_LOTE" type="number" min="1" max="10000" step="0.01" placeholder="Precio" REQUIRED/>
				
				<button id='crear_lote' name="crear_lote" type="submit">
					<img src="../images/crear.png" width="20" height="20"/>
				</button>
			</div>
		</form>
		
	</fieldset>
	
<?php
		foreach($filas as $fila) {
	?>

	<article class="lote">
			<div class="fila_lote">
				
						<!-- mostrando título -->
						<div class="OID_BOLSA">	Oid_lote: <em><?php echo $fila["OID_LOTE"];?></em>
												Oid_proveedor: <em><?php echo $fila["OID_PROVEEDOR"];?></em>
												Cantidad: <em><?php echo $fila["CANTIDAD_LOTE"];?></em>
												Oid_producto: <em><?php echo $fila["OID_PRODUCTO"];?></em>
												Precio: <em><?php echo $fila["PRECIO_LOTE"]."€";?></em>
												
						</div>

			</div>
	</article>
	<?php } ?>