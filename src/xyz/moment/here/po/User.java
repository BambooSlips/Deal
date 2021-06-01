package xyz.moment.here.po;

import java.util.Date;

public class User {
    private String UID;
    private String username;
    private String password;
    private String phoneNumber;
    private String address;
    private int status;
    private String activationCode;
    private Date registerTime;
    private String photo;

    public User(String UID, String username, String password, String phoneNumber, String address, int status,
                String activationCode, Date registerTime, String photo) {
        this.UID = UID;
        this.username = username;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.status = status;
        this.activationCode = activationCode;
        this.registerTime = registerTime;
        this.photo = photo;
    }

    public User() { }

    public String getUID() {
        return UID;
    }

    public void setUID(String UID) {
        this.UID = UID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getStatus() {
        return status;
    }

    public String getStatusString() {
        if(this.status == -1) return "未激活";
        if(this.status == 0) return "锁定";
        if(this.status == 1) return "正常";
        return null;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getActivationCode() {
        return activationCode;
    }

    public void setActivationCode(String activationCode) {
        this.activationCode = activationCode;
    }

    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
