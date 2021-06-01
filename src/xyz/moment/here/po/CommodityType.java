package xyz.moment.here.po;

public class CommodityType {
    private String TID;
    private String typeName;

    public CommodityType() { }

    public CommodityType(String TID, String typeName) {
        this.TID = TID;
        this.typeName = typeName;
    }

    public String getTID() {
        return TID;
    }

    public void setTID(String TID) {
        this.TID = TID;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}
