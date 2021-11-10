INSERT INTO CIUDAD VALUES(8000,"Bahía Blanca");
INSERT INTO CIUDAD VALUES(8170,"Pigue");
INSERT INTO CIUDAD VALUES(8160,"Tornquist");
INSERT INTO CIUDAD VALUES(7540,"Coronel Suárez");
INSERT INTO CIUDAD VALUES(7000,"Tandil");
INSERT INTO CIUDAD VALUES(8135,"Monte Hermoso");

INSERT INTO SUCURSAL(NRO_SUC,NOMBRE,DIRECCION,TELEFONO,HORARIO,COD_POSTAL) VALUES(1,"Banco Nación","Brandsen 36","8106664444","Lun. a Vie., 10 a 15",8000);
INSERT INTO SUCURSAL(NRO_SUC,NOMBRE,DIRECCION,TELEFONO,HORARIO,COD_POSTAL) VALUES(2,"Banco Patagonia","Chiclana 334","2914500337","Lun. a Vie., 10 a 15",8000);
INSERT INTO SUCURSAL(NRO_SUC,NOMBRE,DIRECCION,TELEFONO,HORARIO,COD_POSTAL) VALUES(3,"Banco Provincia","Avenida Casey 374","2923472827","Lun. a Vie., 10 a 15",8170);
INSERT INTO SUCURSAL(NRO_SUC,NOMBRE,DIRECCION,TELEFONO,HORARIO,COD_POSTAL) VALUES(4,"Banco Provincia","Avenida Colón 1333","2494422834","Lun. a Vie., 10 a 15",7000);
INSERT INTO SUCURSAL(NRO_SUC,NOMBRE,DIRECCION,TELEFONO,HORARIO,COD_POSTAL) VALUES(5,"Banco Galicia","Villegas 110","8107773333","Lun. a Vie., 10 a 15",7540);
INSERT INTO SUCURSAL(NRO_SUC,NOMBRE,DIRECCION,TELEFONO,HORARIO,COD_POSTAL) VALUES(6,"Banco Nación","Avenida 9 de Julio 402","8106664444","Lun. a Vie., 10 a 15",8160);

INSERT INTO EMPLEADO(LEGAJO,APELLIDO,NOMBRE,TIPO_DOC,NRO_DOC,DIRECCION,TELEFONO,CARGO,PASSWORD,NRO_SUC) VALUES(1111,"González","José","DNI",15345278,"Paseo del Prado 74","2915044667","Tesorero",MD5('1'),1);
INSERT INTO EMPLEADO(LEGAJO,APELLIDO,NOMBRE,TIPO_DOC,NRO_DOC,DIRECCION,TELEFONO,CARGO,PASSWORD,NRO_SUC) VALUES(2222,"Ramírez","Alejandro","DNI",10456789,"Jardines Marvin 2422","2915066489","Gerente",MD5('2'),1);
INSERT INTO EMPLEADO(LEGAJO,APELLIDO,NOMBRE,TIPO_DOC,NRO_DOC,DIRECCION,TELEFONO,CARGO,PASSWORD,NRO_SUC) VALUES(3333,"Díaz","Paula","DNI",25462354,"Avenida Vermont 482","2919847851","Cajero",MD5('3'),2);
INSERT INTO EMPLEADO(LEGAJO,APELLIDO,NOMBRE,TIPO_DOC,NRO_DOC,DIRECCION,TELEFONO,CARGO,PASSWORD,NRO_SUC) VALUES(4444,"Lago","Emiliano","DNI",22830125,"Avenida Báltica 109","2923439147","Gerente",MD5('4'),3);
INSERT INTO EMPLEADO(LEGAJO,APELLIDO,NOMBRE,TIPO_DOC,NRO_DOC,DIRECCION,TELEFONO,CARGO,PASSWORD,NRO_SUC) VALUES(5555,"González","Mercedes","DNI",21654987,"Plaza Santiago 429","2916549871","Cajero",MD5('5'),6);
INSERT INTO EMPLEADO(LEGAJO,APELLIDO,NOMBRE,TIPO_DOC,NRO_DOC,DIRECCION,TELEFONO,CARGO,PASSWORD,NRO_SUC) VALUES(6666,"Costa","Leandro","DNI",23485964,"Avenida Virginia 2121","2926500126","Tesorero",MD5('6'),5);
INSERT INTO EMPLEADO(LEGAJO,APELLIDO,NOMBRE,TIPO_DOC,NRO_DOC,DIRECCION,TELEFONO,CARGO,PASSWORD,NRO_SUC) VALUES(7777,"Latorre","Abel","DNI",17567894,"Plaza San Carlos 654","2491234556","Cajero",MD5('7'),4);
INSERT INTO EMPLEADO(LEGAJO,APELLIDO,NOMBRE,TIPO_DOC,NRO_DOC,DIRECCION,TELEFONO,CARGO,PASSWORD,NRO_SUC) VALUES(8888,"Gallego","Germán","DNI",20452800,"Avenida Pensylvania 9032","2494529999","Gerente",MD5('8'),4);

