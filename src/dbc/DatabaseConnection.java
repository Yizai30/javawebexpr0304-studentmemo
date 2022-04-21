package dbc;

import java.sql.* ;
public class DatabaseConnection {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/student_memo" +
            "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";
    private Connection conn;
    public DatabaseConnection() throws Exception {
        Class.forName(DRIVER);
        this.conn = DriverManager.getConnection(URL, USER, PASSWORD);
    }
    public Connection getConn() {
        return conn;
    }
    public void setConn(Connection conn) {
        this.conn = conn;
    }
    public void close() throws Exception {
        if (this.conn != null) {
            try {
                this.conn.close();
            } catch(Exception e) {
                throw e;
            }
        }
    }
}