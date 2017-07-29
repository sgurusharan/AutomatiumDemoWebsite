/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import properties.MySQLProperties;

/**
 *
 * @author Padmanabha
 */
public class MySQLDB {
    private static final MySQLProperties MYSQLPROPERTIES = MySQLProperties.getSingleton();
    
    private static String getConnectionString() {
        return String.format("jdbc:mysql://%s:%d/%s",
                MYSQLPROPERTIES.getHost(),
                MYSQLPROPERTIES.getPort(),
                MYSQLPROPERTIES.getDBName()
        );
    }
    
    private static Connection getDBConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MySQLDB.class.getName()).log(Level.SEVERE, "MySQL DB Driver not found", ex);
            return null;
        }
        try {
            Logger.getLogger(MySQLDB.class.getName()).log(Level.INFO, "Connection String:{0}, Username:{1}, Password:{2}", new Object[]{getConnectionString(), MYSQLPROPERTIES.getUsername(), MYSQLPROPERTIES.getPassword()});
            return DriverManager.getConnection(getConnectionString(), MYSQLPROPERTIES.getUsername(), MYSQLPROPERTIES.getPassword());
        } catch (SQLException ex) {
            Logger.getLogger(MySQLDB.class.getName()).log(Level.SEVERE, "Unable to create MySQL connection", ex);
            return null;
        }
    }
    
    public static ResultSet executeQuery(String query) throws SQLException {
        return getDBConnection().createStatement().executeQuery(query);
    }
    
    public static int executeUpdate(String updateQuery) throws SQLException {
        return getDBConnection().createStatement().executeUpdate(updateQuery);
    }
}
