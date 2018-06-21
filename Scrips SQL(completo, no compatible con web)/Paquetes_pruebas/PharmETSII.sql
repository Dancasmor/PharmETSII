/* Activar salida de texto por pantalla */
SET SERVEROUTPUT ON;

DECLARE
  oid_contacto_1 CONTACTO.OID_CONTACTO%TYPE; oid_contacto_2 CONTACTO.OID_CONTACTO%TYPE; oid_contacto_3 CONTACTO.OID_CONTACTO%TYPE; oid_contacto_4 CONTACTO.OID_CONTACTO%TYPE;
  oid_contacto_5 CONTACTO.OID_CONTACTO%TYPE; oid_contacto_6 CONTACTO.OID_CONTACTO%TYPE; oid_contacto_7 CONTACTO.OID_CONTACTO%TYPE; oid_contacto_8 CONTACTO.OID_CONTACTO%TYPE;
  oid_empresa CHAR(9);
  oid_farmacia_1 CHAR(9); oid_farmacia_2 CHAR(9);
  oid_almacen_1 CHAR(9); oid_almacen_2 CHAR(9); oid_almacen_3 CHAR(9);
  oid_seccion_1 CHAR(9); oid_seccion_2 CHAR(9); oid_seccion_3 CHAR(9);
  oid_producto_con_1 CHAR(9); oid_producto_con_2 CHAR(9); oid_producto_sin CHAR(9);
  oid_proveedor_1 CHAR(9); oid_proveedor_2 CHAR(9);
  oid_lote_1 CHAR(9); oid_lote_2 CHAR(9); oid_lote_3 CHAR(9); oid_lote_4 CHAR(9);
  oid_cuenta_bancaria_1 CHAR(20); oid_cuenta_bancaria_2 CHAR(20); oid_cuenta_bancaria_3 CHAR(20);
  oid_empleado_1 CHAR(9); oid_empleado_2 CHAR(9); oid_empleado_3 CHAR(9); oid_empleado_4 CHAR(9);
  oid_usuario_1 CHAR(9); oid_usuario_2 CHAR(9);
  oid_pedido_1 CHAR(9); oid_pedido_2 CHAR(9); oid_pedido_3 CHAR(9);oid_pedido_4 CHAR(9);
  oid_linea_1 CHAR(9); oid_linea_2 CHAR(9); oid_linea_3 CHAR(9); oid_linea_4 CHAR(9); oid_linea_5 CHAR(9);
  oid_factura CHAR(9);
  oid_envio CHAR(9);
  oid_pedido_usuario_1 CHAR(9); oid_pedido_usuario_2 CHAR(9); oid_pedido_usuario_3 CHAR(9); oid_pedido_usuario_4 CHAR(9);
  oid_bolsa_1 CHAR(9); oid_bolsa_2 CHAR(9); oid_bolsa_3 CHAR(9);oid_bolsa_4 CHAR(9);
  oid_factura_usuario CHAR(9);
  oid_nomina_1 CHAR(9); oid_nomina_2 CHAR(9); oid_nomina_3 CHAR(9); oid_nomina_4 CHAR(9); oid_nomina_5 CHAR(9);
  CR_LF CHAR(2) := CHR(13)||CHR(10); 
