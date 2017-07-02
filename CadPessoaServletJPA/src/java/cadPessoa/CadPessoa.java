/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cadPessoa;

import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "CadPessoa", urlPatterns = {"/CadPessoa"})
public class CadPessoa extends HttpServlet {
    
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
            out.println("<title>Cadastro de Pessoa</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Cadastro de Pessoas</h1>");
                if (request.getParameter("cpf") != null) {
                    Pessoa p = new Pessoa();
                    p.setCpf(request.getParameter("cpf"));
                    p.setNome(request.getParameter("nome"));
                    p.setEmail(request.getParameter("email"));
                    
                    try {
                        pessoaFacade.create(p);
                        out.println("Cadastro com sucesso.");
                    } catch (Exception e) {
                        out.println("Erro no Cadastro.");
                    }
                }
            out.println("<hr>");
            out.println("<form name=\"cadastro\" action=\"CadPessoa\" method=\"POST\">");
            out.println("CPF: <input type=\"text\" name=\"cpf\" value=\"\" size=\"15\" /><br>");
            out.println("Nome: <input type=\"text\" name=\"nome\" value=\"\" size=\"50\"/><br>");
            out.println("E-Mail: <input type=\"text\" name=\"email\" value=\"\" size=\"50\"/><br>");
            out.println("<input type=\"submit\" value=\"Cadastrar\" name=\"cadastrar\" /><br>");
            out.println("</form>");
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
