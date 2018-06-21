<?php
require_once ("./Base/gestionBD.php");
require_once ("./gestores/gestionarPedidoUsuario.php");
require_once ("./gestores/gestionarFacturaUsuario.php");
require_once ("./gestores/gestionarPedidos.php");
require_once ("./gestores/gestionarFacturas.php");
require_once ("./gestores/gestionarNominas.php");
require_once ("./gestores/gestionarEnvios.php");
require_once ("./gestores/gestionarLineas.php");

if ($nivel == 0) {
	header("Location: ?tituloPag=Portada");
}

$conexion = crearConexionBD();
$filasPedido = consultarTodosPedidosUsuario($conexion);
$filasFactura = consultarTodasFacturaUsuario($conexion);
$filasPedidoProveedor = consultarTodosPedidos2($conexion);
$filasLineaPedidoProveedor = consultarTodosLineas($conexion);
$filasFacturaProveedor = consultarTodosFacturas2($conexion);
$filasEnviosProveedor = consultarTodosEnvios2($conexion);
$filasNominaEmpleado = consultarTodasNominas1($conexion);
cerrarConexionBD($conexion);
?>
<?php
if(isset($_REQUEST["idPedidoUsuario"])){ ?>
	
	<?php
		foreach($filasPedido as $fila) {
			if((int)$_REQUEST["idPedidoUsuario"] == $fila["OID_PEDIDO_USUARIO"]){
				
			
	?>
	<div class="grid-container"> PedidoUsuario
	<article class="pedido_usuario">
			<div class="fila_pedido_usuario">
				<div class="datos_pedido_usuario">		
					<div class ="grid-item">
						<div class="OID_PEDIDO_USUARIO"> Oid_pedido_usuario: <em><?php echo $fila["OID_PEDIDO_USUARIO"]; ?></em>
												Dni_usuario: <em><?php echo $fila["DNI_USUARIO"]; ?></em>
												Fecha de solicitud: <em><?php echo $fila["FECHA_SOLICITUD"]; ?></em>
												Contrareembolso: <em><?php echo $fila["CONTRAREEMBOLSO_TARJETA"]; ?></em>
												Preparado: <em><?php echo $fila["PREPARADO"]; ?></em>
												
						</div>	
					</div>				
				</div>
			</div>
	</article>
	</div>
	<!--Facturas-->
	<div class="grid-container"> FacturaUsuario
		<?php
			foreach($filasFactura as $fila1) {
				if($fila["OID_PEDIDO_USUARIO"] == $fila1["OID_PEDIDO_USUARIO"]){
		?>
		<article class="factura_usuario">
				<div class="fila_factura_usuario">
					<div class="datos_factura_usuario">		
						<div class ="grid-item">
							<a href="?tituloPag=Perfil&idFacturaUsuario=<?php echo $fila1["OID_FACTURA_USUARIO"]?>">
								<?php echo $fila1["OID_FACTURA_USUARIO"]?></a>
						
				
						</div>				
					</div>
				</div>
		</article>
		<?php }
			}
		?>	
	</div>
	
	<?php 	}
		}
 ?>	

<?php }else if(isset($_REQUEST["idFacturaUsuario"])){ ?>
	<div class="grid-container"> FacturaUsuario
		<?php
			foreach($filasFactura as $fila) {
				if((int)$_REQUEST["idFacturaUsuario"] == $fila["OID_FACTURA_USUARIO"]){
		?>
		<article class="factura_usuario">
				<div class="fila_factura_usuario">
					<div class="datos_factura_usuario">		
						<div class ="grid-item">
							<div class="OID_FACTURA_USUARIO"> Oid_factura_usuario: <em><?php echo $fila["OID_FACTURA_USUARIO"]; ?></em>
												Oid_pedido_usuario: <em><?php echo $fila["OID_PEDIDO_USUARIO"]; ?></em>
												Fecha_venta: <em><?php echo $fila["FECHA_VENTA"]; ?></em>
												Oid_almacen: <em><?php echo $fila["OID_ALMACEN"]; ?></em>
												Enviado: <em><?php echo $fila["ENVIADO"]; ?></em>
												
						</div>
						</div>				
					</div>
				</div>
		</article>
		<?php }
			}
		?>	
	</div>
<?php }else if($nivel==1){ ?>
	<!--Pedidos-->
	<div class="grid-container">PedidoUsuario
	<?php
		foreach($filasPedido as $fila) {
			if($usuario["DNI_USUARIO"] == $fila["DNI_USUARIO"]){
				
			
	?>
	<article class="pedido_usuario">
			<div class="fila_pedido_usuario">
				<div class="datos_pedido_usuario">		
					<div class ="grid-item">
						<a href="?tituloPag=Perfil&idPedidoUsuario=<?php echo $fila["OID_PEDIDO_USUARIO"]?>">
							<?php echo $fila["OID_PEDIDO_USUARIO"]?></a>
							
					</div>				
				</div>
			</div>
	</article>
	<?php 	}
		}
 ?>	
</div>
	
<?php }else if(isset($_REQUEST["idPedidoProveedor"])){ ?>
	
	<?php
		foreach($filasPedidoProveedor as $fila) {
			if((int)$_REQUEST["idPedidoProveedor"] == $fila["OID_PEDIDO"]){		
	?>
	<div id='id_pedidos_prov' class="grid-container">
	<article class="pedido_proveedor">
			<div class="fila_pedido_proveedor">
				<div class="datos_pedido_proveedor">		
					<div class ="grid-item">
						<h1><b>OID_PEDIDO: <?php echo $fila["OID_PEDIDO"] ?></b></h1>
						<h2><em>Fecha: <?php echo $fila["FECHA_PEDIDO"] ?></em></h2>
						<h2><em>Enviado: <?php echo $fila["ENVIADO"] ?></em></h2>
						<h2><em>Es proveedor: <?php echo $fila["ESPROVEEDOR"] ?></em></h2>
						<h2><em>OID_ALMACEN: <?php echo $fila["OID_ALMACEN"] ?></em></h2>
						<?php if($fila["ESPROVEEDOR"] == 0) {?>
							<h2><em>OID_ALMACEN 2: <?php echo $fila["OID_ALMACEN2"] ?></em></h2>
						<?php }	else  { ?>
							<h2><em>OID_PROVEEDOR: <?php echo $fila["OID_PROVEEDOR"] ?></em></h2>
						<?php } ?>	
					</div>				
				</div>
			</div>
	</article>
	</div>
	<!--Lineas Pedido Proveedor-->
	<div id='id_lineas_prov' class="gridd-container">
		<?php foreach($filasLineaPedidoProveedor as $fila3) { ?>
			<?php if($fila3["OID_PEDIDO"] == $fila["OID_PEDIDO"]) { ?>			
				<article class="linea_proveedor">
						<div class="fila_linea_proveedor">
							<div class="datos_linea_proveedor">	
								<div id='item_linea_prov' class ="grid-item">
									<h1><b>Linea:</b></h1>	
									<h6><em>Oid Linea: <?php echo $fila3["OID_LINEA"] ?></em></h6>
									<h6><em>Oid Lote: <?php echo $fila3["OID_LOTE"] ?></em></h6>
								</div>				
							</div>
						</div>
				</article>
		<?php	} ?>		
	<?php	} ?>
	</div>
	<!--Facturas Proveedor-->
	<div id='id_facturas_prov' class="grid-container">
		<?php
			foreach($filasFacturaProveedor as $fila1) {
				if($fila["OID_PEDIDO"] == $fila1["OID_PEDIDO"]){
		?>
		<article class="factura_proveedor">
				<div class="fila_factura_proveedor">
					<div class="datos_factura_proveedor">
						<h1 id='tittle_factura_prov'><b>Factura:</b></h1>		
						<div id='item_facturas_prov' class ="grid-item">
							<h6><em>Fecha de Facturación: <?php echo $fila1["FECHA_FACTURA"] ?></em></h6>
							<h6><em>Precio Envio: <?php echo $fila1["PRECIO_ENVIO"] ?> €</em></h6>
							<a href="?tituloPag=Perfil&idFacturaProveedor=<?php echo $fila1["OID_FACTURA"]?>">
								<h6><em>+ Información</em></h6></a>
						
				
						</div>				
					</div>
				</div>
		</article>
		<?php } else { ?>
			<?php foreach($filasEnviosProveedor as $fila2){ 
					if($fila["OID_PROVEEDOR"]==$fila2["OID_PROVEEDOR"] && $fila["ENVIADO"]==0) {
						if($fila2["FECHA_ENVIO"] > date('d-m-Y')){ ?>
							<div class="envios_proveedor">
								<div id='id_envios_prov' class="grid-container">
									<div id='item_envios_prov' class="grid-item">
										<h1><b>Envio:</b></h1>
										<h4>OID PROVEEDOR: <?php echo $fila2["OID_PROVEEDOR"] ?></h4>
										<h5>Fecha de Envio: <?php echo $fila2["FECHA_ENVIO"] ?></h5>
										<a href="?tituloPag=RegistroFacturasProveedor&oidPedido=<?php echo $fila["OID_PEDIDO"]?>&oidEnvio=<?php echo $fila2["OID_ENVIO"] ?>">
											<button>
												Crear Factura
											</button>
										</a>
									</div>
								</div>
							</div>
								
					<?php } ?>
				<?php } ?>
			<?php } ?>		
		<?php } ?>
	<?php } ?>	
	<?php if($fila["ENVIADO"]==0) { ?>
		<div id='crear_envio_prov' class="registro_envios">
			<div class="grid-item">
				<a href="?tituloPag=RegistroEnvios&idPedidoProveedor=<?php echo $fila["OID_PEDIDO"]?>">
				<h2><b>Crear Envio</b></h2></a>
			</div>
		</div>
	<?php } ?>
	</div>
	<?php 	}
		}
 ?>	

<?php }else if(isset($_REQUEST["idFacturaProveedor"])){ ?>
	<div id='factura_prov' class="grid-container">
		<?php
			foreach($filasFacturaProveedor as $fila) {
				if((int)$_REQUEST["idFacturaProveedor"] == $fila["OID_FACTURA"]){
		?>
		<article class="factura_proveedor">
				<div class="fila_factura_proveedor">
					<div class="datos_factura_proveedor">		
						<div class ="grid-item">
							<h1><b>OID_FACTURA : <?php echo $fila["OID_FACTURA"]; ?></b></h1>
							<h2><em>Fecha : <?php echo $fila["FECHA_FACTURA"] ?></em></h2>
							<h2><em>Precio envio: <?php echo $fila["PRECIO_ENVIO"] ?></em></h2>
							<h2><em>Pedido : <?php echo $fila["OID_PEDIDO"] ?></em></h2>
							<h2><em>Envio : <?php echo $fila["OID_ENVIO"] ?></em></h2>
							<h2><em>Almacén : <?php echo $fila["OID_ALMACEN"] ?></em></h2>	
						</div>				
					</div>
				</div>
		</article>
		<?php }
			}
		?>	
	</div>

<?php } else if($nivel==2){ ?>

	<!--Pedidos proveedor-->
	<h1 id='tittle_pedidos_prov'><b>Mis pedidos: </b></h1>	
	<div id="prov_pedidos" class="grid-container">	
	<?php
		foreach($filasPedidoProveedor as $fila) {
			if((int)$usuario["OID_PROVEEDOR"] == $fila["OID_PROVEEDOR"]){
				
			
	?>
	<article class="pedido_proveedor">
			<div class="fila_pedido_proveedor">
				<div class="datos_pedido_proveedor">		
					<div class ="grid-item">
						<h6><em>Fecha: <?php echo $fila["FECHA_PEDIDO"] ?> </em></h6>
						<h6><em><?php if($fila["ENVIADO"]==0){ ?>
													Pendiente de Envio
									   <?php } else { ?>
									   			Enviado
									<?php   } ?> 
						</em></h6>
						<a href="?tituloPag=Perfil&idPedidoProveedor=<?php echo $fila["OID_PEDIDO"]?>">
							<h6><em>+ Información</em></h6>
						</a>
							
					</div>				
				</div>
			</div>
	</article>
	<?php 	}
		}
 ?>	
</div>
<?php } else  if(isset($_REQUEST["idNomina"])){ ?>
	
	<?php
		foreach($filasNominaEmpleado as $fila) {
			if((int)$_REQUEST["idNomina"] == $fila["OID_NOMINA"]){
	?>
	<div class="grid-container">
	<article class="nomina">
			<div class="fila_nomina">
				<div class="datos_nomina">		
					<div class ="grid-item">
						<h4><b>OID_NOMINA : <?php echo $fila["OID_NOMINA"]; ?></b></h4>
						<h5><em>Dni Empleado : <?php echo $fila["DNI_EMPLEADO"] ?></em></h5>
						<h5><em>Salario Base : <?php echo $fila["SALARIO_BASE"] ?>€</em></h5>
						<h5><em>Salario Variable : <?php echo $fila["SALARIO_VARIABLE"] ?>€</em></h5>
						<h5><em>Fecha : <?php echo $fila["FECHA"] ?></em></h5>
						<h5><em>Cobrada : <?php if($fila["COBRADA"==0]){ ?>
													No
										  <?php } else { ?>
													Si
									      <?php } ?>
						</em></h5>
						<?php } ?>	
					</div>				
				</div>
			</div>
	</article>
	</div>
	<?php } ?>
<?php } else if($nivel==3) { ?>

	<div class="grid-container">
		<h1><b>Mis nominas:</b></h1>
	<?php
		foreach($filasNominaEmpleado as $fila) {
			if($usuario["DNI_EMPLEADO"] == $fila["DNI_EMPLEADO"]){
				
			
	?>
	<article class="nomina">
			<div class="fila_nomina">
				<div class="datos_nomina">	
					<div class ="grid-item">
						<h6><em>Fecha de Emisión: <?php echo $fila["FECHA"]?></em></h6>	
						<h6><em>
							<?php if($fila["COBRADA"]==0){ ?>
									Pendiente de cobro
							<?php } else { ?>
									Cobrada
							<?php } ?>
						</em></h6>
						<a href="?tituloPag=Perfil&idNomina=<?php echo $fila["OID_NOMINA"]?>">
							<h6><em>+ Información</em></h6>
						</a>
						
							
					</div>				
				</div>
			</div>
	</article>
	<?php 	}
		}
 ?>	
</div> 
<?php } ?>



