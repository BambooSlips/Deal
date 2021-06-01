package xyz.moment.here.service;

import xyz.moment.here.dao.UserDAO;
import xyz.moment.here.po.User;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserFilter {
    public List<User> allUsers() throws SQLException, ClassNotFoundException {
        String sql = "select * from user";
        return UserDAO.selectUsers(sql);
    }

    public List<User> normalUsers() throws SQLException, ClassNotFoundException {
        String sql = "select * from user where status = 1 ";
        return UserDAO.selectUsers(sql);
    }

    public List<User> lockedUsers() throws SQLException, ClassNotFoundException {
        String sql = "select * from user where status = 0";
        return UserDAO.selectUsers(sql);
    }

    public List<User> inactiveUsers() throws SQLException, ClassNotFoundException {
        String sql = "select * from user where status = -1";
        return UserDAO.selectUsers(sql);
    }

    public List<User> filtrate(String sql) throws SQLException, ClassNotFoundException {
        return UserDAO.selectUsers(sql);
    }

    public User selectedUser(String UID) throws SQLException, ClassNotFoundException {
        String sql = "select * from user where UID = '"+UID+"'";
        User user = UserDAO.queryUser(sql);
        return user;
    }
}
