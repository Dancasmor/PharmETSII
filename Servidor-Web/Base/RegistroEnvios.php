
		
	<div id="div_error" >
		<p id='error_almacen' ></p>
		<p id='error_proveedor' ></p>
		<p id='error_fecha' ></p>
	</div>
		
		<!-- Crear envio de proveedor-->
	<form method="post" action="./controladores/controlador_envios.php">
	<article>
		<h3><b>Crear envio de proveedor</b></h3>
		
		<label>
			<input id = "form_proveedor" name="OID_PROVEEDOR" value=<?php echo $usuario["OID_PROVEEDOR"] ?> type= "hidden" required/>
		</label>
		
		<label>
			Fecha aproximada de la entrega: 
			<input id = "form_fecha_envio_proveedor" name="FECHA_ENVIO" type= "date" min = <?php echo date('Y-m-d', strtotime(date("Y-m-d") . ' + 1 day'));?> oninput="fecha_envio_proveedor();" required/>
		</label>
		
		<input name="OID_PEDIDO" type= "hidden" value = "<?php echo $_REQUEST["idPedidoProveedor"]?>" required/>
		
		<div id="boton">
				<button id="crear_envio_proveedor" name="crear_envio_proveedor" type="submit">
					Crear
				</button>
		</div>
	</article>
	</form>
	
	

