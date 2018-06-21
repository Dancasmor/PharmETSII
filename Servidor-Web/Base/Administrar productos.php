<?php
if(isset($usuario) and $usuario["nivel"] == 3){
	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarProducto.php");

	
?>

<?php 

	if(isset($_SESSION["modificar"])){
		unset($_SESSION["modificar"]);
		$id = $_SESSION["OID_PRODUCTO"];
		$nombre = $_SESSION["NOMBRE"];
		$precio = $_SESSION["PRECIO_VENTA"];
		$puntos = $_SESSION["PUNTOS"];
		$receta = $_SESSION["RECETA"];
			
		unset($_SESSION["OID_PRODUCTO"]);
		unset($_SESSION["NOMBRE"]);
		unset($_SESSION["PRECIO_VENTA"]);
		unset($_SESSION["PUNTOS"]);
		unset($_SESSION["RECETA"]);	
?>
		<form method="post" action="./controladores/control_catalogo.php">
			<input class = "OID_PRODUCTO" name="OID_PRODUCTO" type= "hidden" value="<?php echo $id ?>" required/>
			<input  name="modificar" type= "hidden" value="modificar" required/>
			<article>
				<h3><b>Modificar producto</b></h3>
				<label>
					Nombre: 
					<input class = "NOMBRE" name="NOMBRE" type= "text" value="<?php echo $nombre ?>" required/>
				</label>
				<label>
					Precio Venta: 
					<input class = "PRECIO_VENTA" name="PRECIO_VENTA" type= "number" min="1" max = "1000" value="<?php echo $precio ?>" step="0.01" required/>
				</label>
				<label>
					Puntos: 
					<input class = "PUNTOS" name="PUNTOS" type= "number" min = "1" max = "100"  value="<?php echo $puntos ?>" required/>
				</label>
				<label>
					Receta (0 = No, 1 = Si): 
					<input class = "RECETA" name="RECETA" type= "number" min = "0" max = "1" step="1" value="<?php echo $receta ?>" required/>
				</label>
				
				<div class = "boton">
						<button id="modificar" name="modificar" type="submit">
							Modificar
						</button>
				</div>
			</article>
		</form>
		
<?php 	}else{ ?>
		
		<form method="post" enctype="multipart/form-data"  action="./controladores/controlador_producto.php">
			<article>
				<h3><b>Crear producto</b></h3>
				<label>
					Nombre: 
					<input class = "NOMBRE" name="NOMBRE" type= "text" required/>
				</label>
				<label>
					Imagen:
					<input class = "imagen" name="imagen" type= "file" required/>
				</label>
				<label>
					Precio Venta: 
					<input class = "PRECIO_VENTA" name="PRECIO_VENTA" type= "number" min="1" max = "1000" required/>
				</label>
				<label>
					Puntos: 
					<input class = "PUNTOS" name="PUNTOS" type= "number" min = "1" max = "100" required/>
				</label>
				<label>
					Receta (0 = No, 1 = Si): 
					<input class = "RECETA" name="RECETA" type= "number" min = "0" max = "1" step="1" required/>
				</label>
				
				<div class = "boton">
						<button id="crear" name="crear" type="submit">
							Crear
						</button>
				</div>
			</article>
		</form>
		
	<?php } ?>

<?php }else{
	header("Location: ../index.php");
} ?>

