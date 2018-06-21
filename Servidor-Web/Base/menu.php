<ul id="menu_ul">
			  <li class="menu_li"><a href="?tituloPag=Portada">Principal</a></li>
			  <li class="menu_li"><a href="?tituloPag=Catalogo">Catálogo</a></li>
			  <li class="menu_li"><a href="?tituloPag=Informacion">Nuestras farmacias</a></li>
			  <form action="./controladores/control_catalogo.php">
			  <li class="menu_li"><input id="busqueda_producto" name="busqueda_producto" placeholder="Buscar producto" type="text" /> </li>
			  </form>
			  <?php
			  	if($login == 0){
			  ?>
				  <li class="menu_li2">
				  	<a id="login_button" onclick="document.getElementById('id01').style.display='block'">Login</a>
				  	<div id="id01" class="modal">
	  					<form class="modal-content animate" action="./controladores/control_login.php">
	    				<div class="imgcontainer">
	      					<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
	      					<img src="./images/avatar.png" alt="Avatar" class="avatar">
	    				</div>
						<div class="container">
	      					<label for="uname"><b>Usuario</b></label>
								<input type="hidden" id='login' name="login" required>
	      						<input type="text" id='usuario_login' name="usuario_login" required>
	      						<label for="contraseña"><b>Contraseña</b></label>
	      						<input type="password" id='contraseña_login' name="contraseña_login" required>
	        					<button type="submit" id="login" name="login">Login</button>
								<a href='?tituloPag=Registro usuarios' id='registrate'>¡Regístrate!</a>
	    				</div>
	  					</form>
					</div>
				  </li>
				<?php
				}else{?>
					<li class="menu_li2"><a href="./Base/logout.php">Log out</a></li>
					<li class="menu_li2"><a href="?tituloPag=Usuario">Usuario</a></li>
				<?php	
				if($nivel == 3){
				?>
					<li class="menu_li2"><a href="?tituloPag=Farmacia">Farmacia</a></li>
				<?php
				}?>	
					<li class="menu_li2"><a href="?tituloPag=Pedidos usuario"><img src="./images/bolsa.png" /></a></li>
				<?php }
				?>
			</ul>

<script>
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>