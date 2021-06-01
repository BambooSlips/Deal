package xyz.moment.here.dao;

import xyz.moment.here.po.OrderItem;
import xyz.moment.here.util.DBClient;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderItemDAO {
    public static DBClient database = new DBClient("leaf","123456789",
            "jdbc:mysql://localhost:3306/myshop");

    public static void write(OrderItem orderItem) throws SQLException, ClassNotFoundException {
        String sql = "insert into orderItem(IID, OID, CID, name, price, number) values("
                + orderItem.getIID()+", "+orderItem.getOID()+", "+orderItem.getCID()+ ", '"
                + orderItem.getName()+"',"+orderItem.getPrice()+", "+orderItem.getNumber() +")";
        database.execute(sql, database.getConnection());
    }

    public static OrderItem queryItem(String OID) throws SQLException, ClassNotFoundException {
        String sql = "select * from orderItem where OID = " + OID;
        ResultSet resultSet = database.query(sql, database.getConnection());
        OrderItem orderItem = new OrderItem();
        while (resultSet.next()) {
            orderItem.setOID(String.valueOf(resultSet.getInt("IID")));
            orderItem.setOID(String.valueOf(resultSet.getInt("OID")));
            orderItem.setCID(String.valueOf(resultSet.getInt("CID")));
            orderItem.setName(resultSet.getString("name"));
            orderItem.setPrice(resultSet.getFloat("price"));
            orderItem.setNumber(resultSet.getInt("number"));
        }
        return orderItem;
    }
}
