package banco.modelo.atm;

import java.io.EOFException;
import java.io.FileInputStream;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.modelo.ModeloImpl;
import banco.utils.Fechas;


public class ModeloATMImpl extends ModeloImpl implements ModeloATM {
	
	private static Logger logger = LoggerFactory.getLogger(ModeloATMImpl.class);	

	private String tarjeta = null;   // mantiene la tarjeta del cliente actual
	private Integer codigoATM = null;
	
	/*
	 * La información del cajero ATM se recupera del archivo que se encuentra definido en ModeloATM.CONFIG
	 */
	public ModeloATMImpl() {
		logger.debug("Se crea el modelo ATM.");

		logger.debug("Recuperación de la información sobre el cajero");
		
		Properties prop = new Properties();
		try (FileInputStream file = new FileInputStream(ModeloATM.CONFIG))
		{
			logger.debug("Se intenta leer el archivo de propiedades {}",ModeloATM.CONFIG);
			prop.load(file);

			codigoATM = Integer.valueOf(prop.getProperty("atm.codigo.cajero"));

			logger.debug("Código cajero ATM: {}", codigoATM);
		}
		catch(Exception ex)
		{
        	logger.error("Se produjo un error al recuperar el archivo de propiedades {}.",ModeloATM.CONFIG); 
		}
		return;
	}

	@Override
	public boolean autenticarUsuarioAplicacion(String tarjeta, String pin) throws Exception	{
		/** 
		 * TODO Código que autentica que exista una tarjeta con ese pin (el pin guardado en la BD está en MD5)
		 *      En caso exitoso deberá registrar la tarjeta en la propiedad tarjeta y retornar true.
		 *      Si la autenticación no es exitosa porque no coincide el pin o la tarjeta no existe deberá retornar falso
		 *      y si hubo algún otro error deberá producir una excepción.
		 */
		logger.info("Se intenta autenticar la tarjeta {} con pin {}", tarjeta, pin);
		boolean conexion = this.conectar("atm", "atm");
		boolean resultado = false;
		if(conexion){
			try{
				long t = Long.parseLong(tarjeta);
				String sql = "SELECT nro_tarjeta, PIN " +
							"FROM Tarjeta " +
							"WHERE nro_tarjeta = " + t + " AND PIN = MD5(" + pin + ");";
				ResultSet rs = this.consulta(sql);
				if (rs != null && rs.next()){
					this.tarjeta = rs.getString("nro_tarjeta");
					resultado = true;
					rs.close();
				}
			}catch (SQLException ex) {
				System.out.println("Mensaje: " + ex.getMessage());
				System.out.println("Código: " + ex.getErrorCode());
				System.out.println("SQLState: " + ex.getSQLState());
			}
		}else{
			throw new Exception("Se produjo un error al intentar conectarse con la base de datos");
		}
		return resultado;
	}
	
	
	@Override
	public Double obtenerSaldo() throws Exception
	{
		/** 
		 * TODO Obtiene el saldo.
		 *      Debe capturar la excepción SQLException y propagar una Exception más amigable.
		 */

		logger.info("Se intenta obtener el saldo de cliente {}", 3);

		if (this.tarjeta == null ) {
			throw new Exception("El cliente no ingresó la tarjeta");
		}

		Double saldo = 1.0;
		try{
			long t = Long.parseLong(this.tarjeta);
			String sql = "SELECT saldo " +
						 "FROM Tarjeta NATURAL JOIN caja_ahorro " +
						 "WHERE nro_tarjeta = " + t;
			ResultSet rs = this.consulta(sql);
			if(rs != null){
				if (rs.next()){
					saldo = rs.getDouble("saldo");
				}
				rs.close();
			}
		}catch (java.sql.SQLException ex) {
			System.out.println("Mensaje: " + ex.getMessage());
			System.out.println("Código: " + ex.getErrorCode());
			System.out.println("SQLState: " + ex.getSQLState());
			throw new Exception("Se produjo un error al consultar el saldo de la tarjeta");
		}
		
		return saldo;
	}	

	@Override
	public ArrayList<TransaccionCajaAhorroBean> cargarUltimosMovimientos() throws Exception {
		return this.cargarUltimosMovimientos(ModeloATM.ULTIMOS_MOVIMIENTOS_CANTIDAD);
	}	
	
