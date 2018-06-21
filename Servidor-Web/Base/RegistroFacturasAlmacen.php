
	<?php if(isset($_REQUEST["oidPedido"])){ ?>

	<div id="div_error" >
		<p id='error_pedido' ></p>
		<p id='error_almacen' ></p>
		<p id='error_envio' ></p>
	</div>
	
		<!-- Crear factura-->
	<form method="post" action="./controladores/controlador_facturas.php">
	<article>
		<h3><b>Crear factura</b></h3>
		
		<label>
			<input id = "form_pedido" name="OID_PEDIDO" value="<?php echo $_REQUEST["oidPedido"] ?>" type= "hidden" required/>
		</label>
		
		<label>
			<input id = "form_envio" name="OID_ENVIO" value="<?php echo $_REQUEST["oidEnvio"] ?>"  type= "hidden" required/>
		</label>
		
		<label> 
			<input id = "form_almacen" name="OID_ALMACEN" value="<?php echo $_REQUEST["oidAlmacen"] ?>"  type= "hidden" required/>
		</label>
		
		<label>
			Precio envio: 
			<input id = "PRECIO_ENVIO" name="PRECIO_ENVIO" type= "number" min="0" max = "100" required/>
		</label>
		<input id="crear_factura" name="crear_factura" type = "hidden" value=""/>
		<input  name="eleccion" type = "hidden" value="eleccion"/>
		<div id="boton">
				<button id="crear_factura" name="crear_factura" type="submit">
					Crear
				</button>
		</div>
	</article>
	</form>
	<?php }else { 
		 header("Location: ./index.php?tituloPag=Farmacia");
		}?>