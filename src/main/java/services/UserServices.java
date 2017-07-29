package services;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import db.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gurusharan S.
 */
public class UserServices extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String action = request.getParameter("action");
            if (action == null) {
                throw new ServletException("Action not specified");
            }
            if (action.equals("authenticate")) {
                out.print(doAuthentication(request.getParameter("email"), request.getParameter("password")));
            }
            if (action.equals("reauthenticate")) {
                out.print(doAuthentication(request.getParameter("token")));
            }
            if (action.equals("register")) {
                out.print(doRegistration(request.getParameter("email"), request.getParameter("password")));
            }
            else {
                throw new ServletException("Unknown action: " + action);
            }
        } finally {
            out.close();
        }
    }
    
    private String doRegistration(String email, String password) {
        User user = new User(email, password);
        if (user.addUserToDB()) {
            user.updateToken();
            return user.getToken();
        }
        
        return "FAIL";
    }
    
    private String doAuthentication(String token) {
        User user = new User(token);
        if (user.authenticateUser()) {
            return user.getToken();
        }
        return "FAIL";
    }
    
    private String doAuthentication(String email, String password) {
        User user = new User(email, password);
        if(user.authenticateUser()) {
            user.updateToken();
            return user.getToken();
        }
        return "FAIL";
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        throw new ServletException(this.getClass().getSimpleName() + " does not support 'GET' request");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "User service servlet";
    }// </editor-fold>

}
