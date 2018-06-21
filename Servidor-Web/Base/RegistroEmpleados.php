<?php
	require_once('./gestores/gestionarFarmacias.php');
	require_once('./Base/gestionBD.php');

?>	
	
	<div id="div_error">
		<p id='error_existe_dni_emp'></p>
		<p id='error_contacto_empresa'></p>
		<p id='error_existe_contacto_empresa'></p>
		<p id='error_existe_oid_empresa'></p>
		<p id='error_fecha_nac_emp'></p>
		<p id='error_contrasenya_empleado'></p>
		<p id='error_confirmacion_contrasenya_empleado'></p>
		<p id='error_dni_empleado'></p>
		<p id='error_fecha_alta_emp'></p>
	</div>

			<!-- Crear empleados empresa-->
	<form method="post" action="./controladores/controlador_empleados.php" id="formulario_usr" >
	<article>
		<h3 id="titulo_regus" class="espacio"><b>Crear empleado </b></h3>
		
		<label>
			Dni empleado: 
			<input id = "form_dni_empleado_emp" name="dni" type= "text" size="9" placeholder="12345678X"
			 title="8 caractéres en mayúscula y 1 dígito" pattern='^[0-9]{8,8}[A-Za-z]$' required/>
		</label>
		
		<label>
			Nombre: 
			<input id = "NOMBRE" name="nombre" type= "text" pattern='^[a-zA-Z]*$' required/>
		</label>
		
		<label>
			Apellidos: 
			<input id = "APELLIDOS" name="apellidos" pattern='^[a-zA-Z ]*$' type= "text" required/>
		</label>
		
		<label>
			Fecha nacimiento: 
			<input id = "form_fecha_nacimiento_emp" name="fecha" type= "date" max=<?php echo date('Y-m-d')?> required/>
		</label>
		<div>
			<br />
		<label>
			Contraseña: 
			<input id = "contraseña_usuario" name="contraseña" type= "password" size="26" 
			title="La contraseña debe contener un mínimo de 8 caractéres y, al menos un dígito y una mayuscula"
			placeholder="Mínimo de 8 carácteres y dígitos" pattern='^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$' required/>
		</label>
		
		<label>
			Confirmar Contraseña: 
			<input id = "Rcontraseña_usuario" name="Rcontraseña" type= "password"  size="22" 
			placeholder="Confirmación de contraseña" pattern='^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$' required/>
		</label>
		
		<label>
			Cargo: 
			<select name="cargo">
			<?php if($grado==7){ ?>
				<option value="DIRECTOR">DIRECTOR</option>
				<option value="SUBDIRECTOR">SUBDIRECTOR</option>
				<option value="PERSONAL_ADMINISTRATIVO">PERSONAL_ADMINISTRATIVO</option>
			<?php }?>
				<option value="JEFE_ENCARGADO_ALMACEN">JEFE_ENCARGADO_ALMACEN</option>
				<option value="ENCARGADO_ALMACEN">ENCARGADO_ALMACEN</option>
				<option value="EMPLEADOS_ALMACEN">EMPLEADOS_ALMACEN</option>
				<option value="GERENTE">GERENTE</option>
				<option value="EMPLEADOS_ALMACEN">EMPLEADOS_ALMACEN</option>
				<option value="ENCARGADO_TIENDA">ENCARGADO_TIENDA</option>
			</select>
		
		</label>
		
		<label>Farmacia:
			<select name="farmacia">
				<option label='NINGUNA' value='vacio'></option>
				<?php 
					$conexion=crearConexionBD();
					$fililla = consultarTodasFarmacias($conexion);
					foreach($fililla as $ped){
						echo "<option label='".$ped['NOMBRE']."' value='".$ped['OID_FARMACIA']."'></option>";
					}
					cerrarConexionBD($conexion);
				?>
			</select>
		</label>
		</div>
		
		<br />
		<div id='datosSecundariosE'>
			<label>Correo electronico:
				<input type='email' id='correo_usuario' name='correo' size='20' required/>
			</label>
			<label>Telefono:
				<input type='number' min='100000000' max='1000000000' id='telefono_usuario' name='telefono' size='10' required/>
			</label>
			<label>Direccion:
				<input type='text' id='direccion_usuario' name='direccion' size='20' required/>
			</label>
			<label>Código postal:
				<input type='number' min='0' max='100000' id='codigoP_usuario' name='codigoP' size='10' required/>
			</label>
			<label>Provincia:
				<select id='ciudad_usuario' name='ciudad' required>
					<?php include_once('./controladores/provincias.php')?>
				</select>
			</label>
		</div>
		
		<div id="boton">
				<button id="crear_empleado_empresa" name="crear_empleado_empresa" type="submit">
					Crear
				</button>
		</div>
	</article>
	</form>