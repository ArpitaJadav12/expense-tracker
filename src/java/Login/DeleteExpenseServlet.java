package Login;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


@WebServlet("/DeleteExpenseServlet")
public class DeleteExpenseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id =
              Integer.parseInt(request.getParameter("id"));

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(
                "DELETE FROM expenses WHERE id=?");

            ps.setInt(1, id);

            ps.executeUpdate();

            ps.close();
            con.close();

            // ⭐ GO BACK TO SAME PAGE
            response.sendRedirect("viewExpense.jsp");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}