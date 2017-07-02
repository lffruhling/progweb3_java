/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cadPessoa;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Aula
 */
@WebServlet(name = "MostraPessoa", urlPatterns = {"/MostraPessoa"})
public class MostraPessoa extends HttpServlet {

    @EJB
    private PessoaFacade pessoaFacade;

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MostraPessoa</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MostraPessoa at " + request.getContextPath() + "</h1>");
            if (request.getParameter("id") != null) {
                Pessoa p = pessoaFacade.find(request.getParameter("id"));
                out.println("<hr>");
                out.println("Procurando pelo CPF: " + request.getParameter("id") + "<br>");
                if (p != null) {
                    out.println("CPF: " + p.getCpf() + "<br>");
                    out.println("Nome: " + p.getNome() + "<br>");
                    out.println("E-mail: " + p.getEmail() + "<br>");
                } else {
                    out.println("Não encontrado.<br>");
                }
            }
            out.println("<hr>");
            //mostrar todos os registros
            out.println("Quantidade de registros: " + String.valueOf(pessoaFacade.count()) + "<br>");
            Collection<Pessoa> cp = pessoaFacade.findAll();
            for (Pessoa pp : cp) {
                out.println(pp.getCpf() + " - " + pp.getNome() + " - " + pp.getEmail() + "<br>");
            }
            out.println("</body>");
            out.println("</html>");
        }
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
        processRequest(request, response);
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
        return "Short description";
    }// </editor-fold>

}
