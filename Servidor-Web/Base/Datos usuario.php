	<h2 id='udr_dt'>Datos sobre el usuario</h2>

<div id='datos_usuario'>
	
	<?php 
		$usuario=$_SESSION['usuario'];
	
	if(isset($_SESSION['usuario']['DNI_USUARIO'])){?>
		<div>
		<label>DNI:
			<?php echo($usuario['DNI_USUARIO'])?>
		</label>
		
		<label>Nombre:
			<?php echo($usuario['NOMBRE'])?>
		</label>
		
		<label>Apellidos:
			<?php echo($usuario['APELLIDOS'])?>
		</label>
		</div>
		</br>
		<div>
		<label>Fecha de nacimiento:
			<?php echo($usuario['FECHA_NACIMIENTO'])?>
		</label>
	
		<label>Fecha de ALTA:
			<?php echo($usuario['FECHA_ALTA_SISTEMA'])?>
		</label>
		</div>
		</br>
		<div>
		<label>Puntos acumulados:
			<?php echo($usuario['PUNTOS'])?>
		</label>
	
		<label>Peso:
			<?php echo($usuario['PESO'])?>
		</label>
		
		<label>Altura:
			<?php echo($usuario['ALTURA'])?>
		</label>
		</div>
		</br>
		<div id='imc'>
		<label>Su IMC:
			<?php 
				if($usuario['ALTURA']>4) $altura2=$usuario['ALTURA']/100;
				else $altura2 =$usuario['ALTURA'];
				$imc=$usuario['PESO']/($altura2*$altura2);
				echo($imc." ");
				if($imc<18.5) echo('infrapeso');
				else if($imc<24.9)echo('Peso normal');
				else if($imc<29.9)echo('Sobrepeso'); 
				else if($imc<34.9)echo('Obesidad tipo1');
				else if($imc<39.9)echo('Obesidad tipo2');
				else if($imc>=39.9)echo('Obesidad tipo2');
			
			?>
		</label>
		
		</div>
	
	
	<?php }else if($_SESSION['usuario']['DNI_EMPLEADO']){?>
			<div>
		<label>DNI:
			<?php echo($usuario['DNI_EMPLEADO'])?>
		</label>
		
		<label>Nombre:
			<?php echo($usuario['NOMBRE'])?>
		</label>
		
		<label>Apellidos:
			<?php echo($usuario['APELLIDOS'])?>
		</label>
		</div>
		</br>
		<div>
		<label>Fecha de nacimiento:
			<?php echo($usuario['FECHA_NACIMIENTO'])?>
		</label>
	
		<label>Fecha de ALTA:
			<?php echo($usuario['FECHA_ALTA_SISTEMA'])?>
		</label>
		</div>
		</br>
		<div>
		<label>Cargo:
			<?php echo($usuario['CARGO'])?>
		</label>
		
		<?php }else if($_SESSION['usuario']['NOMBRE_LAB']){?>
		
		<label>Nombre:
			<?php echo($usuario['NOMBRE_LAB'])?>
		</label>
		
		<label>Precio para envio sin gastos:
			<?php echo($usuario['PRECIO_ENVIO_SIN_GASTOS'])?>
		</label>
		
		<?php } ?>
</div>