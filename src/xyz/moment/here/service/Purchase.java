package xyz.moment.here.service;

import xyz.moment.here.dao.OrderFormDAO;
import xyz.moment.here.dao.OrderItemDAO;
import xyz.moment.here.dao.UserDAO;
import xyz.moment.here.po.OrderForm;
import xyz.moment.here.po.OrderItem;
import xyz.moment.here.po.User;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class Purchase {
    private static List<OrderItem> myCart = new ArrayList<OrderItem>();
    private static List<OrderForm> myOrders = new ArrayList<OrderForm>();

    public List<OrderItem> getMyCart() {
        return myCart;
    }

    public void setMyCart(List<OrderItem> myCart) {
        Purchase.myCart = myCart;
    }

    public List<OrderForm> getMyOrders() {
        return myOrders;
    }

    public void setMyOrders(List<OrderForm> myOrders) {
        Purchase.myOrders = myOrders;
    }

    public Purchase() {
    }

    public Purchase(List<OrderItem> myCart, List<OrderForm> myOrders) {
        Purchase.myCart = myCart;
        Purchase.myOrders = myOrders;
    }

    public void addToCart(OrderItem orderItem) {
        myCart.add(orderItem);
        for(int i = 0; i < myCart.size(); i++) {
            for(int j = 1; j <myCart.size(); j++) {
                if(myCart.get(i).getCID().equals(myCart.get(j).getCID()) && i != j) {
                    //System.out.println("myCart.size()="+myCart.size());
                    System.out.println("i="+i+"/j="+j);
                    System.out.println(myCart.get(i).getName()+"/"+myCart.get(j).getName());
                    System.out.println("购物车中存在同中商品，将其数量相加：[商品:"+myCart.get(i).getName()+"/总数:");
                    myCart.get(i).setNumber(myCart.get(i).getNumber()+myCart.get(j).getNumber());
                    myCart.remove(j);
                    System.out.println(myCart.get(i).getNumber()+"]");
                }
            }
        }
    }

    public void buyNow(String UID, OrderItem orderItem) throws SQLException, ClassNotFoundException {
        User user = new User();
        String sql = "select * from user where UID='"+UID+"'";
        user = UserDAO.queryUser(sql);
        Random random = new Random();
        int OID = random.nextInt(999999999);
        orderItem.setOID(String.valueOf(OID));
        //构造订单
        OrderForm orderForm = new OrderForm(String.valueOf(OID), UID, user.getUsername(), user.getPhoneNumber(),
                user.getAddress(),orderItem.getPrice()*orderItem.getNumber());

        //将订单及订单项写入数据库
        OrderFormDAO.write(orderForm);
        OrderItemDAO.write(orderItem);
    }
}
