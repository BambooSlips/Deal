package xyz.moment.here.util;


import java.sql.*;

public class DBClient {
    private String username = "";
    private String password = "";
    private String jdbcDriver = "com.mysql.cj.jdbc.Driver";
    private String dbURL = "";
    private Connection con = null;
    private Statement stmt = null;

    public DBClient(String username, String password, String dbURL) {
        this.username = username;
        this.password = password;
        this.jdbcDriver = jdbcDriver;
        this.dbURL = dbURL;
    }

    public Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName(jdbcDriver);
        // 打开链接
        System.out.println("连接数据库...");
        con = DriverManager.getConnection(dbURL, username, password);
        return con;
    }

    public ResultSet query(String sql, Connection con) throws SQLException {
        stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery(sql);
        return resultSet;
    }

    public boolean execute(String sql, Connection con) throws SQLException {
        stmt = con.createStatement();
        if(stmt.execute(sql))
        {
            System.out.println("更新成功！");
            return true;
        }
        else {
            //System.out.println("更新失败！");
            return false;
        }
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setJdbcDriver(String jdbcDriver) {
        this.jdbcDriver = jdbcDriver;
    }

    public void setDbURL(String dbURL) {
        this.dbURL = dbURL;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getJdbcDriver() {
        return jdbcDriver;
    }

    public String getDbURL() {
        return dbURL;
    }
}
