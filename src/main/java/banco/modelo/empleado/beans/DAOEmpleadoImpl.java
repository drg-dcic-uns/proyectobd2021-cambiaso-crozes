package banco.modelo.empleado.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DAOEmpleadoImpl implements DAOEmpleado {

	private static Logger logger = LoggerFactory.getLogger(DAOEmpleadoImpl.class);
	
	private Connection conexion;
	
	public DAOEmpleadoImpl(Connection c) {
		this.conexion = c;
	}


	@Override
	public EmpleadoBean recuperarEmpleado(int legajo) throws Exception {
		logger.info("recupera el empleado que corresponde al legajo {}.", legajo);
	
		EmpleadoBean empleado = null;
		
		try {
			String sql = "SELECT legajo,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc " + 
						"FROM Empleado " +
						"WHERE legajo = " + legajo;
			java.sql.Statement stmt = this.conexion.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs != null && rs.next()) {
				empleado = new EmpleadoBeanImpl();
				empleado.setLegajo(rs.getInt("legajo"));
				empleado.setApellido(rs.getString("apellido"));
				empleado.setNombre(rs.getString("nombre"));
				empleado.setTipoDocumento(rs.getString("tipo_doc"));
				empleado.setNroDocumento(rs.getInt("nro_doc"));
				empleado.setDireccion(rs.getString("direccion"));
				empleado.setTelefono(rs.getString("telefono"));
				empleado.setCargo(rs.getString("cargo"));
				empleado.setPassword(rs.getString("password")); 
				empleado.setNroSucursal(rs.getInt("nro_suc"));
				rs.close();
			}
		}
		catch (SQLException ex)
		{
			throw new Exception("Error al recuperar empleado");
		}
		
		return empleado;
	}

}
