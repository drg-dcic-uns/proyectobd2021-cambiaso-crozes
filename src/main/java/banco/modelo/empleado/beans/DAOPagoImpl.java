package banco.modelo.empleado.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.utils.Fechas;


public class DAOPagoImpl implements DAOPago {

	private static Logger logger = LoggerFactory.getLogger(DAOPagoImpl.class);
	
	private Connection conexion;
	
	public DAOPagoImpl(Connection c) {
		this.conexion = c;
	}

	@Override
	public ArrayList<PagoBean> recuperarPagos(int nroPrestamo) throws Exception {
		logger.info("Inicia la recuperacion de los pagos del prestamo {}", nroPrestamo);
		
		/** 
		 * TODO Recupera todos los pagos del prestamo (pagos e impagos) del prestamo nroPrestamo
		 * 	    Si ocurre algún error deberá propagar una excepción.
		 */
		
		
		ArrayList<PagoBean> lista_pagos = new ArrayList<PagoBean>();
		PagoBean fila;

		try {
            String sql = "SELECT nro_prestamo, nro_pago, fecha_venc, fecha_pago " + 
                         "FROM Pago " +
                         "WHERE nro_prestamo = " + nroPrestamo;
            PreparedStatement stmt = conexion.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery(sql);
            if(rs != null) {
                while(rs.next()) {
                    fila = new PagoBeanImpl();
                    fila.setNroPrestamo(rs.getInt("nro_prestamo"));
                    fila.setNroPago(rs.getInt("nro_pago"));
                    fila.setFechaVencimiento(Fechas.convertirStringADate(rs.getString("fecha_venc")));
					fila.setFechaPago(Fechas.convertirStringADate(rs.getString("fecha_pago")));
					lista_pagos.add(fila);
                }
                rs.close();
            }
            stmt.close();
        }
        catch (SQLException ex)
        {
            throw new SQLException("Error al recuperar pagos"); 
        }

		return lista_pagos;
	}

	@Override
    public void registrarPagos(int nroCliente, int nroPrestamo, List<Integer> cuotasAPagar)  throws Exception {

        logger.info("Inicia el pago de las {} cuotas del prestamo {}", cuotasAPagar.size(), nroPrestamo);

        /**
         * TODO Registra los pagos de cuotas definidos en cuotasAPagar.
         * 
         * nroCliente asume que esta validado
         * nroPrestamo asume que está validado
         * cuotasAPagar Debe verificar que las cuotas a pagar no estén pagas (fecha_pago = NULL)
         * @throws Exception Si hubo error en la conexión
         */

        try {
            for(int i = 0; i < cuotasAPagar.size(); i++) {
                String sql = "UPDATE Pago " +
                             "SET fecha_pago = CURDATE() " +
                             "WHERE nro_prestamo = " + nroPrestamo + " AND nro_pago = " + cuotasAPagar.get(i) + " AND fecha_pago is NULL";
                PreparedStatement stmt = conexion.prepareStatement(sql);
                stmt.executeUpdate(sql);
                stmt.close();
            }
        }
        catch (SQLException ex)
        {
            throw new SQLException("Error al registrar pagos"); 
        }

    }
}
