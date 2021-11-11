package banco.modelo.empleado.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.utils.Fechas;

public class DAOClienteImpl implements DAOCliente {

	private static Logger logger = LoggerFactory.getLogger(DAOClienteImpl.class);
	
	private Connection conexion;
	
	public DAOClienteImpl(Connection c) {
		this.conexion = c;
	}
	
	@Override
	public ClienteBean recuperarCliente(String tipoDoc, int nroDoc) throws Exception {

		logger.info("recupera el cliente con documento de tipo {} y nro {}.", tipoDoc, nroDoc);
		
		/**
		 * TODO Recuperar el cliente que tenga un documento que se corresponda con los parámetros recibidos.  
		 *		Deberá generar o propagar una excepción si no existe dicho cliente o hay un error de conexión.		
		 */
		
		ClienteBean cliente = null;

		try {
			String sql = "SELECT nro_cliente,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,fecha_nac " + 
						"FROM Cliente " +
						"WHERE tipo_doc = '" + tipoDoc + "' AND nro_doc = " + nroDoc;
			PreparedStatement  stmt = this.conexion.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery(sql);
			if(rs != null && rs.next()) {
				cliente = new ClienteBeanImpl();
				cliente.setNroCliente(rs.getInt("nro_cliente"));
				cliente.setApellido(rs.getString("apellido"));
				cliente.setNombre(rs.getString("nombre"));
				cliente.setTipoDocumento(rs.getString("tipo_doc"));
				cliente.setNroDocumento(rs.getInt("nro_doc"));
				cliente.setDireccion(rs.getString("direccion"));
				cliente.setTelefono(rs.getString("telefono"));
				cliente.setFechaNacimiento(rs.getDate("fecha_nac"));
				rs.close();
			}
			stmt.close();
		}
		catch (SQLException ex)
		{
			throw new Exception("Error al recuperar cliente"); 
		}

		if(cliente == null){
			throw new Exception("El cliente no existe");
		}
		
		return cliente;	
	}

	@Override
    public ClienteBean recuperarCliente(Integer nroCliente) throws Exception {
        logger.info("recupera el cliente por nro de cliente.");

        /**
         * TODO Recuperar el cliente que tenga un número de cliente de acuerdo al parámetro recibido.
         *        Deberá generar o propagar una excepción si no existe dicho cliente o hay un error de conexión.
         */

        ClienteBean cliente = null;

        try {
            String sql = "SELECT nro_cliente, apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac " + 
                         "FROM Cliente " +
                         "WHERE nro_cliente = " + nroCliente;
            PreparedStatement stmt = conexion.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery(sql);
            if(rs != null) {
                if (rs.next()) {
                    cliente = new ClienteBeanImpl();
                    cliente.setNroCliente(rs.getInt("nro_cliente"));
                    cliente.setApellido(rs.getString("apellido"));
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setTipoDocumento(rs.getString("tipo_doc"));
                    cliente.setNroDocumento(rs.getInt("nro_doc"));
                    cliente.setDireccion(rs.getString("direccion"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setFechaNacimiento(rs.getDate("fecha_nac"));
                    rs.close();
                }
            }
            stmt.close();
        }
        catch (java.sql.SQLException ex)
        {
            throw new SQLException("Error al recuperar cliente"); 
        }

        return cliente;
    }
}


