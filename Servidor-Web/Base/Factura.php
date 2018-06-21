<?php
	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarFacturas.php");
	require_once("./gestores/gestionarPedidos.php");
	require_once("./gestores/gestionarLineas.php");
	require_once("./gestores/gestionarEnvios.php");

	$conexion = crearConexionBD();
	$filas = consultarTodosPedidos2($conexion);
	$oidPedido = $_REQUEST["oidPedido"];
	$esprov = $_REQUEST["esProveedor"];
	cerrarConexionBD($conexion);
?>

<div class="grid-container">
	
	<?php
	if($_REQUEST["enviado"] == 1){
		foreach($filas as $fila) {
		
			if((int)$oidPedido == $fila["OID_PEDIDO"]){
				$conexion = crearConexionBD();
				$facturas = consultarFacturasPorPedido1($conexion, $fila["OID_PEDIDO"]);
				cerrarConexionBD($conexion);
				foreach($facturas as $factura){
					$fechaFactura = $factura["FECHA_FACTURA"];
					$precioEnvio = $factura["PRECIO_ENVIO"];
	?>

	<article class="pedido">
		<div class="fila_pedido2">
			<div class="datos_pedido">		
				<div class ="grid-item">
					<div class = "fila_pedido3">
						<div class = "fila_pedido"><h1>Factura del día <?php echo $fechaFactura?></h1></a></div>
							<div class="datos_pedido1">
								<?php echo $precioEnvio ?> €
							</div>
						</div>					
					</div>				
				</div>
			</div>
	</article>
	<?php }}} }
			else{
				
				$conexion = crearConexionBD();
				$lineas = consultarTodosLineas($conexion);
				cerrarConexionBD($conexion);
				foreach($lineas as $linea) {
				if($linea["OID_PEDIDO"] == $oidPedido){
			?>	
				<div class ="grid-item">
				<p>ID linea: <?php echo $linea["OID_LINEA"]; ?></p>
						<p>Cantidad : <?php echo $linea["CANTIDAD"] ?></p>
						<p>Pedido : <?php echo $linea["OID_PEDIDO"] ?></p>
						<?php
							if (isset($linea["OID_PRODUCTO"])) { ?>
								<p>Producto : <?php echo $linea["OID_PRODUCTO"] ?></p>
						<?php } else { ?>
								<p>Lote : <?php echo $linea["OID_LOTE"] ?></p>	
						<?php } ?>
				</div>
		<?php	}} ?>
			
			
		
	<?php	if($esprov == 1){ ?>
		<!-- Crear linea lote-->
		
	<form method="post" action="./controladores/controlador_lineas.php">
	<article>
		<h3><b>Crear linea</b></h3>
		<?php 
		$conexion = crearConexionBD();
		esProveedor($conexion, $oidPedido); 
		cerrarConexionBD($conexion);
		 ?>
		<label> 
			<input id = "form_pedido_proveedor" name="OID_PEDIDO" type= "hidden" value="<?php echo $oidPedido ?>" required/>
		</label>
		
		<label>
			CANTIDAD: 
			<input id = "CANTIDAD" name="CANTIDAD" type= "number" min="1" max="1000" required/>
		</label>
		
		<label>
			Oid lote: 
			<input id = "form_lote" name="OID_LOTE" type= "text" required/>
		</label>
		
		<div id="boton">
			<input  name="crear_linea_lote" type= "hidden"  required/>
				<button id="crear_linea_lote" name="crear_linea_lote" type="submit">
					Crear
				</button>
		</div>
	</article>
	</form>
	
	<?php } else if(!isset($_REQUEST["noTocar"])){ ?>
		<!-- Crear linea producto-->
	<form method="post" action="./controladores/controlador_lineas.php">
	<article>
		<?php 
		$conexion = crearConexionBD();
		existePedido1($conexion, $oidPedido); 
		cerrarConexionBD($conexion);
		 ?>
		<h3><b>Crear linea</b></h3>
		
		<label> 
			<input id = "form_pedido_proveedor" name="OID_PEDIDO" type= "hidden" value="<?php echo $oidPedido ?>" required/>
		</label>
		
		<label>
			CANTIDAD: 
			<input id = "form_cantidad" name="CANTIDAD" type= "number" min="20" max="1000" required/>
		</label>
		
		<select name="OID_PRODUCTO" id="form_producto">
			<?php 
				$conexion = crearConexionBD();
				$secciones = consultarSeccionPorOIDAlmacen($conexion, $_REQUEST["oidAlmacen"]);
				cerrarConexionBD($conexion);
				foreach($secciones as $s) {
					$oid = $s['OID_PRODUCTO'];
					
					?>
					<option value='<?php echo $oid ?>'><?php echo $oid ?></option>"
				
				<?php  }?>
		</select>
		
		<div id="boton">
				<button id="crear_linea_producto" name="crear_linea_producto" type="submit">
					Crear
				</button>
		</div>
	</article>
	</form>
			
			
			
			<?php }

else if(isset($_REQUEST["env"])){ ?>
	<h3>Envios:</h3>
	
	<?php 
	$conexion = crearConexionBD();
	$envios = consultarTodosEnvios2($conexion);
	cerrarConexionBD($conexion);
	$almacen = (int)$_REQUEST['oidAlmacen'];
	
	foreach($envios as $e) {
		if(($e["OID_ALMACEN"] == $almacen) && ($e["FECHA_ENVIO"] > date("d-m-Y"))){
	?>
	<div class ="grid-item">
	<h4><b>ID envio: <?php echo $e["OID_ENVIO"]; ?></b></h4>
		<?php
		$fecha = $e["FECHA_ENVIO"];
		$envio = $e["OID_ENVIO"];
		 echo "<div class = 'fila_pedido'><a href='?tituloPag=RegistroFacturasAlmacen&oidPedido=$oidPedido&oidAlmacen=$almacen&oidEnvio=$envio'><h1>$fecha</h1></a></div> ";?>
	</div>
	<?php
}}}

}
	
	?>
		<div id="div_error" >
		<p id='error_lote' ></p>
		<p id='error_cantidad' ></p>
	</div>
</div>