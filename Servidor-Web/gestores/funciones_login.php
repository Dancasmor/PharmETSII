<?php

	function comprobarLogin($conexion, $usuario, $contraseña){
		
		//DEVUELVE '0' SI NO COINCIDE EL USUARIO, '1' SI COINCIDE USUARIO Y PERO NO LA CONTRASEÑA, 
		//DEVUELVE EL 'TIPO:proveedor|usuario|empleado' SI HACE LOGIN

		//COMPRUEBA QUE EXISTA EL USUARIO
		if(compruebaContacto($conexion,$usuario) || compruebaUsuarioDNI($conexion,$usuario) 
			|| compruebaProveedorDNI($conexion,$usuario) || compruebaEmpleadoDNI($conexion,$usuario)){
			
			//COMPRUEBA DONDE SE ENCUENTRA LA CONTRASEÑA
			if(compruebaContraseñaProveedor($conexion,$usuario,$contraseña)){
				return "proveedor";
			}else if(compruebaContraseñaUsuario($conexion,$usuario,$contraseña)){
				return "usuario";
			}else if(compruebaContraseñaEmpleado($conexion,$usuario,$contraseña)){
				return "empleado";
			}else{
				return 1;
			}
		}else{
			return 0;
		};
	}
	
	function rescataUSUARIO($conexion, $usuariop){
		$consultaContacto = "SELECT count(*) FROM CONTACTO WHERE EMAIL='".$usuariop."'";
		
		if($conexion->query($consultaContacto)->fetch()[0]>0){
			$consulta= "SELECT OID_CONTACTO FROM CONTACTO WHERE EMAIL='".$usuariop."'";
			$oid=  $conexion->query($consulta)->fetch()[0];
			$resultado = "SELECT * FROM USUARIO WHERE OID_CONTACTO=".$oid;
		}else{
			$resultado = "SELECT * FROM USUARIO WHERE DNI_USUARIO='".$usuariop."'";
		}
		
		$usuario["DNI_USUARIO"] = $conexion->query($resultado)->fetch()[0];
		$usuario['NOMBRE']=$conexion->query($resultado)->fetch()[1];
		$usuario['APELLIDOS']=$conexion->query($resultado)->fetch()[2];
		$usuario['FECHA_NACIMIENTO']=$conexion->query($resultado)->fetch()[3];
		$usuario['FECHA_ALTA_SISTEMA']=$conexion->query($resultado)->fetch()[4];
		$usuario['FECHA_BAJA_SISTEMA']=$conexion->query($resultado)->fetch()[5];
		$usuario['CONTRASENYA']=$conexion->query($resultado)->fetch()[6];
		$usuario['PUNTOS']=$conexion->query($resultado)->fetch()[7];
		$usuario['PESO']=$conexion->query($resultado)->fetch()[8];
		$usuario['ALTURA']=$conexion->query($resultado)->fetch()[9];
		$usuario['OID_EMPRESA']=$conexion->query($resultado)->fetch()[10];
		$usuario['OID_CONTACTO']=$conexion->query($resultado)->fetch()[11];
		$usuario['nivel'] = 1;
		$_SESSION['usuario']=$usuario;
	}
	function rescataEMPLEADO($conexion, $usuariop){
		$consultaContacto = "SELECT count(*) FROM CONTACTO WHERE EMAIL='".$usuariop."'";
		
		if($conexion->query($consultaContacto)->fetch()[0]>0){
			$consulta= "SELECT OID_CONTACTO FROM CONTACTO WHERE EMAIL='".$usuariop."'";
			$oid=  $conexion->query($consulta)->fetch()[0];
			$resultado = "SELECT * FROM EMPLEADO WHERE OID_CONTACTO=".$oid;
		}else{
			$resultado = "SELECT * FROM EMPLEADO WHERE DNI_EMPLEADO='".$usuariop."'";
		}
			
		$usuario['DNI_EMPLEADO']= $conexion->query($resultado)->fetch()[0];
		$usuario['NOMBRE']=$conexion->query($resultado)->fetch()[1];
		$usuario['APELLIDOS']=$conexion->query($resultado)->fetch()[2];
		$usuario['FECHA_NACIMIENTO']=$conexion->query($resultado)->fetch()[3];
		$usuario['FECHA_ALTA_SISTEMA']=$conexion->query($resultado)->fetch()[4];
		$usuario['FECHA_BAJA_SISTEMA']=$conexion->query($resultado)->fetch()[5];
		$usuario['CARGO']=$conexion->query($resultado)->fetch()[6];
		$usuario['CONTRASENYA']=$conexion->query($resultado)->fetch()[7];
		$usuario['OID_FARMACIA']=$conexion->query($resultado)->fetch()[8];
		$usuario['OID_EMPRESA']=$conexion->query($resultado)->fetch()[9];
		$usuario['OID_CONTACTO']=$conexion->query($resultado)->fetch()[10];
		$usuario['grado'] = gradoEMPLEADO($usuario['CARGO']);
		$usuario['nivel'] = 3;
		$_SESSION['usuario']=$usuario;
	}

	function rescataPROVEEDOR($conexion, $usuariop){
		$consultaContacto = "SELECT count(*) FROM CONTACTO WHERE EMAIL='".$usuariop."'";
		
		if($conexion->query($consultaContacto)->fetch()[0]>0){
			$consulta= "SELECT OID_CONTACTO FROM CONTACTO WHERE EMAIL='".$usuariop."'";
			$oid=  $conexion->query($consulta)->fetch()[0];
			$resultado = "SELECT * FROM PROVEEDOR WHERE OID_CONTACTO=".$oid;
		}else{
			$resultado = "SELECT * FROM PROVEEDOR WHERE NOMBRE_LAB='".$usuariop."'";
		}
	
		$usuario['OID_PROVEEDOR']= $conexion->query($resultado)->fetch()[0];
		$usuario['CONTRASEÑA']=$conexion->query($resultado)->fetch()[1];
		$usuario['NOMBRE_LAB']=$conexion->query($resultado)->fetch()[2];
		$usuario['PRECIO_ENVIO_SIN_GASTOS']=$conexion->query($resultado)->fetch()[3];
		$usuario['OID_CONTACTO']=$conexion->query($resultado)->fetch()[4];
		$usuario['nivel'] = 2;
		$_SESSION['usuario']=$usuario;
	}
	function gradoEMPLEADO($usuario){
		switch($usuario){
			case ENCARGADO_TIENDA:
				return 1;
				break;
			case EMPLEADOS_ALMACEN:
				return 2;
				break;
			case ENCARGADO_ALMACEN:
				return 3;
				break;
			case PERSONAL_ADMINISTRATIVO:
				return 4;
				break;
			case GERENTE:
				return 5;
				break;
			case JEFE_ENCARGADO_ALMACEN:
				return 6;
				break;
			case SUBDIRECTOR:
				return 7;
				break;
			case DIRECTOR:
				return 7;
				break;
		}
		
	}

	function compruebaContacto($conexion,$usuario){
		try{
			$consultaContacto = "SELECT count(*) FROM CONTACTO WHERE EMAIL='".$usuario."'";
			return $conexion->query($consultaContacto)->fetch()[0]>0;
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	
	function compruebaUsuarioDNI($conexion,$usuario){
		try{
			$consultaUsuarioDNI = "SELECT count(*) FROM USUARIO WHERE DNI_USUARIO='".$usuario."'";
			return $conexion->query($consultaUsuarioDNI)->fetch()[0]>0;
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	
	function compruebaEmpleadoDNI($conexion,$usuario){
		try{
			$consultaEmpleadoDNI = "SELECT count(*) FROM EMPLEADO WHERE DNI_EMPLEADO='".$usuario."'";
			return $conexion->query($consultaEmpleadoDNI)->fetch()[0]>0;
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	
	function compruebaProveedorDNI($conexion,$usuario){
		try{
			$consultaProveedorDNI = "SELECT count(*) FROM PROVEEDOR WHERE NOMBRE_LAB='".$usuario."'";
			return $conexion->query($consultaProveedorDNI)->fetch()[0]>0;
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	
	function compruebaContraseñaProveedor($conexion,$usuario,$contraseña){
		try{
			$query1  = "SELECT CONTRASEÑA FROM PROVEEDOR WHERE NOMBRE_LAB='".$usuario."'";
			$contraseñaDNI=$conexion->query($query1)->fetch()[0];
			$query2 = "SELECT CONTRASEÑA FROM PROVEEDOR LEFT OUTER JOIN contacto ON contacto.oid_contacto=proveedor.oid_contacto WHERE EMAIL='".$usuario."'";
			$contraseñaEMAIL=$conexion->query($query2)->fetch()[0];
			return $contraseñaDNI==$contraseña || $contraseñaEMAIL==$contraseña;
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	
	function compruebaContraseñaUsuario($conexion,$usuario,$contraseña){
		try{
			$query1  = "SELECT contrasenya FROM USUARIO WHERE DNI_USUARIO='".$usuario."'";
			$contraseñaDNI=$conexion->query($query1)->fetch()[0];
			$query2 = "SELECT contrasenya FROM USUARIO LEFT OUTER JOIN contacto ON contacto.oid_contacto=usuario.oid_contacto WHERE EMAIL='".$usuario."'";
			$contraseñaEMAIL=$conexion->query($query2)->fetch()[0];
			return $contraseñaDNI==$contraseña||$contraseñaEMAIL==$contraseña;
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	
	function compruebaContraseñaEmpleado($conexion,$usuario,$contraseña){
		try{
			$query1  = "SELECT contrasenya FROM EMPLEADO WHERE DNI_EMPLEADO='".$usuario."'";
			$contraseñaDNI=$conexion->query($query1)->fetch()[0];
			$query2 = "SELECT contrasenya FROM EMPLEADO LEFT OUTER JOIN contacto ON contacto.oid_contacto=empleado.oid_contacto WHERE EMAIL='".$usuario."'";
			$contraseñaEMAIL=$conexion->query($query2)->fetch()[0];
			return $contraseñaDNI==$contraseña||$contraseñaEMAIL==$contraseña;
		}catch(PDOException $e){
			return $e->getMessage();
		}
	}
	
	
	
?>