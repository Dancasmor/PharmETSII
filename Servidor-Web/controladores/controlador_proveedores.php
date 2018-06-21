<?php
	include_once('../gestores/func_extras.php');
	include_once('../gestores/gestionarContacto.php');
	include_once('../Base/gestionBD.php');
	$conexion=crearConexionBD();
	
	$regUsr['TELEFONO']=$_REQUEST['telefono'];
	$regUsr['CORREO']=$_REQUEST['correo'];
	$regUsr['CODIGO_POSTAL']=$_REQUEST['codigoP'];
	$regUsr['DIRECCION']=$_REQUEST['direccion'];
	$regUsr['CIUDAD']=$_REQUEST['ciudad'];
	$regUsr['NOMBRE_LAB']=$_REQUEST['nombre_lab'];
	$regUsr['PRECIO_ENVIO_SIN_GASTOS']=$_REQUEST['precio_envio'];
	$regUsr['CONTRASEÑA']=$_REQUEST['contraseña'];
	$regUsr['RCONTRASEÑA']=$_REQUEST['Rcontraseña'];
	
	$contraseñaCorrecta=comprobarContraseñas($regUsr['CONTRASEÑA'],$regUsr['RCONTRASEÑA']);
	
	if($contraseñaCorrecta){
		crear_contacto($conexion, $regUsr['TELEFONO'], $regUsr['CORREO'], $regUsr['DIRECCION'], $regUsr['CODIGO_POSTAL'],$regUsr['CIUDAD']);
		$hoy = date('Y-m-d');
		echo(ultimoOidContacto($conexion)."|");
		echo($regUsr['NOMBRE_LAB']."|");
		echo($regUsr['PRECIO_ENVIO_SIN_GASTOS']."|");
		echo($regUsr['CONTRASEÑA']."|");
		echo(crearProveedor($conexion,$regUsr['NOMBRE_LAB'],$regUsr['PRECIO_ENVIO_SIN_GASTOS'],ultimoOidContacto($conexion),$regUsr['CONTRASEÑA']));
		
		Header('Location: ../index.php?tituloPag=Portada');
	}else{
		Header('Location: ../index.php?tituloPag=Error registro');
	}
	
	
	cerrarConexionBD($conexion);
?>