BEGIN

  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA CONTACTO 
  **********************************************************************/
  PRUEBAS_CONTACTO.INICIALIZAR;
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de CONTACTO'||CR_LF);
  PRUEBAS_CONTACTO.INSERTAR  ('Contacto 1 --> ','+34 699 823 784','josecotellamas@gmail.com','C/ Rosa, 13', 41006, 'Sevilla',true);
  oid_contacto_1 := sq_contacto.currval;
  PRUEBAS_CONTACTO.INSERTAR  ('Contacto 2 --> ','+34 621 777 132','demetro_rea@gmail.com','C/ Ingeniero la Cierva, 1, 4º B', 41015, 'Sevilla',true);
  oid_contacto_2 := sq_contacto.currval;
  PRUEBAS_CONTACTO.INSERTAR  ('Contacto 3 --> ','+34 701 645 001','uganda_warrior@queen.com','C/ Wandall Rod, 22', 41770, 'Montellano',true);
  oid_contacto_3 := sq_contacto.currval;
  PRUEBAS_CONTACTO.INSERTAR  ('Contacto 4 --> ','+34 645 342 118','alejandra.maria19@hotmail.com','C/ Juliana, 5, 2º C', 41023, 'Sevilla',true);
  oid_contacto_4 := sq_contacto.currval;
  PRUEBAS_CONTACTO.INSERTAR  ('Contacto 5 --> ','+34 667 100 371','youtuberILEGAL@gmail.com','C/ Madrid, 1', 41005, 'Sevilla',true);
  oid_contacto_5 := sq_contacto.currval;
  PRUEBAS_CONTACTO.INSERTAR  ('Contacto 6 --> ','+34 611 231 933','carlitos.arevalow@gmail.com','C/ Hermanos Caritativos, 45', 41019, 'Sevilla',true);
  oid_contacto_6 := sq_contacto.currval;
  PRUEBAS_CONTACTO.INSERTAR  ('Contacto 7 --> ','+34 787 622 050','zimbahue_conguito@hotmail.com','C/ Del Congo mustio, 4, 6º Izquierda', 41098, 'El Coronil',true);
  oid_contacto_7 := sq_contacto.currval;
  PRUEBAS_CONTACTO.INSERTAR  ('Contacto 8 --> ','+34 675 314 138','depravadosintactico@hotmail.com','C/ Madroño de la butifarra, 11, 3º A', 41023, 'Sevilla',true);
  oid_contacto_8 := sq_contacto.currval;
  
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA CUENTA BANCARIA 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de CUENTA BANCARIA'||CR_LF);
  PRUEBAS_CUENTA_BANCARIA.INSERTAR  ('Cuenta bancaria 1 --> ','ES11111111111111111111111111111111','PharmETSII', 9000.00,true);
  oid_cuenta_bancaria_1 := '8837172634722UUPL';
  PRUEBAS_CUENTA_BANCARIA.INSERTAR  ('Cuenta bancaria 2 --> ','ES11111111111111111111111111111112','Silent Hill', 3000.60,true);
  oid_cuenta_bancaria_2 := '1183875222004OOKS';
  PRUEBAS_CUENTA_BANCARIA.INSERTAR  ('Cuenta bancaria 3 --> ','ES11111111111111111111111111111113','Farmacia Tita Inma', 7209.13,true);
  oid_cuenta_bancaria_3 := '0100034065589JMNN';
  
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA EMPRESA 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de EMPRESA'||CR_LF);
  PRUEBAS_EMPRESA.INSERTAR   ('Empresa --> ','PharmETSII',oid_contacto_1, oid_cuenta_bancaria_1,true);
  oid_empresa := sq_empresa.currval;
  
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA FARMACIA      
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de FARMACIA'||CR_LF);
  PRUEBAS_FARMACIA.INSERTAR  ('Farmacia 1 --> ',oid_contacto_2,'Silent Hill',oid_cuenta_bancaria_2,true);
  oid_farmacia_1 := sq_farmacia.currval;
  PRUEBAS_FARMACIA.INSERTAR  ('Farmacia 2 --> ',oid_contacto_7,'Farmacia Tita Inma',oid_cuenta_bancaria_3,true);
  oid_farmacia_2 := sq_farmacia.currval;
  
    /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA PRODUCTO 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de PRODUCTO'||CR_LF);
  PRUEBAS_PRODUCTO.INSERTAR  ('Producto con receta 1 --> ','Dextrosa Monoclida 15ml','.root/imagenes/productos/dextrosa15ml.jpg',15.99,12,1,true);
  oid_producto_con_1 := sq_producto.currval;
  PRUEBAS_PRODUCTO.INSERTAR  ('Producto con receta 2 --> ','Temazepam (Restoril)','.root/imagenes/productos/temazepan.jpg',4.90,8,1,true);
  oid_producto_con_2 := sq_producto.currval;
  PRUEBAS_PRODUCTO.INSERTAR  ('Producto sin receta --> ','Paracetamol 50g','.root/imagenes/productos/paracetamol50g.jpg',4.90,2,0,true);
  oid_producto_sin := sq_producto.currval;
  
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA ALMACEN 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de ALMACEN'||CR_LF);
  PRUEBAS_ALMACEN.INSERTAR  ('Almacen 1 --> ',1,oid_empresa,null,true);
  oid_almacen_1 := sq_almacen.currval;
  PRUEBAS_ALMACEN.INSERTAR  ('Almacen 2 --> ',0,null,oid_farmacia_1,true);
  oid_almacen_2 := sq_almacen.currval;
  PRUEBAS_ALMACEN.INSERTAR  ('Almacen 3 --> ',0,null,oid_farmacia_2,true);
  oid_almacen_3 := sq_almacen.currval;
  
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA SECCION 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de SECCION'||CR_LF);
  PRUEBAS_SECCION.INSERTAR  ('Seccion 1 --> ',oid_almacen_1,oid_producto_con_1,true);
  oid_seccion_1 := sq_seccion.currval;
  PRUEBAS_SECCION.INSERTAR  ('Seccion 2 --> ',oid_almacen_1,oid_producto_con_2,true);
  oid_seccion_2 := sq_seccion.currval;
  PRUEBAS_SECCION.INSERTAR  ('Seccion 3 --> ',oid_almacen_1,oid_producto_sin,true);
  oid_seccion_3 := sq_seccion.currval;
  PRUEBAS_SECCION.ACTUALIZAR  ('Seccion 1 --> ',oid_seccion_1,500, 1000, 50,true);
  PRUEBAS_SECCION.ACTUALIZAR  ('Seccion 2 --> ',oid_seccion_2,600, 1000, 50,true);
  PRUEBAS_SECCION.ACTUALIZAR  ('Seccion 3 --> ',oid_seccion_3,578, 1000, 50,true);
 
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA PROVEEDOR 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de PROVEEDOR'||CR_LF);
  PRUEBAS_PROVEEDOR.INSERTAR  ('Proveedor 1 --> ','4chan Goodies',800,oid_contacto_2,'cubilete',true);
  oid_proveedor_1 := sq_proveedor.currval;
  PRUEBAS_PROVEEDOR.INSERTAR  ('Proveedor 2 --> ','Reddit Pharmcilities',750,oid_contacto_4,'alegria',true);
  oid_proveedor_2 := sq_proveedor.currval;
  
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA LOTE 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de LOTE'||CR_LF);
  PRUEBAS_LOTE.INSERTAR  ('Lote 1 --> ',3,34.99,oid_proveedor_1,oid_producto_con_1,true);
  oid_lote_1 := sq_lote.currval;
  PRUEBAS_LOTE.INSERTAR  ('Lote 2 --> ',10,26.50,oid_proveedor_2,oid_producto_sin,true);
  oid_lote_2 := sq_lote.currval;
  PRUEBAS_LOTE.INSERTAR  ('Lote 3 --> ',8,14.99,oid_proveedor_2,oid_producto_con_2,true);
  oid_lote_3 := sq_lote.currval;
  PRUEBAS_LOTE.INSERTAR  ('Lote 4 --> ',21,33.20,oid_proveedor_2,oid_producto_con_1,true);
  oid_lote_4 := sq_lote.currval;
 
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA EMPLEADO 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de EMPLEADO'||CR_LF);
  PRUEBAS_EMPLEADO.INSERTAR  ('Empleado 1 --> ','30267763Q','Jose','Cote Llamas',TO_DATE('25/03/1994', 'dd/MM/yyyy'),oid_contacto_1,SYSDATE,null,oid_empresa,'killingGODS1994','DIRECTOR',true);
  oid_empleado_1 := '30267763Q';
  PRUEBAS_EMPLEADO.INSERTAR  ('Empleado 2 --> ','57821277M','Daniel','Casanueva Morato',TO_DATE('14/05/1998','dd/MM/yyyy'),oid_contacto_2,SYSDATE,oid_farmacia_1,null,'godsAREnotDEADman','ENCARGADO_TIENDA',true);
  oid_empleado_2 := '57821277M';
  PRUEBAS_EMPLEADO.INSERTAR  ('Empleado 3 --> ','29986360S','Jaime','Nomechacuenta Lobo',TO_DATE('02/11/1995','dd/MM/yyyy'),oid_contacto_3,SYSDATE,oid_farmacia_1,null,'whatTHEhellyouTALKINGABOUT','ENCARGADO_ALMACEN',true);
  oid_empleado_3 := '29986360S';
  PRUEBAS_EMPLEADO.INSERTAR  ('Empleado 4 --> ','17820091F','Antonio','Vazquez Cotilla',TO_DATE('14/09/1997','dd/MM/yyyy'),oid_contacto_4,SYSDATE,oid_farmacia_2,null,'estaASIGNATURAmeMATARAjejexd','GERENTE',true);
  oid_empleado_4 := '17820091F';
  
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA USUARIO 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de USUARIO'||CR_LF);
  PRUEBAS_USUARIO.INSERTAR  ('Usuario 1 --> ','64722399P','Transeunte','Perez Galdos',TO_DATE('27/04/1980', 'dd/MM/yyyy'),oid_contacto_3,SYSDATE,oid_empresa,'mamonasoimpertinente',0,70.9,178,true);
  oid_usuario_1 := '64722399P';
  PRUEBAS_USUARIO.INSERTAR  ('Usuario 2 --> ','27600123P','Gloria','Carrascoso Garcia',TO_DATE('14/11/1989', 'dd/MM/yyyy'),oid_contacto_5,SYSDATE,oid_empresa,'992127reinadelanoche11',0,65.6,169,true);
  oid_usuario_2 := '27600123P';
  
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA PEDIDO
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de PEDIDO'||CR_LF);
  PRUEBAS_PEDIDO.INSERTAR  ('Pedido 1 --> ',1,oid_almacen_2,null,oid_proveedor_1,true);
  oid_pedido_1 := sq_pedido.currval;
  PRUEBAS_PEDIDO.INSERTAR  ('Pedido 2 --> ',1,oid_almacen_2,null,oid_proveedor_2,true);
  oid_pedido_2 := sq_pedido.currval;
  PRUEBAS_PEDIDO.INSERTAR  ('Pedido 3 --> ',0,oid_almacen_3,oid_almacen_1,null,true);
  oid_pedido_3 := sq_pedido.currval;
  PRUEBAS_PEDIDO.INSERTAR  ('Pedido 4 --> ',1,oid_almacen_3,null,oid_proveedor_2,true);
  oid_pedido_4 := sq_pedido.currval;
  
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA LINEA 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de LINEA'||CR_LF);
  PRUEBAS_LINEA.INSERTAR  ('Linea 1 --> ',13,oid_lote_4,oid_pedido_4,null,true);
  oid_linea_1 := sq_linea.currval;
  PRUEBAS_LINEA.INSERTAR  ('Linea 2 --> ',7,oid_lote_1,oid_pedido_1,null,true);
  oid_linea_2 := sq_linea.currval;
  PRUEBAS_LINEA.INSERTAR  ('Linea 3 --> ',45,oid_lote_3,oid_pedido_2,null,true);
  oid_linea_3 := sq_linea.currval;
  PRUEBAS_LINEA.INSERTAR  ('Linea 4 --> ',2,oid_lote_4,oid_pedido_2,null,true);
  oid_linea_4 := sq_linea.currval;
  PRUEBAS_LINEA.INSERTAR  ('Linea 5 --> ',167,null,oid_pedido_3,oid_producto_con_1,true);
  oid_linea_5 := sq_linea.currval;

  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA ENVIO 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de ENVIO'||CR_LF);
  PRUEBAS_ENVIO.INSERTAR   ('Envio --> ',TO_DATE('20/05/2021', 'dd/MM/yyyy'),null,oid_almacen_1,0,true);
  oid_envio := sq_envio.currval;

  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA FACTURA 
  **********************************************************************/
  --RO01-RN03-Salida productos
  --RO01-RN07-Enviar pedido
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de FACTURA + RO01-RN07-Enviar pedido y RO01-RN03-Salida productos'||CR_LF);
  PRUEBAS_FACTURA.INSERTAR   ('Factura, al crearse se cambia el pedido a enviado y se restan las cantidades en el almacén general--> ',34.98,oid_pedido_3,oid_envio,oid_almacen_3,true);
  oid_factura := sq_factura.currval;

  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA PEDIDO_USUARIO
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de PEDIDO USUARIO'||CR_LF);
  PRUEBAS_PEDIDO_USUARIO.INSERTAR  ('Pedido usuario 1 --> ','27600123P',SYSDATE,0,null,true);
  oid_pedido_usuario_1 := sq_pedido_usuario.currval;
  PRUEBAS_PEDIDO_USUARIO.INSERTAR  ('Pedido usuario 2 --> ','27600123P',SYSDATE,1,'7162376891382382001',true);
  oid_pedido_usuario_2 := sq_pedido_usuario.currval;
  PRUEBAS_PEDIDO_USUARIO.INSERTAR  ('Pedido usuario 3 --> ','64722399P',SYSDATE,1,'0001632771883222243',true);
  oid_pedido_usuario_3 := sq_pedido_usuario.currval;
  PRUEBAS_PEDIDO_USUARIO.INSERTAR  ('Pedido usuario 4 --> ','64722399P',SYSDATE,1,'0001632771883222243',true);
  oid_pedido_usuario_4 := sq_pedido_usuario.currval;

  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA BOLSA
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de BOLSA'||CR_LF);
  PRUEBAS_BOLSA.INSERTAR  ('Bolsa 1 --> ',oid_producto_con_1,oid_pedido_usuario_1,4,true);
  oid_bolsa_1 := sq_bolsa.currval;
  PRUEBAS_BOLSA.INSERTAR  ('Bolsa 2 --> ',oid_producto_con_2,oid_pedido_usuario_2,6,true);
  oid_bolsa_2 := sq_bolsa.currval;
  PRUEBAS_BOLSA.INSERTAR  ('Bolsa 3 --> ',oid_producto_sin,oid_pedido_usuario_4,1,true);
  oid_bolsa_3 := sq_bolsa.currval;
  PRUEBAS_BOLSA.INSERTAR  ('Bolsa 4 --> ',oid_producto_sin,oid_pedido_usuario_3,1,true);
  oid_bolsa_4 := sq_bolsa.currval;
  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA FACTURA USUARIO 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de FACTURA USUARIO'||CR_LF);
  PRUEBAS_FACTURA_USUARIO.INSERTAR   ('Factura usuario --> ',oid_pedido_usuario_3,SYSDATE,oid_almacen_2,true);
  oid_factura_usuario := sq_factura_usuario.currval;

  /*********************************************************************
        PRUEBAS DE LAS OPERACIONES SOBRE LA TABLA NOMINA 
  **********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Pruebas sobre tabla de NOMINA'||CR_LF);
  PRUEBAS_NOMINA.INSERTAR  ('Nomina 1 --> ',oid_empleado_2,1250.24,890.70,TO_DATE('31/12/2017', 'dd/MM/yyyy'),1,true);
  oid_nomina_1 := sq_nomina.currval;
  PRUEBAS_NOMINA.INSERTAR  ('Nomina 2 --> ',oid_empleado_3,550.50,110.96,TO_DATE('31/12/2017', 'dd/MM/yyyy'),0,true);
  oid_nomina_2 := sq_nomina.currval;
  PRUEBAS_NOMINA.INSERTAR  ('Nomina 3 --> ',oid_empleado_1,1550.50,350.96,TO_DATE('31/12/2017', 'dd/MM/yyyy'),1,true);
  oid_nomina_3 := sq_nomina.currval;
  
  /*********************************************************************
                    PRUEBAS DE TRIGGERS
  *********************************************************************/
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Probando LINEA RO01-RN01- Stock limite'||CR_LF);
  
  --RO01-RN01- Stock limite
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO01-RN01- Stock limite (LINEA)'||CR_LF);
  PRUEBAS_LINEA.ACTUALIZAR  ('(Rollback) Linea 5, se intenta pedir mas de lo que la seccion soporta --> ',oid_linea_5,5000,false);
  PRUEBAS_LINEA.ACTUALIZAR  ('(Rollback) Linea 5, se intenta pedir menos de 20 unidades --> ',oid_linea_5,13,false);
  
  --RO01-RN02-Stock seguridad
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO01-RN02-Stock seguridad (SECCION)'||CR_LF);
  PRUEBAS_SECCION.ACTUALIZAR  ('Seccion 1, se baja del stock de seguridad--> ',oid_seccion_2,54,700,55,true);
  
  --RO01-RN04-Envío pedidos
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO01-RN04-Envío pedidos (FACTURA)'||CR_LF);
  PRUEBAS_FACTURA.INSERTAR   ('(Rollback) Factura, se intenta crear una factura para enviar un pedido ya pedido--> ',34.98,oid_pedido_3,oid_envio,oid_almacen_3,false);
  
  --RO01-RN05-Stock
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO01-RN05-Stock (SECCION)'||CR_LF);
  PRUEBAS_SECCION.ACTUALIZAR  ('(Rollback) Seccion 1, el stock de seguridad no puede ser mayor que el limite --> ',oid_seccion_1,49,50,60,false);
  
  --RO01-RN06-Almacén
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO01-RN06-Almacén (ALMACEN)'||CR_LF);
  PRUEBAS_ALMACEN.ACTUALIZAR  ('(Rollback) Almacen 2, no puedes dejar un almacén libre --> ',oid_almacen_2,0,null,null,false);
  
  --RO02-RN01-Almacen unico farmacia
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO02-RN01-Almacen unico farmacia (ALMACEN)'||CR_LF);
  PRUEBAS_ALMACEN.ACTUALIZAR  ('(Rollback) Almacen 2 --> ',oid_almacen_2,0,null,oid_farmacia_2,false);
  
  --RO02-RN02-Cuenta bancaria unica farmacia
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO02-RN02-Cuenta bancaria unica (FARMACIA)'||CR_LF);
  PRUEBAS_FARMACIA.INSERTAR  ('(Rollback) Farmacia nueva con cuenta bancaria en uso --> ',oid_contacto_6,'Farmacia que va a morir...',oid_cuenta_bancaria_2,false);

  --RO03-RN01-Limite ventas online
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO03-RN01-Limite ventas online (PEDIDO_USUARIO)'||CR_LF);
  PRUEBAS_PEDIDO_USUARIO.INSERTAR  ('3er Pedido del dia, tramitado  --> ','64722399P',SYSDATE,1,'0001632771883222243',true);
  PRUEBAS_PEDIDO_USUARIO.INSERTAR  ('(Rollback) 4to Pedido, no se pueden hacer mas de tres en un mismo dia --> ','64722399P',SYSDATE,1,'0001632771883222243',false);
  
  --RO03-RN02-Sin stock + RO03-RN03-Solapamiento bolsa
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO03-RN02-Sin stock + RO03-RN03-Solapamiento bolsa (BOLSA)'||CR_LF);
  PRUEBAS_BOLSA.INSERTAR  ('(Rollback) Bolsa --> ',oid_producto_sin,oid_pedido_usuario_3,7000,false);
  
  --RN04-RN02-Realizacion nomina
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RN04-RN02-Realizacion nomina (NOMINA)'||CR_LF);
  PRUEBAS_NOMINA.INSERTAR  ('Nomina 3 --> ',oid_empleado_4,550.50,678.31,TO_DATE('30/12/2017'),1,false);
  
  --RO03-RN04-Incompatibilidad fecha pedido y factura
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO03-RN04-Incompatibilidad fecha pedido y factura (FACTURA_USUARIO)'||CR_LF);
  PRUEBAS_FACTURA_USUARIO.INSERTAR   ('(Rollback) Factura usuario --> ',oid_pedido_usuario_1,TO_DATE('03/12/2017', 'dd/MM/yyyy'),oid_almacen_2,false);
  
  --RO04-RN06- Eliminación nómina
  DBMS_OUTPUT.PUT_LINE(CR_LF||'RO04-RN06- Eliminación nómina (NOMINA)'||CR_LF);
  PRUEBAS_NOMINA.ELIMINAR('(Rollback) Nomina 2, no se puede eliminar una nomina que no haya sido cobrada --> ',oid_nomina_2,false);
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Actualizando NOMINA'||CR_LF);
  PRUEBAS_NOMINA.ACTUALIZAR  ('Update Nomina 2 (cobrada) --> ',oid_nomina_2,550.50,289.13,1,true);
  DBMS_OUTPUT.PUT_LINE(CR_LF||'Eliminando misma NOMINA pero ya cobrada'||CR_LF);
  PRUEBAS_NOMINA.ELIMINAR('Eliminando Nomina 2 --> ',oid_nomina_2,true);
  
END;