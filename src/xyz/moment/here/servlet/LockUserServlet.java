package xyz.moment.here.servlet;

import xyz.moment.here.service.UserLocker;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LockUserServlet", urlPatterns = "/LockUserServlet")
public class LockUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserLocker userLocker = new UserLocker();
        String chosen = req.getParameter("chosenUIDs");
        System.out.println(chosen);
        String[] chosenUIDs = {};
        String knife = ",";
        chosenUIDs = chosen.split(knife);
        for(String UID : chosenUIDs) {
            try {
                userLocker.lock(UID);
            } catch (SQLException | ClassNotFoundException throwables) {
                throwables.printStackTrace();
            }
            finally {
                System.out.println("User "+UID+" has been locked away!");
            }
        }
        resp.sendRedirect("ManageUsers.jsp");
    }
}
