package xyz.moment.here.servlet;

import xyz.moment.here.dao.OrderFormDAO;

import xyz.moment.here.po.OrderForm;
import xyz.moment.here.po.OrderItem;
import xyz.moment.here.util.DBClient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "LoginServlet",urlPatterns = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        //初始化购物车与订单
        List<OrderItem> myCart = new ArrayList<OrderItem>();
        List<OrderForm> myOrders = null;

        //取得用户名与密码
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("password:"+password);

        //验证登录信息
        DBClient database = new DBClient("leaf", "123456789", "jdbc:mysql://localhost:3306/myshop");
        String sql = "select * from user where username = '" + username + "' and password = '" + password +"'";
        String ccode = request.getParameter("checkname");
        HttpSession session = request.getSession();
        session.setAttribute("myCart",myCart);
        session.setAttribute("myOrders",myOrders);
        session.setAttribute("username",username);
        session.setAttribute("password",password);
        String scode = (String) session.getAttribute("checkcode");
        if (ccode.equals(scode)) {
            try {
                System.out.println("查询中...");

                ResultSet resultSet = database.query(sql, database.getConnection());
                if(resultSet.next()) {
                    //若用户信息正确则将其保存在session中
                    session.setAttribute("goAhead","true");
                    session.setAttribute("UID",resultSet.getString("UID"));
                    //session.setAttribute("birthday", resultSet.getString("birthday"));
                    session.setAttribute("address", resultSet.getString("address")+" ");
                    session.setAttribute("phone",resultSet.getString("phoneNumber"));
                    try {
                        //根据用户的订单号取得用户的订单
                        myOrders = OrderFormDAO.queryAllUserOrders(resultSet.getString("UID"));
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                    response.sendRedirect("index.jsp");
                    System.out.println("用户信息已确认正确！");
                }
                else{
                    session.setAttribute("goAhead","false2");
                    response.sendRedirect("login.jsp");
                }
            } catch (SQLException | ClassNotFoundException throwables) {
                throwables.printStackTrace();
            }
        } else {
            session.setAttribute("goAhead","false1");
            response.sendRedirect("login.jsp");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
