package xyz.moment.here.servlet;

import xyz.moment.here.dao.UserDAO;
import xyz.moment.here.po.Commodity;
import xyz.moment.here.po.OrderForm;
import xyz.moment.here.po.OrderItem;
import xyz.moment.here.po.User;
import xyz.moment.here.service.Purchase;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Random;

@WebServlet(name = "PutinCartServlet", urlPatterns = "/PutinCartServlet")
public class PutinCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("utf-8");
        /*
            添加到购物车：先构造订单与订单项的实质内容，而不为其编号
            若购买则为其编号
         */

        if(session.getAttribute("UID")!=null){
            //获取用户的购物车
            List<OrderItem> myCart = (List<OrderItem>) session.getAttribute("myCart");
            Purchase purchase = new Purchase();
            purchase.setMyCart(myCart);

            User user = new User();

            //构造新订单
            String address = request.getParameter("address");
            Commodity commodity = (Commodity) session.getAttribute("c1");
            System.out.println("PutinCartServlet.java:c1:commodity.getCID()="+commodity.getCID());
            int number = Integer.parseInt(request.getParameter("num"));
            String UID = session.getAttribute("UID").toString();
            String sql = "select * from user where UID= '"+UID+"'";
            try {
                user = UserDAO.queryUser(sql);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }

            //String phone = session.getAttribute("phone").toString();
            System.out.println(address+number);
            System.out.println(commodity.toString());

            //订单项
            Random random = new Random();
            int IID = random.nextInt(999999999);
            //public OrderItem(String IID, String CID, String name, float price, int number)
            OrderItem orderItem = new OrderItem(String.valueOf(IID), commodity.getCID(), commodity.getName(), commodity.getPrice(), number);
            System.out.println("PutinCartServlet.java:orderItem.getCID:"+orderItem.getCID());
            //订单
            /*float totalPrice = orderItem.getPrice() * orderItem.getNumber();
            OrderForm myOrder = new OrderForm(user.getUID(), user.getUsername(), user.getPhoneNumber(), address, totalPrice);
            System.out.println(myOrder.toString());*/

            //更新session中购物车的值
            //比较CID
            /*myCart.add(orderItem);
            for(int i = 0; i < myCart.size(); i++) {
                for(int j = 1; j <myCart.size(); j++) {
                    if(myCart.get(i).getCID().equals(myCart.get(j).getCID())) {
                        System.out.println("购物车中存在同中商品，将其数量相加：[商品:"+myCart.get(i).getName()+"/总数:");
                        myCart.get(i).setNumber(myCart.get(i).getNumber()+myCart.get(j).getNumber());
                        myCart.remove(j);
                        System.out.println(myCart.get(i).getNumber()+"]");
                    }
                }
            }*/
            purchase.addToCart(orderItem);
            //myCart.add(orderItem);
            session.setAttribute("myCart", purchase.getMyCart());

            //显示提示
            response.setContentType("text/html;charset=UTF-8");// 设置生成的文档类型
            PrintWriter out = response.getWriter();// 得到输出字符输出流
            String message = "已添加至购物车！";
            //out.println("<h1>哈哈哈</h1>");
            out.println("<script>" +
                            "var c = confirm('"+message+"');" +
                            "if(c==true){" +
                            "   window.location.href=\"index.jsp\";" +
                            "}" +
                            "else{" +
                                "window.location.href=\"index.jsp\";" +
                            "}" +
                        "</script>");

            //response.sendRedirect("index.jsp");
        }
        else {
            response.sendRedirect("login.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
