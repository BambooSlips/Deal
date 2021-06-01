package xyz.moment.here.servlet;


import xyz.moment.here.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", urlPatterns = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String ccode = request.getParameter("key");
        HttpSession session = request.getSession();
        String scode = (String) session.getAttribute("checkcode");
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!"+ccode+":::"+scode);
        if (ccode.equals(scode)) {
                String addUser = "insert into user(UID,username, password, phoneNumber) values(UPPER(REPLACE(UUID(), '-', '')),'"+username+"','"+password+"','"+phone+"')";
                System.out.println(addUser);
                //utils.MySQL database = new
                String message = "注册成功！";
                if(username != null && !"".equals(username) && password != null && !"".equals(password))
                {
                    try {
                        UserDAO.userRegister(addUser);
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                }
                else {
                    message = "请检测填写！";
                }
                //显示提示
                response.setContentType("text/html;charset=UTF-8");// 设置生成的文档类型
                PrintWriter out = response.getWriter();// 得到输出字符输出流

                //out.println("<h1>哈哈哈</h1>");
                out.println("<script>" +
                        "var c = confirm('"+message+"');" +
                        "if(c==true){" +
                        "   window.location.href=\"login.jsp\";" +
                        "}" +
                        "else{" +
                        "window.location.href=\"login.jsp\";" +
                        "}" +
                        "</script>");


        } else {
            session.setAttribute("goAhead","false1");
            response.sendRedirect("register.jsp");
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
