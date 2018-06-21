<?php

	require_once("./Base/gestionBD.php");
	require_once("./gestores/func_extras.php");
	require_once("./Base/paginacion_consulta.php");
	require_once("./gestores/gestionarPedidoUsuario.php");
	require_once("./gestores/gestionarBolsa.php");
	require_once("./gestores/funciones_catalogo.php");
	
	if (isset($_SESSION["usuario"])){
		$usuario = $_SESSION["usuario"];
	}
	if (isset($_SESSION["bolsas"])){
		$bolsas = $_SESSION["bolsas"];
	}else{
		$bolsas=array();
		$_SESSION['bolsas']= $bolsas;
	}
	$conexion= crearConexionBD();
	if(isset($usuario['DNI_USUARIO'])){
		$filas=consultarPedidosUsuarioDNI($conexion, $usuario['DNI_USUARIO']);
	}else if(isset($usuario['DNI_EMPLEADO'])){
		$filas=consultarPedidosUsuarioDNI($conexion, $usuario['DNI_EMPLEADO']);
	}
	
	cerrarConexionBD($conexion);
	
?>

<h2 id='prod_bol'>Productos en la bolsa</h2>
<?php if($bolsas){ ?>
<div class="bolsas" id='bolsas'>	
	<?php 
	$bol= depuraProductos($bolsas);
	foreach($bol as $p){ $conexion= crearConexionBD(); $t=traducirOID_PRODUCTO($conexion,$p);
		$cuen=cuentaProducto($bolsas,$p);
		?>
		
		<form id="bolsa" method="post" action="./controladores/control_pedido.php">
			<input id=="OID_PRODUCTO" name="OID_PRODUCTO" type="hidden" value="<?php echo $p;?>" />
			
			<div id="texto_bolsa">
				<em class="tx" id="oid_prod"><?php echo $t;?></em>
				<input id="CANTIDAD" name="CANTIDAD" type="number" max="99" min="1" value=<?php echo $cuen;?>></input>
				<em class="tx" id="precio"><?php echo obtenerPrecio($conexion, $p);?></em>
				
			<button id="cambiar_bolsa" name="cambiar_bolsa" type="submit">
				<img src="./images/modificar.png" id="imagen_modificar"/>
			</button>
			<button id="eliminar_bolsa" name="eliminar_bolsa" type="submit">
				<img src="./images/eliminar2.png" id="imagen_eliminar"/>
			</button>
			
			</div>
			
		</form>	
		<br />
	<?php } ?>
	<?php }else{ ?>
		<em>No hay productos en tu bolsa</em>
	<?php } ?>
	
	
	
	<form id="muestra_bolsas" method="post" action="./controladores/control_pedido.php">
		<?php if($bolsas){ ?>
		<label>Tarjeta:</label>
		<input id="CONTRAREEMBOLSO_TARJETA" name="CONTRAREEMBOLSO_TARJETA" type="checkbox"/>
	
		<label id="paraOcultar">NºTarjeta:</label>
		<input id="TARJETA" name="TARJETA" type="text" size="20" pattern="[0-9]{16,16}"/>
		
		<button id="realizar_pedido" name="realizar_pedido" type="submit" class="">
				Realizar pedido
		</button>
		<em class="tx" id="precio_total">Precio total: <?php echo (float)precioTotal($conexion, $bolsas);?></em>
		<?php } cerrarConexionBD($conexion);?>
	</form>
</div>



<h2 id='ped_rel'>Pedidos realizados</h2>


<?php if((isset($usuario['DNI_USUARIO'])||isset($usuario['DNI_EMPLEADO']))&&$filas){ ?>

<div class="pedidosUsuario" id='pedidosUsuario'>
<?php foreach($filas as $fila) { ?>
	
	<form id="pedido_usuario" method="post" action="./controladores/control_pedido.php">	
				<!--CAMPO PARA ENVIAR EL OID-->
				<input id="OID_PEDIDO_USUARIO" name="OID_PEDIDO_USUARIO" type="hidden" value="<?php echo $fila["OID_PEDIDO_USUARIO"];?>" />
				
				
				<div id="texto_pedido">
					<em class="tx" id="Fecha_pedido"><?php echo $fila["FECHA_SOLICITUD"];?></em>
					<em class="tx" id="contra_tarj" ><?php if($fila["CONTRAREEMBOLSO_TARJETA"]==1) echo "Con tarjeta:";?></em>
					<?php if($fila["CONTRAREEMBOLSO_TARJETA"]==1)echo '<em class="tx" id="tarjeta" >'.$fila["TARJETA"].'</em>';?>
					<em class="tx" id="preparado"><?php if($fila["PREPARADO"]==1) echo('PREPARADO');else echo('EN PROCESO')?></em>
				
					<button id="boton_desplegar" name="boton_desplegar" type="submit" class="desplegable">
						<img src="./images/lupa.png" id="imagen_desplegar" alt="Detalle" width="20" height="20">
					</button>
				</div>
	</form>	
	
<?php } ?>
</div>
<?php }else if(isset($usuario['NOMBRE_LAB'])){ ?>
	<p>Has iniciado sesion como proveedor, no tienes pedidos pendientes</p>

<?php }else{ ?>
	<p>No has iniciado sesion o no tienes pedidos</p>
<?php } ?>