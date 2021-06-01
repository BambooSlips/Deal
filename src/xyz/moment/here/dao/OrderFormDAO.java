package xyz.moment.here.dao;

import xyz.moment.here.po.OrderForm;
import xyz.moment.here.po.OrderItem;
import xyz.moment.here.po.User;
import xyz.moment.here.util.DBClient;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderFormDAO {
    public static DBClient database = new DBClient("leaf","123456789",
            "jdbc:mysql://localhost:3306/myshop");

    public static List<OrderForm> queryAllUserOrders(String UID) throws SQLException, ClassNotFoundException {
        String sql = "select * from orderForm join orderItem on orderForm.OID= orderItem.OID where UID =  '"+UID+"'";  //视图
        System.out.println(sql);
        List<OrderForm> myOrders = new ArrayList<OrderForm>();
        ResultSet resultSet = database.query(sql, database.getConnection());
        int i = 0;
        while (resultSet.next()){
            OrderForm order = new OrderForm();
            order.setOID(resultSet.getString("OID"));
            order.setUID(resultSet.getString("UID"));
            order.setUsername(resultSet.getString("username"));
            order.setPhoneNumber(resultSet.getString("phoneNumber"));
            order.setCreatedTime(new Date(resultSet.getTimestamp("createdTime").getTime()));
            order.setAddress(resultSet.getString("address"));
            order.setTotalPrice(resultSet.getInt("totalPrice"));

            //String commodity = "select * from commodities where ID = '"+resultSet.getString("CID") +"'";

            myOrders.add(order);
            System.out.println("*************"+ i);
            i++;
        }
        return myOrders;
    }

    /*public static void purchase(OrderItem myOrder, Date date) throws SQLException, ClassNotFoundException {
        //Date date = new Date();
        long orderID = 1;
        String queryUser = "select * from users where ID = '"+myOrder.getUID()+"'";
        User user = UserDAO.queryUser(queryUser);
        String sql = "insert into orders(ID, userid, dealdate, totalprice, username, address, phone, status) values('"+orderID+"','"+
                myOrder.getUID()+"',current_timestamp(),'"+myOrder.getTotalPrice()+"','"+user.getUsername()+"','"+myOrder.getAddress()+"','"+
                myOrder.getPhoneNumber()+"','买家已付款')";
        System.out.println(sql);
        String addOrderItem = "insert into orderItem(commodityID, number, totalPrice, orderID) values('"+
                myOrder.getOID()+"','"+myOrder.getOID()+"','"+myOrder.getTotalPrice()+"','"+orderID+"')";
        database.execute(sql,database.getConnection());
        database.execute(addOrderItem,database.getConnection());
    }*/

    public static void write(OrderForm orderForm) throws SQLException, ClassNotFoundException {
        String sql = "insert into orderForm(OID, UID, username, phoneNumber, address, createdTime, totalPrice) " +
                "values("+orderForm.getOID()+", '"+orderForm.getUID()+"', '"+orderForm.getUsername()+"', '"
                +orderForm.getPhoneNumber()+"', '"+orderForm.getAddress()+"', current_timestamp(),'"
                +orderForm.getTotalPrice()+"')";
        database.execute(sql, database.getConnection());
        System.out.println(sql);
    }

    public static List<OrderForm> selectOrders(String sql) throws SQLException, ClassNotFoundException {
        ResultSet resultSet = database.query(sql, database.getConnection());
        List<OrderForm> allOrders = new ArrayList<OrderForm>();
        while(resultSet.next()) {
            OrderForm orderForm = new OrderForm();
            orderForm.setOID(String.valueOf(resultSet.getInt("OID")));
            orderForm.setUID(resultSet.getString("UID"));
            orderForm.setUsername(resultSet.getString("username"));
            orderForm.setPhoneNumber(resultSet.getString("phoneNumber"));
            orderForm.setAddress(resultSet.getString("address"));
            orderForm.setCreatedTime(resultSet.getTimestamp("createdTime"));
            orderForm.setTotalPrice((resultSet.getFloat("totalPrice")));
            allOrders.add(orderForm);
        }
        return allOrders;
    }
}
