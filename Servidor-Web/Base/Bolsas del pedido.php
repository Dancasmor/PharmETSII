<?php 
	include_once('./gestores/gestionarPedidoUsuario.php');
	include_once('./gestores/gestionarBolsa.php');
	include_once('./gestores/funciones_catalogo.php');
	include_once('./Base/gestionBD.php');
	$conexion= crearConexionBD();
	$filas =  consultarBolsasPedido($conexion, $_SESSION['oid_muestra']);
	$precioTotal=0;
?>

<h3>Informacion del pedido</h3>

<?php foreach($filas as $fila) { ?>
	<div>
		<em class="tx" id="producto_bolsa" >-<?php echo traducirOID_PRODUCTO($conexion,$fila['OID_PRODUCTO']);?></em>
		<em class="tx" id="cantidad" >Cantidad:<?php echo $fila['CANTIDAD'];?></em>
		<em class="tx" id="precio">Precio:<?php echo obtenerPrecio($conexion, $fila['OID_PRODUCTO']);?></em>
	</div>
<?php $precioTotal= $precioTotal +  floatval(str_replace(",",".",obtenerPrecio($conexion, $fila['OID_PRODUCTO'])));;} ?>
	<br />
	<em class="tx" id="precio_total">Precio total: <?php echo $precioTotal?></em>
	<a href="?tituloPag=Pedidos usuario">Volver</a>	
<?php cerrarConexionBD($conexion); ?>