	@Override
	public ArrayList<TransaccionCajaAhorroBean> cargarUltimosMovimientos(int cantidad) throws Exception
	{
		logger.info("Busca las ultimas {} transacciones en la BD de la tarjeta {}",cantidad, tarjeta);

		ArrayList<TransaccionCajaAhorroBean> lista_movimientos = new ArrayList<TransaccionCajaAhorroBean>();

		try{
			long t = Long.parseLong(this.tarjeta);
			String sql = "SELECT fecha, hora, tipo, IF(tipo = 'Deposito', monto, monto * -1) AS monto, cod_caja, destino " +
						 "FROM trans_cajas_ahorro, Tarjeta " +
						 "WHERE nro_tarjeta = " + t + " AND trans_cajas_ahorro.nro_ca = Tarjeta.nro_ca " +
						 "ORDER BY fecha DESC,hora DESC";
			ResultSet rs = this.consulta(sql);
			TransaccionCajaAhorroBean fila;
			if(rs != null){
				for(int i = 0;(i < cantidad) && rs.next();i++){
					fila = new TransaccionCajaAhorroBeanImpl();

					fila.setTransaccionFechaHora(Fechas.convertirStringADate(rs.getString("fecha"),rs.getString("hora")));
					
					fila.setTransaccionTipo(rs.getString("tipo"));
					
					fila.setTransaccionMonto(rs.getDouble("monto"));
					
					fila.setTransaccionCodigoCaja(rs.getInt("cod_caja"));
					
					fila.setCajaAhorroDestinoNumero(rs.getInt("destino"));
					
					lista_movimientos.add(fila);
				} 
			
				rs.close();
			}
		}catch (SQLException ex) {
			System.out.println("Mensaje: " + ex.getMessage());
			System.out.println("Código: " + ex.getErrorCode());
			System.out.println("SQLState: " + ex.getSQLState());
			throw new Exception("Se produjo un error al recuperar los últimos movimientos");
		}

		return lista_movimientos;
	}	
	
	@Override
	public ArrayList<TransaccionCajaAhorroBean> cargarMovimientosPorPeriodo(Date desde, Date hasta)
			throws Exception {

		if(desde == null || hasta == null || desde.after(hasta) || hasta.after(java.util.Calendar.getInstance().getTime())){
			throw new Exception("Las fechas ingresadas no son válidas");
		}

		ArrayList<TransaccionCajaAhorroBean> lista_movimientos = new ArrayList<TransaccionCajaAhorroBean>();

		try{
			long t = Long.parseLong(this.tarjeta);
			String sql = "SELECT fecha, hora, tipo,  IF(tipo = 'Deposito', monto, monto * -1) AS monto, cod_caja, destino " +
						 "FROM trans_cajas_ahorro, Tarjeta " +
						 "WHERE nro_tarjeta = " + t + " AND trans_cajas_ahorro.nro_ca = Tarjeta.nro_ca AND fecha >= '" + Fechas.convertirDateADateSQL(desde) + "' AND fecha <= '" + Fechas.convertirDateADateSQL(hasta) + "' " +
						 "ORDER BY fecha DESC,hora DESC";
			ResultSet rs = this.consulta(sql);
			TransaccionCajaAhorroBean fila;
			if(rs != null){
				while(rs.next()){
					fila = new TransaccionCajaAhorroBeanImpl();

					fila.setTransaccionFechaHora(Fechas.convertirStringADate(rs.getString("fecha"),rs.getString("hora")));
					
					fila.setTransaccionTipo(rs.getString("tipo"));
					
					fila.setTransaccionMonto(rs.getDouble("monto"));
					
					fila.setTransaccionCodigoCaja(rs.getInt("cod_caja"));
					
					fila.setCajaAhorroDestinoNumero(rs.getInt("destino"));
					
					lista_movimientos.add(fila);
				} 
		
				rs.close();
			}
		}catch (SQLException ex) {
			System.out.println("Mensaje: " + ex.getMessage());
			System.out.println("Código: " + ex.getErrorCode());
			System.out.println("SQLState: " + ex.getSQLState());
			throw new Exception("Se produjo un error al recuperar los movimientos por período");
		}

		return lista_movimientos;
	}
	
