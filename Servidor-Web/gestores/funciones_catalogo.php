<?php 
	require_once('gestionarPedidoUsuario.php');
	
	
	function incrementaCantidadProductoArray($array,$producto){
		foreach($array as $p =>$c){
			if($p=$producto){
				$c=$nuevaCantidad;
				return true;
			}
		}return false;
	}
	
	function cuentaProducto($array,$prod){
		$contador=0;
		foreach($array as $n){
			if($n==$prod) $contador=$contador+1;
		}
		return $contador;
	}
	
	function obtenerPrecio($conexion,$oid_producto){
		$consulta = "SELECT PRECIO_VENTA FROM PRODUCTO WHERE OID_PRODUCTO='".$oid_producto."'";
		return $conexion->query($consulta)->fetch()[0];	
	}
	
	function precioTotal($conexion,$array){
		$suma=0.0;
		foreach($array as $a){
			$suma= $suma +  floatval(str_replace(",",".",obtenerPrecio($conexion, $a)));;
		}
		return $suma;
	}
	
	function tieneStock($conexion, $oid_producto){
		$consulta = "SELECT STOCK_ACTUAL FROM SECCION WHERE OID_PRODUCTO='".$oid_producto."'";
		$valor= $conexion->query($consulta)->fetch()[0];
		return $valor>0;
	}
	
	function tieneStockParaCantidad($conexion, $oid_producto,$cantidad){
		$consulta = "SELECT STOCK_ACTUAL FROM SECCION WHERE OID_PRODUCTO='".$oid_producto."'";
		$valor= $conexion->query($consulta)->fetch()[0];
		return $valor>=$cantidad;
	}
	
	function depuraProductos($array){
		return array_unique($array);
	}
	
	function traducirOID_PRODUCTO($conexion,$oid){
		$consulta = "SELECT NOMBRE FROM PRODUCTO WHERE OID_PRODUCTO='".$oid."'";
	return $conexion->query($consulta)->fetch()[0];
	}

	function actualizarProductoHastaCantidad($array,$producto,$cantidad){
		$array2=$array;
		$max=cuenta2($array);
		$acumulados=0;
		for($i=0;$i<$max;$i++){
			if($array2[$i]==$producto&&$acumulados<$cantidad){
				$acumulados++;
			}else if($array2[$i]==$producto&&$acumulados>=$cantidad){
				unset($array2[$i]);
			}
		}
		if($acumulados<$cantidad){
			while($acumulados<$cantidad){
				array_push($array2,$producto);
				$acumulados++;
			}
		}
		return $array2;
	}
	function cuenta2($array){
		$cont=0;
		foreach($array as $n) $cont++;
		return $cont;
	}
	
	function eliminarProductoBolsa($bolsas,$producto){
		$max=cuenta2($bolsas);
		for($i=0;$i<$max;$i++){
			if($bolsas[$i]==$producto){
				unset($bolsas[$i]);
			};
		}
	}
	function ultimoOIDproducto($conexion,$pedidos){
		$max=0;
		foreach($pedidos as $pedido){
			if($max<(int)$pedido){
				$max=(int)$pedido;
			}
		}
		return $max;
	}
	function actualizaClaves($array){
		$array2= array();
		foreach($array as $el) array_push($array2,$el);
		return $array2;
	}
	

?>
