package xyz.moment.here.dao;

import xyz.moment.here.po.User;
import xyz.moment.here.util.DBClient;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public static DBClient database = new DBClient("leaf","123456789",
            "jdbc:mysql://localhost:3306/myshop");

    public static void userRegister(String sql) throws SQLException, ClassNotFoundException {
        database.execute(sql,database.getConnection());
    }

    public static User queryUser(String sql) throws SQLException, ClassNotFoundException {
        User user = new User();
        ResultSet resultSet = database.query(sql, database.getConnection());
        while (resultSet.next()){
            user.setUID(resultSet.getString("UID"));
            user.setUsername(resultSet.getString("username"));
            user.setPassword(resultSet.getString("password"));
            //user.setBirthday(resultSet.getString("birthday"));
            user.setAddress(resultSet.getString("address"));
            user.setPhoneNumber(resultSet.getString("phoneNumber"));
            user.setStatus(resultSet.getInt("status"));
            user.setActivationCode(resultSet.getString("activationCode"));
            user.setRegisterTime(resultSet.getTime("registerTime"));
            user.setPhoto(resultSet.getString("photo"));
        }
        return user;
    }

    public static List<User> selectUsers(String sql) throws SQLException, ClassNotFoundException {
        List<User> selectedUsers = new ArrayList<>();
        User user = new User();
        ResultSet resultSet = database.query(sql, database.getConnection());
        while (resultSet.next()){
            user.setUID(resultSet.getString("UID"));
            user.setUsername(resultSet.getString("username"));
            user.setPassword(resultSet.getString("password"));
            user.setAddress(resultSet.getString("address"));
            user.setPhoneNumber(resultSet.getString("phoneNumber"));
            user.setStatus(resultSet.getInt("status"));
            user.setActivationCode(resultSet.getString("activationCode"));
            user.setRegisterTime(resultSet.getTime("registerTime"));
            user.setPhoto(resultSet.getString("photo"));
            selectedUsers.add(user);
        }
        return selectedUsers;
    }

    public static void alterUser(User user) throws SQLException, ClassNotFoundException {
        String sql0 = "update user set ";
        if(!"".equals(user.getUsername())){
            String sql = sql0 + "username = '" + user.getUsername() +"' where UID='"+user.getUID()+"'";
            System.out.println(sql);
            database.execute(sql,database.getConnection());
        }
        if(!"".equals(user.getPassword())){
            String sql = sql0 + "password='"+ user.getPassword() +"' where UID='"+user.getUID()+"'";
            System.out.println(sql);
            database.execute(sql,database.getConnection());
        }
        if(!"".equals(user.getAddress())){
            String sql = sql0 + "address='"+user.getAddress() + "' where UID='"+user.getUID()+"'";
            System.out.println(sql);
            database.execute(sql,database.getConnection());
        }
        if(!"".equals(user.getPhoneNumber())){
            String sql = sql0 + "phoneNumber='"+user.getPhoneNumber() + "' where UID='"+user.getUID()+"'";
            System.out.println(sql);
            database.execute(sql,database.getConnection());
        }

        if(!"".equals(String.valueOf(user.getStatus()))) {
            String sql = sql0 + "status = "+user.getStatus();
            System.out.println(sql);
            database.execute(sql, database.getConnection());
        }

        if(!"".equals(user.getPhoto())){
            String sql = sql0 + "photo='"+user.getPhoto() + "' where UID='"+user.getUID()+"'";
            System.out.println(sql);
            database.execute(sql,database.getConnection());
        }
        //getDatabase()
    }
}
