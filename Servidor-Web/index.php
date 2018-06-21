<?php
	include_once ("./Base/logica_principal.php");
?>

<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
  		<title><?php echo $tituloPag ?></title>
 		<?php
			include_once ("./Base/importaciones.php");
		?>
 		
	</head>

	<body>
		
		<header id="cabecera">
			
			<div id="portada">
				<div id="icono"><img id="logo_principal" src="./images/logo.png" /></div>
			</div>
			
			<div id="controladorSesiones">
				<div id="sesion"></div>
				<div id="vistas"></div>
			</div>
			
		</header>
		
		<nav id="menu">
			<?php include_once("./Base/menu.php");?>
		</nav>
		
		<main>
			
			<div id="contenidoPrincipal">
				<?php include_once($pagina); ?>
			</div>
			
		</main>
		
		<footer id="pie">
			<?php include_once("./Base/footer.php");?>
		</footer>
		
	</body>
</html>