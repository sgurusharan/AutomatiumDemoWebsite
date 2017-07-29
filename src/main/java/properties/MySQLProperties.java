/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package properties;

/**
 *
 * @author Padmanabha
 */
public class MySQLProperties extends OverridableProperties {
    
    private static final MySQLProperties SINGLETON = new MySQLProperties();
    
    private MySQLProperties() {
        super("mysql.properties");
    }
    
    public static MySQLProperties getSingleton() {
        return SINGLETON;
    }
    
    public String getHost() {
        return get(get("env.dbhost"));
    }
    
    public int getPort() {
        String portString = get(get("env.dbport"));
        int port = 0;
        if (portString != null) {
            port = Integer.parseInt(portString);
        }
        return port;
    }
    
    public String getUsername() {
        return get(get("env.dbusername"));
    }
    
    public String getPassword() {
        return get(get("env.dbpassword"));
    }
    
    public String getDBName() {
        return get(get("env.dbname"));
    }
}
