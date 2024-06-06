package controller;

import DAO.ProfessorsDAO;
import DAO.MaConnexion;
import business.Professeur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/controller/UpdateProfController")
public class UpdateProfController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String currentUsername = session.getAttribute("username").toString();

        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String newUsername = request.getParameter("username");
        String newPassword = request.getParameter("password");
        String oldPassword = request.getParameter("oldPassword");

        try {
            MaConnexion connexion = new MaConnexion();
            ProfessorsDAO profDAO = new ProfessorsDAO(connexion);

            Professeur prof = profDAO.getProfByUsername(currentUsername);

            // Vérifier l'ancien mot de passe
            if (prof.getPassword().equals(profDAO.hashString(oldPassword))) {
            	prof.setNom(nom);
            	prof.setPrenom(prenom);
            	prof.setUsername(newUsername);
            	prof.setPassword(newPassword);  // Assurez-vous de hacher le nouveau mot de passe avant de le stocker

                profDAO.updateProf(prof);

                session.setAttribute("username", newUsername);
                response.sendRedirect("./prof/dashbordProf.jsp");
            } else {
                response.sendRedirect("./prof/dashbordProf.jsp?message=Mot de passe incorrect");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}