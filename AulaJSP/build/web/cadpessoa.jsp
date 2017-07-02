<%-- 
    Document   : cadpessoa
    Created on : 20/02/2017, 11:21:15
    Author     : Evandro
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%
    String login = "";
    try {
        login = session.getAttribute("login").toString();
    } catch (Exception e) {//caso a sessão não tenha sido inicializada
        response.sendRedirect("login.jsp");
        return;
    }
    if (login.trim().length() == 0) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="cabecalho.jsp"/>
<div id="site_content">            
    <div class="content">

            <h1>Cadastro de Pessoa</h1>
            <div id=formPadrao> <!— mostra um formulário para cadastrar pessoas -->

                <%
                    if (request.getParameter("botao") != null && request.getParameter("botao").equals("Cadastrar")) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                            PreparedStatement pstmt = con.prepareStatement(" INSERT INTO pessoa (nome, cpf, email, fone) VALUES( ?, ?, ?, ?)");
                            pstmt.setString(1, request.getParameter("nome"));
                            pstmt.setString(2, request.getParameter("cpf"));
                            pstmt.setString(3, request.getParameter("email"));
                            pstmt.setString(4, request.getParameter("fone"));
                            pstmt.executeUpdate();
                            out.println("<script>alert('Pessoa Cadastrada!');</script>");
                        } catch (SQLException err) {
                            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                        }
                    }
                %>
                <form name="fCadPessoa" id="fCadPessoa" method="post" action="cadpessoa.jsp">
                    <fieldset >
                        <legend>Informe os dados da Pessoa:</legend>
                        <label for="nome">Nome:</label><br />
                        <input type="text" name="nome" id="nome" size="50" maxlength="50" required/><br />
                        <label for="cpf">CPF:</label><br />
                        <input type="text" name="cpf" id="cpf" size="50" maxlength="11" required/><br />
                        <label for="email">E-Mail:</label><br />
                        <input type="email" name="email" id="email" size="50" maxlength="100" required/><br />
                        <label for="fone">Fone:</label><br />
                        <input type="text" name="fone" id="fone" size="50" maxlength="30" ><br />
                        <br />
                        <input type="submit" name="botao" id="botao" value="Cadastrar" />
                    </fieldset>
                </form>
            </div>    

    </div>
</div>
<br />
<jsp:include page="rodape.jsp"/>
