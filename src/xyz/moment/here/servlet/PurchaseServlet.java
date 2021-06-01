package xyz.moment.here.servlet;

import xyz.moment.here.dao.OrderFormDAO;
import xyz.moment.here.po.OrderForm;
import xyz.moment.here.po.OrderItem;
import xyz.moment.here.service.Purchase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "PurchaseServlet",urlPatterns = "/PurchaseServlet")
public class PurchaseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userid = session.getAttribute("UID").toString();
        List<OrderItem> myCart = (List<OrderItem>) session.getAttribute("myCart");
        List<OrderForm> myOrders = null;
        Purchase purchase = new Purchase();
        purchase.getMyCart();

        String var = request.getParameter("key");//此时var的值就是value
        System.out.println(var);
        String[] temp;
        String delimeter = ",";                 // 指定分割字符
        temp = var.split(delimeter);            // 分割字符串
        System.out.println("PurchaseServlet.java:temp.length-->"+temp.length);
        System.out.println("PurchaseServlet.java:myCart.size()-->"+myCart.size());
        System.out.println("PurchaseServlet.java:purchase.getMyCart().size()"+purchase.getMyCart().get(0).getCID());
        //将订单录入数据库
        for(int i = 0; i < temp.length; i++){
            for(int j = 0; j < myCart.size(); j++){
                if(myCart.get(j).getIID().equals(temp[i])){
                    System.out.println("i-->"+i+"//j-->"+j);
                    System.out.println(temp[i]);
                    try {
                        System.out.println("i--"+i+"myCart.size():"+myCart.size());
                        System.out.println("PurchaseServlet.java:myCart.get(i):myCart.get(i).getCID()="+myCart.get(i).getCID());
                        purchase.buyNow(userid, myCart.get(i));
                        /*
                        OrderFormDAO.purchase(myCart.get(i), date);
                        DateFormat df2 = DateFormat.getDateTimeInstance();//可以精确到时分秒
                        myCart.get(i).setDealDate(df2.format(date));
                        myOrders.add(myCart.get(i));
                        System.out.println(myCart.get(i).toString());
                        */
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        //更新订单
        try {
            myOrders = OrderFormDAO.queryAllUserOrders(userid);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        session.setAttribute("myOrders",myOrders);

        //将所选商品从购物车中删除
        for(int i = 0; i < temp.length; i++){
            for(int j = 0; j < myCart.size(); j++){
                /*
                if(myCart.get(j).getID().equals(temp[i])){
                    System.out.println(temp[i]);
                    myCart.remove(j);
                }
                */

            }
        }

        //返回购物车界面
        response.sendRedirect("cart.jsp");
    }
}
