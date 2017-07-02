<%-- 
    Document   : cadpessoa
    Created on : 20/02/2017, 11:21:15
    Author     : Evandro
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<jsp:include page="cabecalho.jsp"/>
<div id="site_content">            
    <div class="content">
        <article>
        <h1>Cadastro de Pessoa</h1>
        <div id=formPadrao> 

            <%
                if (request.getParameter("botao") != null && request.getParameter("botao").equals("Excluir")) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                        PreparedStatement pstmt = con.prepareStatement("select * from produto where idproduto = ?");
                        pstmt.setString(1, request.getParameter("alterar"));
                        ResultSet rs = pstmt.executeQuery();
                        if (rs.next()) {
                            String nome = rs.getString("nome");
                            out.println("<script> if(confirm('Você deseja excluir definitivamente o produto "
                                    + nome + "?')) { location.href = 'alteraproduto.jsp?acao=ConfirmaExcluir&idproduto="
                                    + request.getParameter("alterar") + "';}else{        "
                                    + "alert('Registro não excluido!');        "
                                    + "location.href = 'listaproduto.jsp';        "
                                    + "}    </script>");
                        }

                    } catch (SQLException err) {
                        out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                    }
                }
                if (request.getParameter("acao") != null && request.getParameter("acao").equals("ConfirmaExcluir")) {
                     try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                        PreparedStatement pstmt = con.prepareStatement(" delete from produto where idproduto = ?");
                        pstmt.setString(1, request.getParameter("idproduto"));                                             
                        pstmt.executeUpdate();
                        response.sendRedirect("listaproduto.jsp");
                    } catch (SQLException err) {
                        out.println("<script>alert(\"Erro. Não é possível excluir esse registro: " + err.getMessage() + "\");</script>");
                    }
                }
                
                if (request.getParameter("botao") != null && request.getParameter("botao").equals("Salvar")) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                        PreparedStatement pstmt = con.prepareStatement("update produto set nome=?, estoque=?, preco=? where idproduto = ? ");
                        pstmt.setString(1, request.getParameter("nome"));
                        pstmt.setDouble(2, Double.parseDouble(request.getParameter("estoque")));
                        pstmt.setFloat(3, Float.parseFloat(request.getParameter("preco")));
                        pstmt.setString(4, request.getParameter("alterar"));
                        pstmt.executeUpdate();
                        response.sendRedirect("listaproduto.jsp");
                    } catch (SQLException err) {
                        out.println("<script>alert(\"Ocorreu um Erro na Alteração: " + err.getMessage() + "\");</script>");
                    }
                }
                String nome = "";
                double estoque = 0;
                float preco = 0;
                
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                    PreparedStatement pstmt = con.prepareStatement("select * from produto where idproduto = ?");
                    pstmt.setString(1, request.getParameter("alterar"));
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {
                        nome = rs.getString("nome");
                        estoque = rs.getDouble("estoque");
                        preco = rs.getFloat("preco");
                    }
                } catch (SQLException err) {
                    out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                }
            %>
            <div id=formPadrao> 
                <form name="fCadProduto" id="fCadProduto" method="post" action="alteraproduto.jsp">
                    <fieldset >
                        <legend>Alteração dos dados do Produto</legend>
                        <label for="nome">Nome:</label><br />
                        <input type="text" name="nome" id="nome" size="50" maxlength="50" value="<%out.println(nome);%>" required/><br />
                        <label for="estoque">Qtd. Estoque:</label><br />
                        <input type="text" name="estoque" id="estoque" size="50" maxlength="11" required step="any" value="<%out.println(estoque);%>"/><br />
                        <label for="preco">Preço:</label><br />
                        <input type="text" name="preco" id="preco" size="50" maxlength="100"  required step="any" value="<%out.println(preco);%>"/><br />
                        <br />
                        <input type="submit" name="botao" id="botao" value="Salvar" />
                        <input type="submit" name="botao" id="botao" value="Excluir" />
                        <%
                            if (request.getParameter("alterar") != null) {
                                out.println("<INPUT TYPE=\"hidden\" NAME=\"alterar\" VALUE=\"" + request.getParameter("alterar") + "\">");
                            }
                        %>                        			
                    </fieldset>
                </form>        
            </div>	    
    </article>
    </div>
</div>
<br />
<jsp:include page="rodape.jsp"/>
