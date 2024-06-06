<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="DAO.ProfessorsDAO" %>
<%@ page import="business.Module" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="DAO.ProfessorsDAO, business.Classe, business.Etudiant" %>
<%@page import="DAO.MaConnexion"%>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	String username = ""; 
	 if(session.getAttribute("username")!=null){
		 username = session.getAttribute("username").toString();
	 }else{
		 response.sendRedirect("../Login.jsp");
	 }
	MaConnexion conn = new MaConnexion();

    ProfessorsDAO dao = new ProfessorsDAO(conn);
    int moduleId = Integer.parseInt(request.getParameter("moduleId"));
    List<Etudiant> etudiants = dao.getStudentsByModuleId(moduleId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Affecter Notes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            width: 60%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            padding-bottom: 10px; /* Adjust the padding at the bottom */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #dddddd;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        input[type="text"] {
            width: 100%;
            padding: 5px;
            box-sizing: border-box;
        }
        .button-container {
            text-align: right; /* Align the button to the right */
            margin-top: 20px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2 style="margin-top:100px; margin-bottom:50px; color:#007BFF">Affecter Notes pour le Module <%= moduleId %></h2>
    <form action="${pageContext.request.contextPath}/EnregistrerNotesServlet" method="post">
        <input type="hidden" name="moduleId" value="<%= moduleId %>">
        <table>
            <tr>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Note</th>
            </tr>
            <% for (Etudiant etudiant : etudiants) {
                // Get the existing note for the student if it exists
                float existingNote = dao.getNoteByStudentIdAndModuleId(etudiant.getId(), moduleId);
            %>
            <tr>
                <td><%= etudiant.getNom() %></td>
                <td><%= etudiant.getPrenom() %></td>
                <td><input type="text" name="note_<%= etudiant.getId() %>" value="<%= existingNote %>"></td>
            </tr>
            <% } %>
        </table>
        <div class="button-container">
            <button type="submit">Enregistrer</button>
        </div>
    </form>
    <jsp:include page="profnavbar.jsp" />
</body>
</html>
