<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Pilgrim</title>
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

        .form-card {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 450px;
            text-align: center;
            border-top: 5px solid #ff69b4;
        }

        h2 {
            color: #ff1493;
            margin-bottom: 25px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        form {
            display: flex;
            flex-direction: column;
            text-align: left;
        }

        label {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
            font-size: 0.9em;
        }

        input {
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #dda0dd;
            border-radius: 8px;
            outline: none;
            transition: 0.3s;
        }

        input:focus {
            border-color: #ff69b4;
            box-shadow: 0 0 8px rgba(255, 105, 180, 0.3);
        }

        /* Styling for the Read-Only field */
        input[readonly] {
            background-color: #f9f9f9;
            color: #888;
            border-style: dashed;
        }

        button {
            background-color: #ff69b4;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-weight: bold;
            font-size: 1em;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        button:hover {
            background-color: #ff1493;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 20, 147, 0.4);
        }

        .back-link {
            display: block;
            margin-top: 20px;
            color: #888;
            text-decoration: none;
            font-size: 0.85em;
        }

        .back-link:hover {
            color: #ff69b4;
        }
    </style>
</head>
<body>
<%
    String sid = request.getParameter("sid");
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/student_profiles", "app", "app");
        // Using UPPERCASE APP.PROFILE to match your Derby table exactly
        PreparedStatement ps = con.prepareStatement("SELECT * FROM APP.PROFILE WHERE studentId = ?");
        ps.setString(1, sid);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
%>
    <div class="form-card">
        <h2>Update Pilgrim Profile 🌸</h2>
        <form action="EditProfileServlet" method="POST">
            <label>Student ID (Locked)</label>
            <input type="text" name="studentId" value="<%= rs.getString("studentId") %>" readonly title="ID cannot be changed">
            
            <label>Full Name</label>
            <input type="text" name="name" value="<%= rs.getString("name") %>" required>
            
            <label>Program</label>
            <input type="text" name="program" value="<%= rs.getString("program") %>" required>
            
            <label>Email</label>
            <input type="email" name="email" value="<%= rs.getString("email") %>" required>
            
            <label>Hobbies</label>
            <input type="text" name="hobbies" value="<%= rs.getString("hobbies") %>" required>

            <button type="submit">SAVE CHANGES</button>
        </form>
        <a href="viewProfiles.jsp" class="back-link">← Cancel and Go Back</a>
    </div>
<% 
        } else {
            out.println("<div class='form-card'><h2>Error</h2><p>Pilgrim not found!</p><a href='viewProfiles.jsp'>Back</a></div>");
        }
        con.close();
    } catch(Exception e) { 
        out.println("<div class='form-card'><h2>System Error</h2><p>" + e.getMessage() + "</p></div>"); 
    } 
%>
</body>
</html>