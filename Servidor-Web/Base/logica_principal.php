<?php
    session_start();
	
	//Primero comprobamos si el usuario está conectado
	if(isset($_SESSION["login"])){
		//Almacenamos el estado de login con una variable
		$login = 1;
		//Obtenemos todos los datos del usuario
		$usuario = $_SESSION["usuario"];
		//Obtenemos que nivel de la jerarquía de privilegios tiene el usuario, en caso de empleado, su grado
		$nivel = $usuario["nivel"];
		
		/*
		 * niveles de privilegios:
		 * 	+visitante (no usuario) = 0
		 *  +usuario (cliente) = 1
		 *  +proveedor = 2
		 *  +empleado = 3 => diferentes grado
		 * 		'DIRECTOR','SUBDIRECTOR' = 7
		 * 		'JEFE_ENCARGADO_ALMACEN' = 6
           		'GERENTE' = 5
		 * 		'PERSONAL_ADMINISTRATIVO' = 4
		 * 		'ENCARGADO_ALMACEN' = 3
           		'EMPLEADOS_ALMACEN' = 2
		 * 		'ENCARGADO_TIENDA' = 1
		 * 
		 */
		 
		if($nivel == 3){
			$grado = $usuario["grado"];
		}
		
	}else{
		$login = 0;
		$nivel = 0;
	}
	 
	//Una vez identificado al tipo de usuario, vamos a comprobar que pagina hay que visualizar
	//Comprobamos si quiere cambiar de página o mantenerse en la misma
	if(isset($_GET["tituloPag"])){
		$tituloPag = $_GET["tituloPag"];
	}else{
		if(isset($_SESSION["tituloPag"])){
			$tituloPag = $_SESSION["tituloPag"];
		}else{
			$tituloPag = "Portada";
		}
	}
	$_SESSION["pagina"] = $tituloPag;
	$pagina = "./Base/". $tituloPag . ".php";
?>