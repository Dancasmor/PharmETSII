<?php	
	session_start();
	
	if (isset($_REQUEST["crear"])) {
		unset($_REQUEST["crear"]);
		
		if (isset($_FILES["imagen"])) {
			
			$cabezera = "./images/productos/";
			$nombre = $_FILES["imagen"]["name"]; 
			
			$ruta = $cabezera . $nombre;
			$ruta2 = "../images/productos/" . $nombre;
			
			$localizacion = $_FILES["imagen"]["tmp_name"]; 
			move_uploaded_file($localizacion, $ruta2);
			
			$_SESSION["URL_IMAGENES"] = $nombre;
	
			$_SESSION["NOMBRE"] = $_REQUEST["NOMBRE"];
			$_SESSION["PRECIO_VENTA"] = $_REQUEST["PRECIO_VENTA"];
			$_SESSION["PUNTOS"] = $_REQUEST["PUNTOS"];
			$_SESSION["RECETA"] = $_REQUEST["RECETA"];
			Header("Location: ../acciones/accion_producto_crear.php");
			
    	}else{
    		echo "no";
    		$_SESSION["excepcion"] = "Fallo al subir el producto";
			$_SESSION["destino"] = "./index.php";
			header("Location: ../index.php?tituloPag=Excepcion");
    	}
		
	}
	else if (isset($_REQUEST["consultar_producto"])) {
		unset($_REQUEST["consultar_producto"]);
		$_SESSION["OID_PRODUCTO"] = $_REQUEST["OID_PRODUCTO"];
		Header("Location: ../acciones/accion_producto_buscar.php");
	}
	else if (isset($_REQUEST["borrar"])) {
		unset($_REQUEST["borrar"]);
		$_SESSION["OID_PRODUCTO"] = $_REQUEST["OID_PRODUCTO"];
		Header("Location: ../acciones/accion_producto_eliminar.php");
	}
	else 
		Header("Location: ../index.php");
	
?>
