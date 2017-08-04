package db;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Gurusharan S
 */
public class User {
    
    private String email = null, password = null, token = null;
    private int id = -1;
    
    private static SecureRandom secureRandom = new SecureRandom();
    
    private static final String INSERT_QUERY_FORMAT = "INSERT INTO USER (EMAIL, PASSWORD) VALUES ('%s', '%s')";
    private static final String UPDATE_QUERY_FORMAT = "UPDATE USER SET EMAIL='%s', PASSWORD='%s', TOKEN='%s' WHERE %s";
    private static final String SELECT_QUERY_FORMAT = "SELECT * FROM USER WHERE %s";
    private static final String ID_WHERE_CLAUSE_FORMAT = "ID = %d";
    private static final String TOKEN_WHERE_CLAUSE_FORMAT = "TOKEN = '%s'";
    private static final String EMAIL_PASSWORD_WHERE_CLAUSE_FORMAT = "EMAIL = '%s' AND PASSWORD = '%s'";
    
    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }
    
    public User(String token) {
        this.token = token;
    }
    
    public User(int id) {
        this.id = id;
    }
    
    public String getToken() {
        return token;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public boolean addUserToDB() {
        
        if (authenticateUser()) {
            Logger.getLogger(MySQLDB.class.getName()).log(Level.WARNING, "User {0} already in DB - not adding", email);
            return false;
        }
        
        String insertQuery = String.format(INSERT_QUERY_FORMAT, email, password);
        try {
            MySQLDB.executeUpdate(insertQuery);
            if(!authenticateUser()) {
                Logger.getLogger(User.class.getName()).log(Level.SEVERE, "Unable to authenticate user {0} after registration", email);
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
        return true;
    }
    
    public boolean updateUserInDB() {
        if (!authenticateUser(false)) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, "Unable to authenticate user {0} for updating", email);
            return false;
        }
        
        String whereClause = String.format(ID_WHERE_CLAUSE_FORMAT, id);
        String updateQuery = String.format(UPDATE_QUERY_FORMAT, email, password, token, whereClause);
        
        try {
            if (MySQLDB.executeUpdate(updateQuery) <= 0) {
                Logger.getLogger(User.class.getName()).log(Level.WARNING, "User Update did not change any rows");
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, "User Update failed", ex);
            return false;
        }
        
        return true;
    }
    
    private boolean authenticateUser(Boolean updateUserFields) {
        String whereClause;
        if (id >= 0) {
            whereClause = String.format(ID_WHERE_CLAUSE_FORMAT, id);
        }
        else if (token != null) {
            whereClause = String.format(TOKEN_WHERE_CLAUSE_FORMAT, token);
        }
        else if (email != null && password != null) {
            whereClause = String.format(EMAIL_PASSWORD_WHERE_CLAUSE_FORMAT, email, password);
        }
        else {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, "Unable to authenticate user {0} due to insufficient info", this.toString());
            return false;
        }
        
        String selectQuery = String.format(SELECT_QUERY_FORMAT, whereClause);
        try {
            ResultSet resultSet = MySQLDB.executeQuery(selectQuery);
            if (!resultSet.first()) {
                Logger.getLogger(User.class.getName()).log(Level.INFO, "Authentication failed for user {0}", this.toString());
                return false;
            }
            if (updateUserFields) {
                this.id = resultSet.getInt("ID");
                this.email = resultSet.getString("email");
                this.token = resultSet.getString("token");
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, "Unable to authenticate user " + this.toString(), ex);
            return false;
        }
        
        Logger.getLogger(User.class.getName()).log(Level.INFO, "Authentication Successful for user {0}", this.toString());
        return true;
    }
    public boolean authenticateUser() {
        return authenticateUser(true);
    }
    
    public boolean updateToken() {
        if (!authenticateUser(false)) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, "Unable to authenticate user {0}", this.toString());
            return false;
        }
        String oldToken = token;
        String newToken = Integer.toString(id) + new BigInteger(130, secureRandom).toString(32);
        token = newToken.substring(0, 16);
        Logger.getLogger(User.class.getName()).log(Level.INFO, "Unable to update new token for user {0}", this.toString());
        if (!updateUserInDB()) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, "Unable to update new token for user {0}", this.toString());
            token = oldToken;
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return String.format("User (id=%d, email=%s, token=%s)", id, email, token);
    }
    
    
}
