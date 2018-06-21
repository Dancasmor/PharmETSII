<div id="div_error">
		<p id='error_prov_lab'></p>
		<p id='error_existe_contacto_proveedor'></p>
		<p id='error_contacto_proveedor'></p>
		<p id='error_contrasenya_proveedor'></p>
		<p id='error_confirmacion_contrasenya_proveedor'></p>
	</div>
	<!-- Crear proveedor-->
	<form method="post" action="./controladores/controlador_proveedores.php" id="formulario_usr">
	<article>
		<h3 id="titulo_regus" class="espacio"><b>Crear proveedor</b></h3>
		<label>
			Nombre laboratorio: 
			<input id = "form_prov_lab" name="nombre_lab" type= "text" required/>
		</label>
		<label>
			Precio envio sin gastos: 
			<input id = "PRECIO_ENVIO_SIN_GASTOS" name="precio_envio" min="1" max="3000" type= "number" required/>
		</label>
		<br /><br />
		<div>
			
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
	</article>
		<div id="boton">
				<button id="crear" name="crear" type="submit">
					Crear
				</button>
		</div>
	</form>