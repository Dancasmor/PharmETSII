<?php
	include_once('../gestores/func_extras.php');
	include_once('../gestores/gestionarUsuario.php');
	include_once('../gestores/gestionarContacto.php');
	include_once('../Base/gestionBD.php');
	$conexion=crearConexionBD();
	
	$regUsr['TELEFONO']=$_REQUEST['telefono'];
	$regUsr['CORREO']=$_REQUEST['correo'];
	$regUsr['CODIGO_POSTAL']=$_REQUEST['codigoP'];
	$regUsr['DIRECCION']=$_REQUEST['direccion'];
	$regUsr['CIUDAD']=$_REQUEST['ciudad'];
	$regUsr['DNI_USUARIO']=$_REQUEST['dni'];
	$regUsr['NOMBRE']=$_REQUEST['nombre'];
	$regUsr['APELLIDOS']=$_REQUEST['apellidos'];
	$regUsr['FECHA_NACIMIENTO']=$_REQUEST['fecha'];
	$regUsr['CONTRASEÑA']=$_REQUEST['contraseña'];
	$regUsr['RCONTRASEÑA']=$_REQUEST['Rcontraseña'];
	$regUsr['PESO']=$_REQUEST['peso'];
	$regUsr['ALTURA']=$_REQUEST['altura'];
	
	$contraseñaCorrecta=comprobarContraseñas($regUsr['CONTRASEÑA'],$regUsr['RCONTRASEÑA']);
	
	if($contraseñaCorrecta){
		crear_contacto($conexion, $regUsr['TELEFONO'], $regUsr['CORREO'], $regUsr['DIRECCION'], $regUsr['CODIGO_POSTAL'],$regUsr['CIUDAD']);
		$hoy = date('Y-m-d');
		
		echo(ultimoOidContacto($conexion)."|");
		echo(extraeEmpresa($conexion));
		
		crear_usuario($conexion, $regUsr['DNI_USUARIO'], $regUsr['NOMBRE'], $regUsr['APELLIDOS'], $regUsr['FECHA_NACIMIENTO'],
		ultimoOidContacto($conexion), $hoy, extraeEmpresa($conexion), $regUsr['CONTRASEÑA'] ,0, $regUsr['PESO'], $regUsr['ALTURA']);
		Header('Location: ../index.php?tituloPag=Portada');
	}else{
		Header('Location: ../index.php?tituloPag=Error registro');
	}
	
	
	cerrarConexionBD($conexion);
?>