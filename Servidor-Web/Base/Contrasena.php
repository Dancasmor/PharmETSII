
	<div id="div_error">
		<p id='error_cambiar_contraseña'></p>
		<p id='error_cambiar_contraseña_confirmacion'></p>
	</div>
	
	<h2>Cambiar contraseña</h2>
	<form method="post" action="./acciones/accion_cambiar_contrasena.php">
		<label>
			Contraseña: 
			<input id = "form_pass" name="CONTRASEÑA" type= "password" size="26" 
			title="La contraseña debe contener un mínimo de 8 caractéres y, al menos un dígito y una mayuscula"
			placeholder="Mínimo de 8 carácteres y dígitos" oninput="validar_contraseña();" required/>
		</label>
		<label>
			Confirmar Contraseña: 
			<input id = "form_confirmpass" name="CONFIRMACION_CONTRASEÑA" type= "password"  size="22" 
			placeholder="Confirmación de contraseña" oninput="validar_confirmacion_contraseña();" required/>
		</label>
		<div id="boton">
				<button id="cambiar" name="cambiar" type="submit">
					Cambiar
				</button>
		</div>
	</form>