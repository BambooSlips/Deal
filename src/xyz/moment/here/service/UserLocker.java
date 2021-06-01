package xyz.moment.here.service;

import xyz.moment.here.dao.UserDAO;
import xyz.moment.here.po.User;

import java.sql.SQLException;

public class UserLocker {

    /*
     * 已激活的正常用户 1
     * 被锁定的用户    0
     * 未激活的用户    -1
     */

    private UserFilter userFilter = new UserFilter();

    public void lock(String UID) throws SQLException, ClassNotFoundException {
        User user = userFilter.selectedUser(UID);
        if(user.getStatus() == 1) {
            System.out.println("locking...");
            user.setStatus(0);
            UserDAO.alterUser(user);
        }
    }

    public void unlock(String UID) throws SQLException, ClassNotFoundException {
        User user = userFilter.selectedUser(UID);
        if(user.getStatus() == 0) {
            System.out.println("unlocking...");
            user.setStatus(1);
            UserDAO.alterUser(user);
        }
    }

    public void activate(String UID) throws SQLException, ClassNotFoundException {
        User user = userFilter.selectedUser(UID);
        if(user.getStatus() == -1) {
            System.out.println("activating...");
            user.setStatus(1);
            UserDAO.alterUser(user);
        }
    }
}
