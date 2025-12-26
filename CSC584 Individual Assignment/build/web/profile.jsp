<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ProfileBean" %>
<%
    ProfileBean p = (ProfileBean) request.getAttribute("profile"); 
%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile Saved</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('pink.png');
            background-size: cover;
            background-attachment: fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .profile-card {
            background-color: rgba(255, 255, 255, 0.85);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 500px;
            text-align: center;
            border-top: 5px solid #ff69b4;
        }
        .profile-avatar img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid #40e0d0;
            margin-bottom: 15px;
        }
        h2 { color: #ff1493; }
        p { color: #555; margin: 10px 0; }
        .label { font-weight: bold; color: #333; }
        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #dda0dd;
            color: black;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }
        .back-button:hover { background-color: #ff69b4; color: white; }
    </style>
</head>
<body>
    <div class="profile-card">
        <h2>HELLO PILGRIM 🌸</h2>
        <div class="profile-avatar">
            <img src="avatars/<%= p.getAvatar() %>" onerror="this.src='https://placehold.co/120x120/40e0d0/000?text=Avatar';">
        </div>
        
        <p><span class="label">👤 Name:</span> <%= p.getName() %></p>
        <p><span class="label">🎓 Student ID:</span> <%= p.getStudentId() %></p>
        <p><span class="label">📚 Program:</span> <%= p.getProgram() %></p>
        <p><span class="label">📧 Email:</span> <%= p.getEmail() %></p>
        <p><span class="label">⭐ Hobbies:</span> <%= p.getHobbies() %></p>
        
        <div style="background: #fff0f5; padding: 10px; border-radius: 8px; margin-top: 15px;">
            <span class="label">💬 Intro:</span>
            <p><%= p.getIntro() %></p>
        </div>

        <a href="viewProfiles.jsp" class="back-button">VIEW ALL PILGRIMS</a>
    </div>
</body>
</html>