INSERT INTO CLIENTE(nro_cliente,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,fecha_nac) VALUES(11111,"López","Ramiro","DNI",40421097,"Colón 587","2915433211", "1997/09/09");
INSERT INTO CLIENTE(nro_cliente,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,fecha_nac) VALUES(22222,"Suárez","Patricia","DNI",24587963,"Rivadavia 24","2914567891","1941/09/01");
INSERT INTO CLIENTE(nro_cliente,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,fecha_nac) VALUES(33333,"Nadal","Beatriz","DNI",17894125,"Las Heras 988","291455211", "1967/11/17");
INSERT INTO CLIENTE(nro_cliente,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,fecha_nac) VALUES(44444,"Ramírez","Carolina","DNI",44587963,"Lamadrid 434","2924567341","2002/07/03");
INSERT INTO CLIENTE(nro_cliente,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,fecha_nac) VALUES(55555,"Plaza","Ricardo","DNI", 18867765,"Brasil 12","2923812345", "1998/01/29");
INSERT INTO CLIENTE(nro_cliente,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,fecha_nac) VALUES(66666,"Hernández","Lucio","DNI",34545361,"Tucumán 223","2954247590","1986/05/24");
INSERT INTO CLIENTE(nro_cliente,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,fecha_nac) VALUES(77777,"Bravo","Mariela","DNI",27897765,"Francia 145","2490889871","1985/05/10");
INSERT INTO CLIENTE(nro_cliente,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,fecha_nac) VALUES(88888,"Pérez","Sonia","DNI",14587963,"Sixto Laspiur 444","2949357321","1949/03/14");

INSERT INTO PLAZO_FIJO(nro_plazo,capital,fecha_inicio,fecha_fin,tasa_interes,interes,nro_suc) VALUES(11111111,200.11,"2021/03/16","2021/05/16",10.65,456789.65,1);
INSERT INTO PLAZO_FIJO(nro_plazo,capital,fecha_inicio,fecha_fin,tasa_interes,interes,nro_suc) VALUES(22222222,52390,"2020/01/16","2021/09/07",10.65,1346,2);
INSERT INTO PLAZO_FIJO(nro_plazo,capital,fecha_inicio,fecha_fin,tasa_interes,interes,nro_suc) VALUES(33333333,4564.36,"2021/09/26","2021/12/16",10.65,323.65,3);
INSERT INTO PLAZO_FIJO(nro_plazo,capital,fecha_inicio,fecha_fin,tasa_interes,interes,nro_suc) VALUES(44444444,200000,"2018/11/12","2021/05/17",10.65,10000,4);
INSERT INTO PLAZO_FIJO(nro_plazo,capital,fecha_inicio,fecha_fin,tasa_interes,interes,nro_suc) VALUES(55555555,500000.11,"2020/12/16","2021/12/16",10.65,452329.65,5);
INSERT INTO PLAZO_FIJO(nro_plazo,capital,fecha_inicio,fecha_fin,tasa_interes,interes,nro_suc) VALUES(66666666,123456,"2019/04/01","2021/04/01",10.65,2920,6);

INSERT INTO TASA_PLAZO_FIJO(periodo,monto_inf,monto_sup,tasa) VALUES(30,8.9,10.65,30);
INSERT INTO TASA_PLAZO_FIJO(periodo,monto_inf,monto_sup,tasa) VALUES(222,10.02,54.65,77.8);

INSERT INTO PLAZO_CLIENTE(nro_plazo,nro_cliente) VALUES (11111111,11111);
INSERT INTO PLAZO_CLIENTE(nro_plazo,nro_cliente) VALUES (22222222,22222);
INSERT INTO PLAZO_CLIENTE(nro_plazo,nro_cliente) VALUES (33333333,33333);
INSERT INTO PLAZO_CLIENTE(nro_plazo,nro_cliente) VALUES (44444444,44444);
INSERT INTO PLAZO_CLIENTE(nro_plazo,nro_cliente) VALUES (55555555,55555);
INSERT INTO PLAZO_CLIENTE(nro_plazo,nro_cliente) VALUES (66666666,66666);

