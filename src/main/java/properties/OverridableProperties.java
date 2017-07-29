/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package properties;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Padmanabha
 */
public abstract class OverridableProperties {
    Properties overridableProperties;
    
    public OverridableProperties(String resourcePath) {
        overridableProperties = new Properties();
        try {
            overridableProperties.load(this.getClass().getClassLoader().getResourceAsStream(resourcePath));
        } catch (IOException ex) {
            Logger.getLogger(OverridableProperties.class.getName()).log(Level.SEVERE, "Unable to load resource:" + resourcePath, ex);
        }
    }
    
    public String get(String property) {
        String value = System.getProperty(property, System.getenv(property));
        if (value == null) {
            value = overridableProperties.get(property).toString();
        }
        return value;
    }
}
