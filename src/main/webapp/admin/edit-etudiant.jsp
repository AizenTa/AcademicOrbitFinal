<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="DAO.AdminDAO, business.Etudiant" %>
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
     
    int id = Integer.parseInt(request.getParameter("id"));
    Etudiant etudiant = null;

    MaConnexion conn = new MaConnexion();
    List<Etudiant> etudiants = new ArrayList<>();
    AdminDAO dao = new AdminDAO(conn);
    etudiants = dao.getAllEtudiantInfos();
    
    for (Etudiant E : dao.getAllEtudiantInfos()) {
        if (E.getId() == id) {
            etudiant = E;    
            break;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier Etudiant</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap');

        body {
            font-family: 'Roboto', sans-serif;
            background: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: #2c3e50;
        }

        h1 {
            text-align: center;
            color: #34495e;
            font-size: 2.5rem;
            margin-bottom: 30px;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-container {
            width: 100%;
            max-width: 600px;
            background: #ffffff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 0.7s ease-in-out;
            margin-top: 20px;
        }

        label {
            display: block;
            margin: 15px 0 5px;
            font-weight: 500;
            color: #34495e;
        }

        input[type="text"], input[type="password"], input[type="number"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            background: #ecf0f1;
            color: #2c3e50;
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus, input[type="password"]:focus, input[type="number"]:focus {
            border-color: #2980b9;
            box-shadow: 0 0 8px rgba(41, 128, 185, 0.3);
            outline: none;
        }

        .radio-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .radio-group label {
            font-weight: 500;
            color: #34495e;
        }

        .radio-group input {
            margin-right: 10px;
        }

        button {
            display: block;
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #2c3e50, #273746);
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background 0.3s ease-in-out, transform 0.2s;
        }

        button:hover {
            background: linear-gradient(135deg, #273746, #212f3c);
            transform: translateY(-2px);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

    </style>
</head>
<body>
    <div class="form-container">
        <h1>Modifier Etudiant</h1>
        <form action="${pageContext.request.contextPath}/ModifierEtudiant" method="post">
            <input type="hidden" name="id" value="<%= etudiant.getId() %>">
            <label>CNE d'Etudiant :</label>
            <input type="text" name="username" required>
            <label>Password:</label>
            <input type="password" name="password" required>
            <label>Name:</label>
            <input type="text" name="name" value="<%= etudiant.getNom() %>" required>
            <label>Last Name:</label>
            <input type="text" name="lastName" value="<%= etudiant.getPrenom() %>" required>
            <label>Address:</label>
            <input type="text" name="address" value="<%= etudiant.getAddress() %>" required>
            
            <div class="radio-group">
                <label for="sex">
                    <input type="radio" id="male" name="sex" value="Homme" <%= "Homme".equals(etudiant.getSex()) ? "checked" : "" %>> Homme
                    <input type="radio" id="female" name="sex" value="Femme" <%= "Femme".equals(etudiant.getSex()) ? "checked" : "" %>> Femme
                </label>
            </div>

            <label>Age:</label>
            <input type="number" name="age" value="<%= etudiant.getAge() %>" required>
            <label>Abscence Etudiant:</label>
            <input type="text" name="abscenceHours" value="<%= etudiant.getAbscence_hours() %>" required>
            <button type="submit">Update</button>
        </form>
    </div>
    <jsp:include page="adminnavbar.jsp" />
</body>
</html>
