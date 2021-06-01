package xyz.moment.here.service;

import xyz.moment.here.dao.OrderFormDAO;
import xyz.moment.here.po.OrderForm;

import java.sql.SQLException;
import java.util.List;

public class OrderFilter {
    public List<OrderForm> allOrders() throws SQLException, ClassNotFoundException {
        String sql = "select * from orderForm";
        return OrderFormDAO.selectOrders(sql);
    }
}
