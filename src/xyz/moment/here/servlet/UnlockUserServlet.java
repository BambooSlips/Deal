package xyz.moment.here.servlet;

import xyz.moment.here.service.UserLocker;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UnlockUserServlet", urlPatterns = "/UnlockUserServlet")
public class UnlockUserServlet extends HttpServlet {
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
                userLocker.unlock(UID);
            } catch (SQLException | ClassNotFoundException throwables) {
                throwables.printStackTrace();
            }
            finally {
                System.out.println("User "+UID+" has been unlocked!");
            }
        }
        resp.sendRedirect("ManageUsers.jsp");
    }
}
