<?php
	include_once("./gestores/func_extras.php");
	include_once("./base/gestionBD.php");
	require_once("./base/paginacion_consulta.php");
	include_once("./gestores/funciones_catalogo.php");
	
	////////////////////////Propiedades de ajuste de la paginacion///////////////////////
	$defectoNpag=1;
	$defectoNmuestra=25;
	/////////////////////////////////////////////////////////////////////////////////////
	
	
	if (isset($_SESSION['usuario'])){
		$usuario=$_SESSION['usuario'];
	}
	if (isset($_SESSION['paginar'])){
		$paginar=$_SESSION['paginar'];
	}

	$conexion = crearConexionBD();
	if(isset($_SESSION['buscar'])){
		$busca=$_SESSION['buscar'];
		unset($_SESSION['buscar']);
		$filas=consultarProductoNombreB($conexion, $busca);
	}else{
			$query = "SELECT * FROM PRODUCTO";
		if(isset($paginar['nPagina']) && isset($paginar['nMuestra'])){
			$filas=consulta_paginada($conexion, $query, $paginar['nPagina'], $paginar['nMuestra']);
		}else if(isset($paginar['nMuestra'])){
			$filas=consulta_paginada($conexion, $query, $defectoNpag, $paginar['nMuestra']);
		}else{
			$filas = consultarTodosProductosB($conexion);
		}
		
	}
	
	cerrarConexionBD($conexion);
?>

<div id="controles">
	<a onclick="cambioGrid()"><img id='grid_icon' class="grid_icon" src="./images/grid1.png" /></a>
	<a onclick="cambioGrid2()"><img id="grid_icon2" src="./images/grid2.png" /></a>
	<!-------------------------Paginacion--------------------------------->
	<form method="get"action="./controladores/control_catalogo.php">
		<div class="paginacion">
			<?php if (isset($paginar['nMuestra'])){ ?>
			<p>Pag nº:</p>
			<select id="nPagina" name="nPagina">
				<?php 
				if(isset($paginar['nMuestra'])){
					if(cuenta(consultarTodosProductosB($conexion))%$paginar['nMuestra']>0){
						$sum = 1;
					}else{$sum = 0;}
					for($i=1;$i<=cuenta(consultarTodosProductosB($conexion))/$paginar['nMuestra']+$sum;$i=$i+1){
						if($i==$paginar['nPagina']){
							$re="selected";
						}else{$re="";}
						echo "<option value=".$i." ".$re.">".$i."</option>";
					}
				}else{
					for($i=1;$i<=cuenta(consultarTodosProductosB($conexion))/$defectoNmuestra;$i=$i+1){
						echo "<option value=".$i." ".$re.">".$i."</option>";
					}
				}
				?>
			</select>
			<?php }?>
			<p>Muestras:</p>
			<select id="nMuestra" name="nMuestra">
				<?php 
					for($i=1;$i<=$defectoNmuestra;$i++){
						if($i==$paginar['nMuestra']){
							$re="selected";
						}else{$re="";}
						echo "<option value=".$i." ".$re.">".$i."</option>";
					}
				?>
			</select>
			<button id="paginacion" name="paginacion" type="submit">Ordena</button>
		</div>
	</form>
	

	<?php if(isset($busca)){echo "<p>Mostrando similitudes con: ".$busca."</p>";
							echo "<form><button href='?tituloPag=Catalogo'>Limpiar</button></form>";	}?>
							
	<?php if(isset($usuario['DNI_EMPLEADO'])){
							echo "<a id='adm' href='?tituloPag=Administrar productos'>Administrar productos</a>";	}?>
		
</div>

<div class="catalogo" id='catalogo'>
	
<?php $conexion=crearConexionBD();
		foreach($filas as $fila) {
	 if(tieneStock($conexion, $fila['OID_PRODUCTO'])){?>
	
	<form id="producto_catalogo" method="post" action="./controladores/control_catalogo.php">	
				<!--CAMPO PARA ENVIAR EL OID-->
				<input id=="OID_PRODUCTO" name="OID_PRODUCTO" type="hidden" value="<?php echo $fila["OID_PRODUCTO"];?>" />
				<input id=="NOMBRE" name="NOMBRE" type="hidden" value="<?php echo $fila["NOMBRE"];?>" />
				<input id=="PRECIO_VENTA" name="PRECIO_VENTA" type="hidden" value="<?php echo $fila["PRECIO_VENTA"];?>" />
				<input id=="PUNTOS" name="PUNTOS" type="hidden" value="<?php echo $fila["PUNTOS"];?>" />
				<input id=="URL_IMAGENES" name="URL_IMAGENES" type="hidden" value="<?php echo $fila["URL_IMAGENES"];?>" />
				<input id=="RECETA" name="RECETA" type="hidden" value="<?php echo $fila["RECETA"];?>" />
				
				<div id='imagen_grid'>
					<img id="imagen_producto" src=<?php echo $fila['URL_IMAGENES'];?> />
				</div>
				
				<div id="texto_producto">
					<em class="tx" id="Precio"><?php echo $fila["PRECIO_VENTA"]."€";?></em>
					<em class="tx" id="Nombre" ><?php echo $fila["NOMBRE"];?></em>
					<em class="tx" id="Receta"><?php if($fila["RECETA"]==1) echo('Con receta');else echo('Sin receta')?></em>
				
				</div>
				<div id="boton_añadir">
					<?php if(isset($_SESSION['login']) && !isset($usuario['OID_PROVEEDOR'])){ ?>
					<button id="añadir_catalogo" name="añadir_catalogo" type="submit" class="añadir_catalogo">
						<img src="./images/añadirCatalogo.png" id="im" alt="Añadir" width="20" height="20">
					</button>
					<?php } ?>
					<?php if(isset($usuario['DNI_EMPLEADO'])){ ?>
					<button id="editar_producto" name="editar_producto" type="submit" class="editar_producto">
						<img src="./images/editar.png" id="im2" alt="Editar" width="20" height="10">
					</button>
					<?php } ?>
				</div>
				
	</form>
<?php }}cerrarConexionBD($conexion);?>
</div>
