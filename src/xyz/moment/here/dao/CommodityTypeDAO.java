package xyz.moment.here.dao;

import xyz.moment.here.po.CommodityType;
import xyz.moment.here.util.DBClient;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommodityTypeDAO {
    private static DBClient database = new DBClient("leaf","123456789","jdbc:mysql://localhost:3306/myshop");

    public static List<CommodityType> getAllTypes() throws SQLException, ClassNotFoundException {
        String sql = "select TID, typeName from commodityType";
        List<CommodityType> types = new ArrayList<>();
        ResultSet resultSet = database.query(sql,database.getConnection());
        while (resultSet.next()) {
            CommodityType type = new CommodityType();
            type.setTypeName(resultSet.getString("typeName"));
            type.setTID(resultSet.getString("TID"));
            types.add(type);
        }
        return types;
    }
}