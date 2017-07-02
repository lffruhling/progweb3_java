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

            <h1>Cadastro de Produto</h1>
            <div id=formPadrao> <!— mostra um formulário para cadastrar produto -->

                <%
                    if (request.getParameter("botao") != null && request.getParameter("botao").equals("Cadastrar")) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                            PreparedStatement pstmt = con.prepareStatement(" INSERT INTO produto (nome, estoque, preco, codigobarras) VALUES( ?, ?, ?, ?)");
                            pstmt.setString(1, request.getParameter("nome"));
                            pstmt.setDouble(2, Double.parseDouble(request.getParameter("estoque")));
                            pstmt.setFloat(3, Float.parseFloat(request.getParameter("preco")));
                            pstmt.setString(4, (request.getParameter("barcode")));
                            pstmt.executeUpdate();
                            out.println("<script>alert('Produto Cadastrado!');</script>");
                        } catch (SQLException err) {
                            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                        }
                    }
                %>
                <form name="fCadProduto" id="fCadProduto" method="post" action="cadproduto.jsp">
                    <fieldset >
                        <legend>Informe os dados do Produto:</legend>
                        <label for="nome">Nome do Produto:</label><br />
                        <input type="text" name="nome" id="nome" size="50" maxlength="50" required/><br />
                        <label for="barcode">Código de Barras</label><br />
                        <input type="number" name="barcode" id="estoque" size="50"/><br />
                        <label for="Estoque">Qtd. Estoque:</label><br />
                        <input type="number" name="estoque" id="estoque" size="50" maxlength="11" required step="0.01"/><br />
                        <label for="preco">Preço:</label><br />
                        <input type="number" name="preco" id="preco" size="50" maxlength="100" required step="0.01"/><br />
                        <br />
                        <input type="submit" name="botao" id="botao" value="Cadastrar" />
                    </fieldset>
                </form>
            </div>    

    </div>
</div>
<br />
<jsp:include page="rodape.jsp"/>
