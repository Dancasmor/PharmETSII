<?php
	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarNominas.php");
	
	$conexion = crearConexionBD();
	$dniEmpleado = $_REQUEST["dniEmpleado"];
	$filas = consultarNominasPorDNI($conexion, $dniEmpleado);
	$grado = $usuario['grado'];
	cerrarConexionBD($conexion);
?>
<div>
	<?php 
		if($grado >= 5){?>
	
			<!-- Crear nomina-->
	<form method="post" action="./controladores/controlador_nominas.php">
	<article>
		<h3><b>Crear nomina</b></h3>
		
		<label>
			<input id = "form_nomina_empleado" name="DNI_EMPLEADO" type= "text"
			pattern="^[0-9]{8}[A-Z]{1}$" title="8 caractéres en mayúscula y 1 dígito" value = "<?php echo $dniEmpleado?>" readonly required/>
		</label>
		
		<label>
			Salario base: 
			<input id = "SALARIO_BASE" name="SALARIO_BASE" type= "number" min="1" max="9999" step = "0.01" required/>
		</label>
		
		<label>
			Salario variable: 
			<input id = "SALARIO_VARIABLE" name="SALARIO_VARIABLE" type= "number" min="0" max="2000" step = "0.01" required/>
		</label>
		
		<label>
			Fecha: 
			<input id = "form_fecha_nomina" name="FECHA" type= "date" required/>
		</label>

		<div id="boton">
				<button id="crear_nomina" name="crear_nomina" type="submit">
					Crear
				</button>
		</div>
	</article>
	</form>
		<?php }
	?>
</div>
<div><h2>Nóminas del empleado con DNI: <?php echo $dniEmpleado?></h2></div>

<div class="grid-container">
	
	<?php
		foreach($filas as $fila) {
			$salarioBase = str_replace(",", ".", $fila["SALARIO_BASE"]);
			$salarioVariable = str_replace(",", ".", $fila["SALARIO_VARIABLE"]);
			$salarioTotal = $salarioBase + $salarioVariable;
			$oidNomina = $fila["OID_NOMINA"];
			
	?>

	<article class="nomina">
		<div class="fila_nomina2">
			<div class="datos_nomina">		
				<div class ="grid-item">
					<div class = "fila_nomina3">
						<div><h1><?php echo $fila["FECHA"]?></h1></a></div>
						<div>Salario total = <?php echo $salarioTotal?>€</div>	
						<div>(Base: <?php echo $salarioBase?>€)</div>
						<div>(Variable: <?php echo $salarioVariable?>€)</div>
						<div><?php
							if($fila["COBRADA"] == 0){?>
								Pendiente de cobro
								<div>
									<form method="post" action="./controladores/controlador_nominas.php">
										<input type="hidden" name = "OID_NOMINA" value = "<?php echo $oidNomina?>" />
									<button id="cobrar" name="cobrar" type="submit">
										Cobrar
									</button>
									</form>
								</div><?php		
							} else{?>
								Cobrada correctamente<?php
							}
							?></div>
					</div>					
				</div>				
			</div>
		</div>
	</article>
	<?php }?>
	
</div>