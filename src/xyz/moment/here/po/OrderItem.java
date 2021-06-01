package xyz.moment.here.po;

public class OrderItem {
    private String IID;
    private String OID;
    private String CID;
    private String name;
    private float price;
    private int number;

    public OrderItem() { }

    public OrderItem(String IID, String CID, String name, float price, int number) {
        this.IID = IID;
        this.CID = CID;
        this.name = name;
        this.price = price;
        this.number = number;
    }

    public OrderItem(String CID, String name, float price, int number) {
        this.CID = CID;
        this.name = name;
        this.price = price;
        this.number = number;
    }

    public String getCID() {
        return CID;
    }

    public void setCID(String CID) {
        this.CID = CID;
    }

    public String getIID() {
        return IID;
    }

    public void setIID(String IID) {
        this.IID = IID;
    }

    public String getOID() {
        return OID;
    }

    public void setOID(String OID) {
        this.OID = OID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
}
