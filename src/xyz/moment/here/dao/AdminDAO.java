package xyz.moment.here.dao;

import xyz.moment.here.po.Admin;
import xyz.moment.here.po.User;
import xyz.moment.here.util.DBClient;

import java.sql.SQLException;

public class AdminDAO {
    private static DBClient database = new DBClient("leaf","123456789",
            "jdbc:mysql://localhost:3306/myshop");

    public static void updateLoginTime() throws SQLException, ClassNotFoundException {
        String sql = "update admin set lastLogin = current_timestamp()";
        database.execute(sql,database.getConnection());
    }

    public static void alterAdmin(Admin admin) throws SQLException, ClassNotFoundException {
        String sql0 = "update admin set ";
        if(!"".equals(admin.getAdminname())){
            String sql = sql0 + "adminname = '" + admin.getAdminname() +"' where ID='"+admin.getAID()+"'";
            System.out.println(sql);
            database.execute(sql,database.getConnection());
        }
        if(!"".equals(admin.getPassword())){
            String sql = sql0 + "password='"+ admin.getPassword() +"' where ID='"+admin.getAID()+"'";
            System.out.println(sql);
            database.execute(sql,database.getConnection());
        }
        /*if(!"".equals(user.getBirthday())){
            String sql = sql0+ "birthday='"+user.getBirthday() +"' where ID='"+user.getID()+"'";
            System.out.println(sql);
            database.execute(sql,getDatabase().getConnection());
        }*/
       /* if(!"".equals(admin.getAddress())){
            String sql = sql0 + "address='"+user.getAddress() + "' where ID='"+user.getUID()+"'";
            System.out.println(sql);
            database.execute(sql,database.getConnection());
        }
        if(!"".equals(user.getPhoneNumber())){
            String sql = sql0 + "phone='"+user.getPhoneNumber() + "' where ID='"+user.getUID()+"'";
            System.out.println(sql);
            database.execute(sql,database.getConnection());
        }*/
        //getDatabase()
    }
}
