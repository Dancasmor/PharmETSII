			<div class="grid-container">
<?php if($nivel==3 && $grado>=6){ ?>
	
		
			<form method="post" action="./Base/Perfil.php">
				<div class="grid-item">
					Acceder a datos de mi
					<a href="?tituloPag=Datos usuario">perfil</a>
				</div>
				<div class="grid-item">
					Registro de
					<a href="?tituloPag=RegistroProveedores">proveedores</a>
				</div>
				<div class="grid-item">
					Registro de
					<a href="?tituloPag=RegistroEmpleados">empleados</a>
				</div>
			</form>	
		
		
<?php } else if($nivel==3 && $grado==5){ ?>
				
					<form method="post" action="./Base/Perfil.php">
						<div class="grid-item">
							Acceder a datos de mi
							<a href="?tituloPag=Datos usuario">perfil</a>
						</div>
						<div class="grid-item">
							Registro de
							<a href="?tituloPag=RegistroEmpleados">empleados</a>
						</div>
					</form>	
				
		
			
<?php }else if($nivel==2){ ?>
					<form method="post" action="./Base/Perfil.php">
						<div class="grid-item">
							Mis 
							<a href="?tituloPag=Perfil">pedidos</a>
						</div>
					</form>	
				
			
<?php } else { ?>
		
					<div class="grid-item">
						Acceder a datos de mi
						<a href="?tituloPag=Datos usuario">perfil</a>
					</div>
			
	
<?php }

	if($nivel == 3){  ?>
		
		
					<div class="grid-item">
						Acceder a <a href="?tituloPag=Perfil"> documentos </a>
					</div>
			
		
	<?php }

 ?>


</div>

