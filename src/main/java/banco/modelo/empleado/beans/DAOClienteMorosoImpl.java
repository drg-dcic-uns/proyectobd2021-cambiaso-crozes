package banco.modelo.empleado.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DAOClienteMorosoImpl implements DAOClienteMoroso {

	private static Logger logger = LoggerFactory.getLogger(DAOClienteMorosoImpl.class);
	
	private Connection conexion;
	
	public DAOClienteMorosoImpl(Connection c) {
		this.conexion = c;
	}
	
	@Override
    public ArrayList<ClienteMorosoBean> recuperarClientesMorosos() throws Exception {
        
        logger.info("Busca los clientes morosos.");
        
        DAOPrestamo daoPrestamo = new DAOPrestamoImpl(this.conexion);        
        DAOCliente daoCliente = new DAOClienteImpl(this.conexion);
        
        /**
         * TODO Deberá recuperar un listado de clientes morosos los cuales consisten de un bean ClienteMorosoBeanImpl
         *      deberá indicar para dicho cliente cual es el prestamo sobre el que está moroso y la cantidad de cuotas que 
         *      tiene atrasadas. En todos los casos deberá generar excepciones que será capturadas por el controlador
         *      si hay algún error que necesita ser informado al usuario. 
         */
        ArrayList<ClienteMorosoBean> morosos = new ArrayList<ClienteMorosoBean>();
        PrestamoBean prestamo = null;
        ClienteBean cliente = null;
        
        try{
            String sql = "SELECT nro_cliente, nro_prestamo, COUNT(nro_pago) AS cant_cuotas " +
                         "FROM Prestamo NATURAL JOIN Pago " + 
                         "WHERE fecha_venc < CURDATE() AND fecha_pago is NULL " +
                         "GROUP BY nro_cliente, nro_prestamo " +
                         "HAVING cant_cuotas >= 2";
            PreparedStatement stmt = conexion.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery(sql);
            if(rs != null) {
                while(rs.next()){
                    ClienteMorosoBean cliente_m = new ClienteMorosoBeanImpl();
                    prestamo = daoPrestamo.recuperarPrestamo(rs.getInt("nro_prestamo")); 
                    cliente = daoCliente.recuperarCliente(rs.getInt("nro_cliente"));
                    cliente_m.setCliente(cliente);
                    cliente_m.setPrestamo(prestamo);
                    cliente_m.setCantidadCuotasAtrasadas(rs.getInt("cant_cuotas"));  
                    morosos.add(cliente_m);
                } 
                rs.close();
            }
        }catch (SQLException ex) {
            throw new Exception("Se produjo un error al recuperar los clientes morosos");
        }

        return morosos;        
    }

}

