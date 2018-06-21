<?php
/*	DATOS A REQUERIR DEL FORMULARIO
	-CONTACTO
		OID_CONTACTO
		*TELEFONO
		*EMAIL
		*DIRECCION
		*CODIGO_POSTAL
		*CIUDAD
	-USUARIO
		*DNI_USUARIO
		*NOMBRE
		*APELLIDOS
		*FECHA_NACIMIENTO
		FECHA_ALTA_SISTEMA
		FECHA_BAJA_SISTEMA
		*CONTRASENYA
		PUNTOS
		*PESO
		*ALTURA
		OID_EMPRESA
		OID_CONTACTO

*/	
?>

<p id='titulo_regus'>Registro de usuario</p>

<form id='formulario_usr' action='./controladores/controlador_registro_usuario.php'>
	<div id="datos_online">
		<div id="datos_personales">
			<label>Nombre:
				<input type='text' id='nombre_usuario' name='nombre' pattern='^[a-zA-Z]*$' size='10' required/>
			</label>
			<label>Apellidos:
				<input type='text' id='apellidos_usuario' name='apellidos' pattern='^[a-zA-Z ]*$' size='20' required/>
			</label>
			<label>DNI:
				<input type='text' id='dni_usuario' pattern='^[0-9]{8,8}[A-Za-z]$' name='dni' size='10' required/>
			</label>
			<label>Fecha de nacimiento:
				<input type='date' id='fecha_usuario' max=<?php echo date('Y-m-d'); ?> name='fecha' size='10' required/>
			</label>
		</div>
		</br>
		<div>
			<p><em>Con fines de utilidad requerimos sus datos fisicos:</em></p>
			<label>Peso:
				<input type='number' step='0.1' min='1' max='300' id='peso_usuario' name='peso' size='1' required/>kg
			</label>
			<label>Altura:
				<input type='number' step='0.01' min='100' max='350'id='altura_usuario' name='altura' size='1' required/>cm
			</label>
		</div>
		
		
		</br>
		
		<div id='datosSecundarios'>
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
		</br>
		<p><em>Puede iniciar sesion tanto como con su DNI como con su CORREO ELECTRONICO con esta contraseña:</em></p>
		<div>
			<label>Contraseña:
				<input type='password' pattern='^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$' id='contraseña_usuario' name='contraseña' size='20' required/>
			</label>
			
			<label>Repite contraseña:
				<input type='password' pattern='^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$' id='Rcontraseña_usuario' name='Rcontraseña' size='20' required/>
			</label>
		</div>
		<p><em>longitud de 8 caracteres, letras y numeros</em></p>
		</br>
		
		<button type='submit'>Enviar datos</button>
	
	
	

	</div>
	
	
	
	
	
	
	
</form>