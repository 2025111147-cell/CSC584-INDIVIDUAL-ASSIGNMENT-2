import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/student_profiles", "app", "app");

            String sql =
                "UPDATE APP.PROFILE SET name=?, program=?, email=?, hobbies=?, intro=? " +
                "WHERE studentId=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("program"));
            ps.setString(3, request.getParameter("email"));
            ps.setString(4, request.getParameter("hobbies"));
            ps.setString(5, request.getParameter("intro"));
            ps.setString(6, request.getParameter("studentId"));

            ps.executeUpdate();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("viewProfiles.jsp");
    }
}
