package xyz.moment.here.po;

import java.util.Date;

public class OrderForm {
    private String OID;
    private String UID;
    private String username;
    private String phoneNumber;
    private String address;
    private Date createdTime;
    private float totalPrice;

    public OrderForm(String OID, String UID, String username, String phoneNumber, String address, Date createdTime,
                     float totalPrice) {
        this.OID = OID;
        this.UID = UID;
        this.username = username;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.createdTime = createdTime;
        this.totalPrice = totalPrice;
    }

    public OrderForm(String OID, String UID, String username, String phoneNumber, String address, float totalPrice) {
        this.OID = OID;
        this.UID = UID;
        this.username = username;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.totalPrice = totalPrice;
    }

    public OrderForm(String UID, String username, String phoneNumber, String address, Date createdTime, float totalPrice) {
        this.UID = UID;
        this.username = username;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.createdTime = createdTime;
        this.totalPrice = totalPrice;
    }

    public OrderForm(String UID, String username, String phoneNumber, String address, float totalPrice) {
        this.UID = UID;
        this.username = username;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.totalPrice = totalPrice;
    }

    public OrderForm() { }

    public String getOID() {
        return OID;
    }

    public void setOID(String OID) {
        this.OID = OID;
    }

    public String getUID() {
        return UID;
    }

    public void setUID(String UID) {
        this.UID = UID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }
}
