<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pilgrim Registry</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('pink.png'); 
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .registry-card {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            width: 95%;
            max-width: 1000px;
            text-align: center;
            border-top: 5px solid #ff69b4;
        }

        h2 {
            color: #ff1493;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        /* Search Bar Styling */
        .search-container {
            margin-bottom: 25px;
            background: #fff0f5;
            padding: 15px;
            border-radius: 10px;
            display: inline-block;
        }

        input[type="text"] {
            padding: 8px;
            border: 1px solid #dda0dd;
            border-radius: 5px;
            outline: none;
        }

        .btn-search {
            background-color: #ff69b4;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-search:hover { background-color: #ff1493; }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background-color: #dda0dd;
            color: #333;
            padding: 12px;
            font-size: 0.9rem;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            font-size: 0.85rem;
            color: #555;
            min-width: 140px;
        }

        tr:hover { background-color: #fffafa; }

        /* Action Links */
        .action-link {
            display: inline-flex; 
            align-items: center;
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: bold;
            margin: 2px; 
            transition: all 0.3s ease;
            line-height: 1; 
        }

        .edit-link { 
            color: #40e0d0; 
            border: 1.5px solid #40e0d0; 
        }
        
        .edit-link:hover { 
            background: #40e0d0; 
            color: white; 
        }

        .delete-link { 
            color: #ff69b4; 
            border: 1.5px solid #ff69b4; 
        }
        
        .delete-link:hover { 
            background: #ff69b4; 
            color: white; 
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #dda0dd;
            color: black;
            text-decoration: none;
            border-radius: 5px;
            font-size: 13px;
            transition: 0.3s ease;
        }
        
        .back-button:hover { background-color: #a679a6; color: white; }
    </style>
</head>
<body>

<div class="registry-card">
    <h2>All Pilgrim Profiles 📚</h2>

    <div class="search-container">
        <form method="get">
            <strong>Search Student ID:</strong> 
            <input type="text" name="sid" placeholder="Enter ID...">
            <button type="submit" class="btn-search">Search</button>
            <a href="viewProfiles.jsp" style="font-size: 12px; color: #888; margin-left: 10px;">Clear</a>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Student ID</th>
                <th>Program</th>
                <th>Email</th>
                <th>Hobbies</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                String sid = request.getParameter("sid");
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/student_profiles", "app", "app");

                String sql = "SELECT * FROM APP.PROFILE";
                if (sid != null && !sid.trim().isEmpty()) {
                    sql += " WHERE studentId = ?";
                }

                PreparedStatement ps = con.prepareStatement(sql);
                if (sid != null && !sid.trim().isEmpty()) {
                    ps.setString(1, sid.trim());
                }

                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
            <tr>
                <td><strong><%= rs.getString("name") %></strong></td>
                <td><%= rs.getString("studentId") %></td>
                <td><%= rs.getString("program") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("hobbies") %></td>
                <td>
                    <a href="editProfile.jsp?sid=<%= rs.getString("studentId") %>" class="action-link edit-link">✏️ Edit</a>
                    <a href="DeleteProfileServlet?sid=<%= rs.getString("studentId") %>" 
                       class="action-link delete-link"
                       onclick="return confirm('Delete this pilgrim?');">🗑️ Delete</a>
                </td>
            </tr>
        <%
                }
                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>

    <a href="index.html" class="back-button">REGISTER NEW PILGRIM</a>
</div>

</body>
</html>