INSERT INTO PRESTAMO(nro_prestamo,fecha,cant_meses,monto,tasa_interes,interes,valor_cuota,legajo,nro_cliente) VALUES(11111111,"2021/05/16",05,4684.34,10.65,200.09,100,1111,11111);
INSERT INTO PRESTAMO(nro_prestamo,fecha,cant_meses,monto,tasa_interes,interes,valor_cuota,legajo,nro_cliente) VALUES(22222222,"2021/04/25",03,5000,10.65,300,200,2222,22222);
INSERT INTO PRESTAMO(nro_prestamo,fecha,cant_meses,monto,tasa_interes,interes,valor_cuota,legajo,nro_cliente) VALUES(33333333,"2021/04/01",09,4521.03,10.65,800,300,3333,33333);
INSERT INTO PRESTAMO(nro_prestamo,fecha,cant_meses,monto,tasa_interes,interes,valor_cuota,legajo,nro_cliente) VALUES(44444444,"2020/08/06",12,9089,10.65,1250,400,4444,88888);
INSERT INTO PRESTAMO(nro_prestamo,fecha,cant_meses,monto,tasa_interes,interes,valor_cuota,legajo,nro_cliente) VALUES(55555555,"2020/08/06",12,9089,10.65,1250,400,4444,88888);

INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(11111111,1,"2021/10/23","2021/09/18");
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(11111111,2,"2021/10/06",NULL);
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(11111111,3,"2021/12/06",NULL);
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(22222222,1,"2021/12/10","2021/02/07");
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(22222222,2,"2021/12/10","2021/02/07");
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(22222222,3,"2021/12/10","2021/02/07");
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(33333333,1,"2022/02/12","2021/04/08"); 
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(33333333,2,"2022/02/12","2021/05/08");
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(33333333,3,"2022/02/12",NULL);
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(44444444,1,"2021/08/06","2021/09/30");
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(44444444,2,"2022/08/06",NULL);
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(55555555,1,"2021/08/06",NULL);
INSERT INTO PAGO(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(55555555,2,"2021/08/06",NULL);

INSERT INTO TASA_PRESTAMO(periodo,monto_inf,monto_sup,tasa) VALUES(12,50000,100000,24.25);
INSERT INTO TASA_PRESTAMO(periodo,monto_inf,monto_sup,tasa) VALUES(5,4000,10000,25);
INSERT INTO TASA_PRESTAMO(periodo,monto_inf,monto_sup,tasa) VALUES(20,50000,200000,20.5);

INSERT INTO CAJA_AHORRO(nro_ca,CBU,saldo) VALUES(11111111,123456789,230000.00);
INSERT INTO CAJA_AHORRO(nro_ca,CBU,saldo) VALUES(22222222,167920392,500000.90);
INSERT INTO CAJA_AHORRO(nro_ca,CBU,saldo) VALUES(33333333,924809811,100000.00);
INSERT INTO CAJA_AHORRO(nro_ca,CBU,saldo) VALUES(44444444,346803288,350500.25);
INSERT INTO CAJA_AHORRO(nro_ca,CBU,saldo) VALUES(55555555,580632903,20000.50);
INSERT INTO CAJA_AHORRO(nro_ca,CBU,saldo) VALUES(66666666,875429032,15066.40);
INSERT INTO CAJA_AHORRO(nro_ca,CBU,saldo) VALUES(77777777,325429032,15466.40);

INSERT INTO CLIENTE_CA(nro_cliente,nro_ca) VALUES(11111,11111111);
INSERT INTO CLIENTE_CA(nro_cliente,nro_ca) VALUES(22222,22222222);
INSERT INTO CLIENTE_CA(nro_cliente,nro_ca) VALUES(33333,33333333);
INSERT INTO CLIENTE_CA(nro_cliente,nro_ca) VALUES(44444,44444444);
INSERT INTO CLIENTE_CA(nro_cliente,nro_ca) VALUES(55555,55555555);
INSERT INTO CLIENTE_CA(nro_cliente,nro_ca) VALUES(66666,66666666);
INSERT INTO CLIENTE_CA(nro_cliente,nro_ca) VALUES(66666,77777777);

INSERT INTO TARJETA(nro_tarjeta,PIN,CVT,fecha_venc,nro_cliente,nro_ca) VALUES(1345678539887543,MD5('1'),MD5('2'),"2025/05/15",11111,11111111);
INSERT INTO TARJETA(nro_tarjeta,PIN,CVT,fecha_venc,nro_cliente,nro_ca) VALUES(8643246800095321,MD5('3'),MD5('4'),"2026/08/08",22222,22222222);
INSERT INTO TARJETA(nro_tarjeta,PIN,CVT,fecha_venc,nro_cliente,nro_ca) VALUES(9888102737748927,MD5('5'),MD5('6'),"2025/03/09",33333,33333333);
INSERT INTO TARJETA(nro_tarjeta,PIN,CVT,fecha_venc,nro_cliente,nro_ca) VALUES(1235888908676542,MD5('7'),MD5('8'),"2021/12/20",44444,44444444);
INSERT INTO TARJETA(nro_tarjeta,PIN,CVT,fecha_venc,nro_cliente,nro_ca) VALUES(5555443687559760,MD5('9'),MD5('10'),"2026/01/25",55555,55555555);
INSERT INTO TARJETA(nro_tarjeta,PIN,CVT,fecha_venc,nro_cliente,nro_ca) VALUES(7642133309765421,MD5('11'),MD5('12'),"2022/07/18",66666,66666666);

INSERT INTO CAJA(cod_caja) VALUES(1);
INSERT INTO CAJA(cod_caja) VALUES(2);
INSERT INTO CAJA(cod_caja) VALUES(3);
INSERT INTO CAJA(cod_caja) VALUES(4);
INSERT INTO CAJA(cod_caja) VALUES(5);
INSERT INTO CAJA(cod_caja) VALUES(6);
INSERT INTO CAJA(cod_caja) VALUES(7);
INSERT INTO CAJA(cod_caja) VALUES(8);
INSERT INTO CAJA(cod_caja) VALUES(9);
INSERT INTO CAJA(cod_caja) VALUES(10);

INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(1,1);
INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(2,1);
INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(3,2);
INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(4,3);
INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(5,4);
INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(6,4);
INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(7,5);
INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(8,6);
INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(9,6);
INSERT INTO VENTANILLA(cod_caja,nro_suc) VALUES(10,6);

INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(1,8000,"d1");
INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(2,8000,"d2");
INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(3,8000,"d3");
INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(4,8170,"d4");
INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(5,7000,"d5");
INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(6,7000,"d6");
INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(7,7540,"d7");
INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(8,8160,"d8");
INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(9,8160,"d9");
INSERT INTO ATM(cod_caja,cod_postal,direccion) VALUES(10,8160,"d10");

INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(1,"2021/09/01","12:04:06.0000000",10.00);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(2,"2021/09/02","13:05:06.0000000",20.02);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(3,"2021/09/03","12:12:06.0000000",30.30);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(4,"2021/09/04","22:05:43.0000000",44.04);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(5,"2021/09/05","04:11:46.0000000",55.55);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(6,"2021/09/06","17:45:00.0000000",60.06);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(7,"2021/09/07","12:33:46.0000000",77.07);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(8,"2021/09/08","22:22:22.0000000",80.80);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(9,"2021/09/09","11:35:12.0000000",09.90);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(10,"2021/09/10","08:59:36.0000000",10.10);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(11,"2021/09/11","00:46:33.0000000",11.00);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(12,"2021/09/12","18:25:11.0000000",10.20);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(13,"2021/09/13","14:45:09.0000000",10.03);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(14,"2021/09/14","14:23:36.0000000",14.00);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(15,"2021/09/15","10:25:36.0000000",10.55);
INSERT INTO TRANSACCION(nro_trans,fecha,hora,monto) VALUES(16,"2021/09/16","10:12:12.0000000",16.00);

INSERT INTO DEBITO(nro_trans,descripcion,nro_cliente,nro_ca) VALUES(1,"",11111,11111111);
INSERT INTO DEBITO(nro_trans,descripcion,nro_cliente,nro_ca) VALUES(2,"",33333,33333333);
INSERT INTO DEBITO(nro_trans,descripcion,nro_cliente,nro_ca) VALUES(3,"",55555,55555555);
INSERT INTO DEBITO(nro_trans,descripcion,nro_cliente,nro_ca) VALUES(4,"",22222,22222222);

INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(5,5);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(6,6);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(7,7);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(8,8);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(9,9);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(10,10);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(11,1);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(12,2);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(13,3);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(14,4);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(15,5);
INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(16,6);

INSERT INTO DEPOSITO(nro_trans,nro_ca) VALUES(5,55555555);
INSERT INTO DEPOSITO(nro_trans,nro_ca) VALUES(6,66666666);
INSERT INTO DEPOSITO(nro_trans,nro_ca) VALUES(7,11111111);
INSERT INTO DEPOSITO(nro_trans,nro_ca) VALUES(8,44444444);
INSERT INTO DEPOSITO(nro_trans,nro_ca) VALUES(9,66666666);

INSERT INTO EXTRACCION(nro_trans,nro_cliente,nro_ca) VALUES(10,11111,11111111);
INSERT INTO EXTRACCION(nro_trans,nro_cliente,nro_ca) VALUES(11,22222,22222222);
INSERT INTO EXTRACCION(nro_trans,nro_cliente,nro_ca) VALUES(12,33333,33333333);
INSERT INTO EXTRACCION(nro_trans,nro_cliente,nro_ca) VALUES(13,44444,44444444);

INSERT INTO TRANSFERENCIA(nro_trans,nro_cliente,origen,destino) VALUES(14,44444,44444444,66666666);
INSERT INTO TRANSFERENCIA(nro_trans,nro_cliente,origen,destino) VALUES(15,55555,55555555,11111111);
INSERT INTO TRANSFERENCIA(nro_trans,nro_cliente,origen,destino) VALUES(16,66666,66666666,22222222);

















