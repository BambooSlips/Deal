package xyz.moment.here.servlet;

import xyz.moment.here.po.Commodity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ClearCartServlet",urlPatterns = "/ClearCartServlet")
public class ClearCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Commodity> myCart = new ArrayList<Commodity>();
        HttpSession session = request.getSession();
        session.setAttribute("myCart",myCart);
        response.sendRedirect("cart.jsp");
    }
}
