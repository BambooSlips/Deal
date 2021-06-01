package xyz.moment.here.po;

import java.util.Date;

public class Commodity {
    private String CID;
    private String TID;
    private String IID;
    private String name;
    private Date publishedDate;
    private float price;
    private int inventory;
    private int viewedTime;
    private String description;
    private String photo;
    private int status;

    public Commodity() { }

    public Commodity(String CID, String TID, String IID, String name, Date publishedDate, float price, int inventory,
                     int viewedTime, String description, String photo, int status) {
        this.CID = CID;
        this.TID = TID;
        this.IID = IID;
        this.name = name;
        this.publishedDate = publishedDate;
        this.price = price;
        this.inventory = inventory;
        this.viewedTime = viewedTime;
        this.description = description;
        this.photo = photo;
        this.status = status;
    }

    public String getCID() {
        return CID;
    }

    public void setCID(String CID) {
        this.CID = CID;
    }

    public String getTID() {
        return TID;
    }

    public void setTID(String TID) {
        this.TID = TID;
    }

    public String getIID() {
        return IID;
    }

    public void setIID(String IID) {
        this.IID = IID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(Date publishedDate) {
        this.publishedDate = publishedDate;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getInventory() {
        return inventory;
    }

    public void setInventory(int inventory) {
        this.inventory = inventory;
    }

    public int getViewedTime() {
        return viewedTime;
    }

    public void setViewedTime(int viewedTime) {
        this.viewedTime = viewedTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
