package xyz.moment.here.po;

import java.util.Date;

public class Admin {
    private String AID;
    private String adminname;
    private String password;
    private Date lastLogin;

    public Admin() { }

    public Admin(String AID, String adminname, String password, Date lastLogin) {
        this.AID = AID;
        this.adminname = adminname;
        this.password = password;
        this.lastLogin = lastLogin;
    }

    public String getAID() {
        return AID;
    }

    public void setAID(String AID) {
        this.AID = AID;
    }

    public String getAdminname() {
        return adminname;
    }

    public void setAdminname(String adminname) {
        this.adminname = adminname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }
}
