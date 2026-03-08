package Login;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;

@WebServlet("/AddExpenseServlet")
public class AddExpenseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String date = request.getParameter("expenseDate");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO expenses(category,amount,expense_date,user_email) VALUES(?,?,?,?)"
            );

            ps.setString(1, category);
            ps.setDouble(2, amount);
            ps.setString(3, date);
            ps.setString(4, email);

            ps.executeUpdate();

            response.sendRedirect("viewExpense.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h2>ERROR OCCURRED</h2>");
            response.getWriter().println(e.getMessage());
        }
    }
}