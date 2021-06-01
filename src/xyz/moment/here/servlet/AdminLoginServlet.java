package xyz.moment.here.servlet;

import xyz.moment.here.dao.AdminDAO;
import xyz.moment.here.util.DBClient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

@WebServlet(name = "AdminLoginServlet", urlPatterns = "/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        //取得用户名与密码
        String adminname = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("password:"+password);

        //验证登录信息
        DBClient database = new DBClient("leaf", "123456789", "jdbc:mysql://localhost:3306/myshop");
        String sql = "select * from admin where adminname = '" + adminname + "' and password = '" + password +"'";
        String ccode = request.getParameter("checkname");
        HttpSession session = request.getSession();

        session.setAttribute("adminname",adminname);
        session.setAttribute("key",password);
        String scode = (String) session.getAttribute("checkcode");
        if (ccode.equals(scode)) {
            try {
                System.out.println("查询中...");

                ResultSet resultSet = database.query(sql, database.getConnection());
                if(resultSet.next()) {
                    //若用户信息正确则将其保存在session中
                    session.setAttribute("goAhead","true");
                    session.setAttribute("AID",resultSet.getString("AID"));

                    Date date = new Date(resultSet.getTimestamp("lastLogin").getTime());
                    session.setAttribute("lastLogin",date);
                    System.out.println("上次登录时间："+date);
                    AdminDAO.updateLoginTime();

                    response.sendRedirect("adminHome.jsp");
                    System.out.println("用户信息已确认正确！");
                }
                else{
                    session.setAttribute("goAhead","false2");
                    response.sendRedirect("adminlogin.jsp");
                }
            } catch (SQLException | ClassNotFoundException throwables) {
                throwables.printStackTrace();
            }
        } else {
            session.setAttribute("goAhead","false1");
            response.sendRedirect("adminlogin.jsp");
        }

    }
}
