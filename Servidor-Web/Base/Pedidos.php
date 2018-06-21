<?php
	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarAlmacenes.php");
	require_once("./gestores/gestionarPedidos.php");
	require_once("./gestores/gestionarProveedores.php");
	
	$conexion = crearConexionBD();
	$almacenGeneral = rescatarAlmacenGeneral($conexion)->fetch()[0];
	$filas = consultarTodosAlmacenes($conexion);
	if(isset($_REQUEST["oidFarmacia"])){
		$oidFarmacia = $_REQUEST["oidFarmacia"];?>
		
		
		<div class="grid-container">
	
	<?php
		foreach($filas as $fila) {
		
			if((int)$oidFarmacia == $fila["OID_FARMACIA"]){
				$conexion = crearConexionBD();
				$pedidos = consultarPedidosPorAlmacen($conexion, $fila["OID_ALMACEN"]);
				cerrarConexionBD($conexion);
				$oidAlmacen = $fila["OID_ALMACEN"];
				foreach($pedidos as $pedido){
					$oidPedido = $pedido["OID_PEDIDO"];
					$fechaPedido = $pedido["FECHA_PEDIDO"];
					$enviado = $pedido["ENVIADO"];
					$esProveedor = $pedido["ESPROVEEDOR"];
					if($esProveedor == 0){
	?>

	<article class="pedido">
		<div class="fila_pedido2">
			<div class="datos_pedido">		
				<div class ="grid-item">
					<div class = "fila_pedido3">
						<?php echo "<div class = 'fila_pedido'><a href='?tituloPag=Factura&oidPedido=$oidPedido&enviado=$enviado&esProveedor=$esProveedor&oidAlmacen=$oidAlmacen'><h1>$fechaPedido</h1></a></div> ";?>
							<div class="datos_pedido1">
								<?php
									if($enviado == 0){
										echo "Pendiente de envío";?>
									<?php } else{
										echo "Enviado";
									}
								?>
							</div>
							<div class="datos_pedido2">
								<?php
									if($esProveedor == 0){
										echo "Pedido al almacén general de la empresa";
									}
								?>
							</div>
						</div>					
					</div>				
				</div>
			</div>
	</article>
	<?php } 

}
}} ?>
	<div>
	
	<form method="post" action="controladores/controlador_pedidos.php">
		<h1>Crear pedido</h1>
		<article>
		<input  name="OID_ALMACEN" type= "hidden" value = "<?php echo $oidAlmacen ?>" required/>
		<input  type = "hidden" name="crea_pedido_farmacia" value = ""/>
		<div id="boton">
		<button  name="crea_pedido_farmacia" type="submit">
			Crear
		</button>
		</div>
		</article>
	</form>
	
</div>
</div>
		
	<?php	
		
	} else{
		
		?>
		
		<h3>Pedidos recibidos: </h3>
	<?php
				
				$conexion = crearConexionBD();
				$pedidos = consultarTodosPedidos2($conexion);
				cerrarConexionBD($conexion);
				foreach($pedidos as $pedido){
					if($pedido["ESPROVEEDOR"] == 0){
					
					$oidPedido = $pedido["OID_PEDIDO"];
					$fechaPedido = $pedido["FECHA_PEDIDO"];
					$enviado = $pedido["ENVIADO"];
					$esProveedor = $pedido["ESPROVEEDOR"];
					$oidAlmacen = $pedido["OID_ALMACEN"];
	?>

	<article class="pedido">
		<div class="fila_pedido2">
			<div class="datos_pedido">		
				<div class ="grid-item">
					<div class = "fila_pedido3">
						<?php echo "<div class = 'fila_pedido'><a href='?tituloPag=Factura&oidPedido=$oidPedido&enviado=$enviado&esProveedor=$esProveedor&oidAlmacen=$oidAlmacen&oidEmpresa=1&noTocar&env'><h1>$fechaPedido</h1></a></div> ";?>
							<div class="datos_pedido1">
								<?php
									if($enviado == 0){
										echo "Pendiente de envío";?>
									<?php } else{
										echo "Enviado";
									}
								?>
							</div>
							<div class="datos_pedido2">
								<?php
									if($esProveedor == 0){
										echo "Pedido al almacén general de la empresa";
									}
								?>
							</div>
						</div>					
					</div>				
				</div>
			</div>
	</article>
	<?php }}
		?>
		
		<h3>Nuestros pedidos: </h3>
	<?php
				$conexion = crearConexionBD();
				$pedidos = consultarPedidosPorAlmacen($conexion, $almacenGeneral);
				cerrarConexionBD($conexion);
				foreach($pedidos as $pedido){
					$oidPedido = $pedido["OID_PEDIDO"];
					$fechaPedido = $pedido["FECHA_PEDIDO"];
					$enviado = $pedido["ENVIADO"];
					$esProveedor = $pedido["ESPROVEEDOR"];
					$oidAlmacen = $pedido["OID_ALMACEN"];
	?>

	<article class="pedido">
		<div class="fila_pedido2">
			<div class="datos_pedido">		
				<div class ="grid-item">
					<div class = "fila_pedido3">
						<?php echo "<div class = 'fila_pedido'><a href='?tituloPag=Factura&oidPedido=$oidPedido&enviado=$enviado&esProveedor=$esProveedor&oidAlmacen=$oidAlmacen&oidEmpresa=1'><h1>$fechaPedido</h1></a></div> ";?>
							<div class="datos_pedido1">
								<?php
									if($enviado == 0){
										echo "Pendiente de envío";?>
									<?php } else{
										echo "Enviado";
									}
								?>
							</div>
							<div class="datos_pedido2">
								<?php
									if($esProveedor == 0){
										echo "Pedido al almacén general de la empresa";
									}
								?>
							</div>
						</div>					
					</div>				
				</div>
			</div>
	</article>
	<?php }

	if(isset($_REQUEST["oidEmpresa"])){
 ?>
	<div>
	
	<form method="post" action="./controladores/controlador_envios.php">
		<h1>Crear envio</h1>
		<article>
			<label>
				Almacen a enviar: 
		<input id = "form_almacen" name="OID_ALMACEN" type= "text"  required/>
		</label>
		<input name="OID_EMPRESA" type= "hidden" value = "<?php echo $_REQUEST["oidEmpresa"]?>" required/>
		<label>
			Fecha aproximada de la entrega: 
		<input id = "form_fecha_envio_almacen" name="FECHA_ENVIO" type= "date"  min = <?php echo date('Y-m-d', strtotime(date("Y-m-d") . ' + 1 day'));?> required/>
		</label>
		<input id = "crea_envio_almacen_general" type = "hidden" name="crea_envio_almacen_general" value = ""/>
		<div id="boton">
		<button id="crea_envio_almacen_general" name="crea_envio_almacen_general" type="submit">
			Enviar
		</button>
		</div>
		</article>
	</form>
	
	</div>
	<div>
	
	<form method="post" action="controladores/controlador_pedidos.php">
		<h1>Crear pedido</h1>
		<article>
			<label>
			Proveedor: 
			<select name="OID_PROVEEDOR">
			<?php 
				$conexion = crearConexionBD();
				$proveedores = consultarTodosProveedores($conexion);
				cerrarConexionBD($conexion);
				foreach($proveedores as $p) {
					$oid = $p['OID_PROVEEDOR'];
					$nombre = $p["NOMBRE_LAB"];
					
					?>
					<option value='<?php echo $oid ?>'><?php echo $nombre ?></option>"
				
				<?php  }?>
			</select>
		
		</label>
		<input  type = "hidden" name="crear_pedido_proveedor" value = ""/>
		<div id="boton">
		<button  name="crear_pedido_proveedor" type="submit">
			Crear
		</button>
		</div>
		</article>
	</form>
	
</div>
	</div>
	
		
<?php
	}}
	cerrarConexionBD($conexion);
	
?>

<div id="div_error" >
		<p id='error_almacen' ></p>
		<p id='error_proveedor' ></p>
		<p id='error_fecha' ></p>
	</div>
