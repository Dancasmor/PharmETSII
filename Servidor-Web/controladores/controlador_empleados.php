<?php
	include_once('../gestores/func_extras.php');
	include_once('../gestores/gestionarEmpleados.php');
	include_once('../gestores/gestionarContacto.php');
	include_once('../Base/gestionBD.php');
	$conexion=crearConexionBD();
	
	$regUsr['TELEFONO']=$_REQUEST['telefono'];
	$regUsr['CORREO']=$_REQUEST['correo'];
	$regUsr['CODIGO_POSTAL']=$_REQUEST['codigoP'];
	$regUsr['DIRECCION']=$_REQUEST['direccion'];
	$regUsr['CIUDAD']=$_REQUEST['ciudad'];
	$regUsr['DNI_EMPLEADO']=$_REQUEST['dni'];
	$regUsr['NOMBRE']=$_REQUEST['nombre'];
	$regUsr['APELLIDOS']=$_REQUEST['apellidos'];
	$regUsr['FECHA_NACIMIENTO']=$_REQUEST['fecha'];
	$regUsr['OID_FARMACIA']=$_REQUEST['farmacia'];
	$regUsr['CONTRASEÑA']=$_REQUEST['contraseña'];
	$regUsr['RCONTRASEÑA']=$_REQUEST['Rcontraseña'];
	$regUsr['CARGO']=$_REQUEST['cargo'];
	
	$contraseñaCorrecta=comprobarContraseñas($regUsr['CONTRASEÑA'],$regUsr['RCONTRASEÑA']);
	
	if($contraseñaCorrecta){
		crear_contacto($conexion, $regUsr['TELEFONO'], $regUsr['CORREO'], $regUsr['DIRECCION'], $regUsr['CODIGO_POSTAL'],$regUsr['CIUDAD']);
		$hoy = date('Y-m-d');
		
		echo(ultimoOidContacto($conexion)."|");
		echo(extraeEmpresa($conexion));
		if($regUsr['OID_FARMACIA']=='vacio'){
			crearEmpleadoEmpresa($conexion,$regUsr['DNI_EMPLEADO'],$regUsr['NOMBRE'],$regUsr['APELLIDOS'],$regUsr['FECHA_NACIMIENTO']
			,ultimoOidContacto($conexion),$hoy,extraeEmpresa($conexion),$regUsr['CONTRASEÑA'],$regUsr['CARGO']);
		}else{
			echo($regUsr['OID_FARMACIA']);
			crearEmpleadoFarmacia($conexion,$regUsr['DNI_EMPLEADO'],$regUsr['NOMBRE'],$regUsr['APELLIDOS'],$regUsr['FECHA_NACIMIENTO']
			,ultimoOidContacto($conexion),$hoy,$regUsr['OID_FARMACIA'],$regUsr['CONTRASEÑA'],$regUsr['CARGO']);
		}
		Header('Location: ../index.php?tituloPag=Portada');
	}else{
		Header('Location: ../index.php?tituloPag=Error registro');
	}
	
	
	cerrarConexionBD($conexion);
?>