	@Override
	public Double extraer(Double monto) throws Exception {
		logger.info("Realiza la extraccion de ${} sobre la cuenta", monto);
		
		/**
		 * TODO Deberá extraer de la cuenta del cliente el monto especificado (ya validado) y de obtener el saldo de la cuenta como resultado.
		 * 		Debe capturar la excepción SQLException y propagar una Exception más amigable. 
		 * 		Debe generar excepción si las propiedades codigoATM o tarjeta no tienen valores
		 */		
	
		if(this.codigoATM == null || this.tarjeta == null){
			throw new Exception("codigoATM o tarjeta no tienen valores");
		}

		String resultado = ModeloATM.EXTRACCION_EXITOSA;
		int caja = 0;

		try{
			long t = Long.parseLong(this.tarjeta);
			String sql1 = "SELECT nro_ca " +
						  "FROM Tarjeta " +
						  "WHERE nro_tarjeta = " + t;
			ResultSet rs1 = this.consulta(sql1);
			if(rs1 != null){
				if(rs1.next()){
					caja = rs1.getInt("nro_ca");
				}
				rs1.close();
			}

			String sql2 = "call extraer(" + caja + ", " + monto + ", "+ codigoATM +")";
			ResultSet rs2 = this.consulta(sql2);
			if(rs2 != null){
				if(rs2.next()){
					resultado = rs2.getString("resultado");
				}
				rs2.close();
			}
		}catch(SQLException ex){
			throw new Exception("Se produjo un error al realizar la extraccion");
		}
		
		if (!resultado.equals(ModeloATM.EXTRACCION_EXITOSA)) {
			throw new Exception(resultado);
		}

		return this.obtenerSaldo();
	}

	
	@Override
	public int parseCuenta(String p_cuenta) throws Exception {
		
		logger.info("Intenta realizar el parsing de un codigo de cuenta {}", p_cuenta);

		/**
		 * TODO Verifica que el codigo de la cuenta sea valido. 
		 * 		Debe capturar la excepción SQLException y propagar una Exception más amigable. 
		 * 		Debe generar excepción si la cuenta es vacia, entero negativo o no puede generar el parsing.
		 * retorna la cuenta en formato int
		 */
		
		if(p_cuenta == null){
			throw new Exception("La cuenta ingresada es nula");
		}

		int cuenta = Integer.parseInt(p_cuenta);

		if(cuenta <= 0){
			throw new Exception("La cuenta es un número menor o igual a cero");
		}

		return cuenta;
	}	
	
	@Override
	public Double transferir(Double monto, int cajaDestino) throws Exception {
		logger.info("Realiza la transferencia de ${} sobre a la cuenta {}", monto, cajaDestino);
		
		/**
		 * TODO Deberá extraer de la cuenta del cliente el monto especificado (ya validado) y de obtener el saldo de la cuenta como resultado.
		 * 		Debe capturar la excepción SQLException y propagar una Exception más amigable. 
		 * 		Debe generar excepción si las propiedades codigoATM o tarjeta no tienen valores
		 */		
		if(this.codigoATM == null || this.tarjeta == null){
			throw new Exception("codigoATM o tarjeta no tienen valores");
		}

		String resultado = ModeloATM.TRANSFERENCIA_EXITOSA;
		int cajaOrigen = 0;

		try{
			long t = Long.parseLong(this.tarjeta);
			String sql1 = "SELECT nro_ca " +
						  "FROM Tarjeta " +
						  "WHERE nro_tarjeta = " + t;
			ResultSet rs1 = this.consulta(sql1);
			if(rs1 != null){
				if(rs1.next()){
					cajaOrigen = rs1.getInt("nro_ca");
				}
				rs1.close();
			}

			String sql2 = "call transferir(" + cajaOrigen + ", " + cajaDestino + ", " + monto + ", "+ codigoATM + ")";
			ResultSet rs2 = this.consulta(sql2);
			if(rs2 != null){
				if(rs2.next()){
					resultado = rs2.getString("resultado");
				}
				rs2.close();
			}
		}catch(SQLException ex){
			throw new Exception("Se produjo un error al realizar la transferencia");
		}
		
		if (!resultado.equals(ModeloATM.TRANSFERENCIA_EXITOSA)) {
			throw new Exception(resultado);
		}

		return this.obtenerSaldo();
	}


	@Override
	public Double parseMonto(String p_monto) throws Exception {
		
		logger.info("Intenta realizar el parsing del monto {}", p_monto);
		
		if (p_monto == null) {
			throw new Exception("El monto no puede estar vacío");
		}

		try 
		{
			double monto = Double.parseDouble(p_monto);
			DecimalFormat df = new DecimalFormat("#.00");

			monto = Double.parseDouble(corregirComa(df.format(monto)));
			
			if(monto < 0)
			{
				throw new Exception("El monto no debe ser negativo.");
			}
			
			return monto;
		}		
		catch (NumberFormatException e)
		{
			throw new Exception("El monto no tiene un formato válido.");
		}	
	}

	private String corregirComa(String n)
	{
		String toReturn = "";
		
		for(int i = 0;i<n.length();i++)
		{
			if(n.charAt(i)==',')
			{
				toReturn = toReturn + ".";
			}
			else
			{
				toReturn = toReturn+n.charAt(i);
			}
		}
		
		return toReturn;
	}	
	
	

	
}
