package xyz.moment.here.servlet;

import xyz.moment.here.po.OrderForm;
import xyz.moment.here.po.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DeleteCommodityServlet",urlPatterns = "/DeleteCommodityServlet")
public class DeleteCommodityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<OrderItem> myCart = (List<OrderItem>) session.getAttribute("myCart");
        String var = request.getParameter("key");//此时var的值就是value
        System.out.println(var);
        String[] temp;
        String delimeter = ",";                 // 指定分割字符
        temp = var.split(delimeter);            // 分割字符串
        //删除商品
        for(int i = 0; i < temp.length; i++){
            for(int j = 0; j < myCart.size(); j++){
                if(myCart.get(j).getIID().equals(temp[i])){
                    System.out.println(temp[i]);
                    myCart.remove(j);
                }
            }
        }
        //返回购物车界面
        response.sendRedirect("cart.jsp");
    }
}
