package controller;

import DAO.StudentDAO;
import DAO.MaConnexion;
import business.Etudiant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/controller/UpdateEtudiantController")
public class UpdateEtudiantController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String currentUsername = session.getAttribute("username").toString();
        String newUsername = request.getParameter("username");
        String newPassword = request.getParameter("password");
        String oldPassword = request.getParameter("oldPassword");

        try {
            MaConnexion connexion = new MaConnexion();
            StudentDAO etudiantDAO = new StudentDAO(connexion);

            Etudiant etudiant = etudiantDAO.getEtudiantByUsername(currentUsername);

            
            if (etudiant.getPassword().equals(etudiantDAO.hashString(oldPassword))) {
            	etudiant.setUsername(newUsername);
            	etudiant.setPassword(newPassword);  

                etudiantDAO.updateEtudiant(etudiant);

                session.setAttribute("username", newUsername);
                response.sendRedirect("./etudiant/dashbord.jsp");
            } else {
                response.sendRedirect("./etudiant/dashbord.jsp?message=Mot de passe incorrect");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}