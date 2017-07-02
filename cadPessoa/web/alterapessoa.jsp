<%-- 
    Document   : alterapessoa
    Created on : 20/02/2017, 21:19:17
    Author     : Aula
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro de Pessoa</title>
</head>
<body>
    <h1>Cadastro de Pessoa</h1>
    <div id=formPadrao>
    <%
        if (request.getParameter("botao") != null && request.getParameter("botao").equals("Excluir")) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement("select * from pessoa where id = ?");
                pstmt.setString(1, request.getParameter("alterar"));
                ResultSet rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    String nome = rs.getString("nome");
                    out.println("<script> if(confirm('Você deseja excluir definitivamente a pessoa "
                    + nome + "?')) { location.href = 'alterapessoa.jsp?acao=ConfirmaExcluir&id="
                    + request.getParameter("alterar") + "';}else{ "
                    + "alert('Registro não excluido!'); "
                    + "location.href = 'listapessoa.jsp'; "
                    + "} </script>");
                }
            } catch (SQLException err) {
            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
            }
        }
        
        if (request.getParameter("acao") != null && request.getParameter("acao").equals("ConfirmaExcluir")) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement(" delete from pessoa where id = ?");
                pstmt.setString(1, request.getParameter("id"));
                pstmt.executeUpdate();
                response.sendRedirect("listapessoa.jsp");
            } catch (SQLException err) {
                out.println("<script>alert(\"Erro. Não é possível excluir esse registro: " + err.getMessage() + "\");</script>");
            }
        }
        
        if (request.getParameter("botao") != null && request.getParameter("botao").equals("Salvar")) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement("update pessoa set nome=?, cpf=?, email=?, fone=? where id = ? ");
                pstmt.setString(1, request.getParameter("nome"));
                pstmt.setString(2, request.getParameter("cpf"));
                pstmt.setString(3, request.getParameter("email"));
                pstmt.setString(4, request.getParameter("fone"));
                pstmt.setString(5, request.getParameter("alterar"));
                pstmt.executeUpdate();
                response.sendRedirect("listapessoa.jsp");
            } catch (SQLException err) {
                out.println("<script>alert(\"Ocorreu um Erro na Alteração: " + err.getMessage() + "\");</script>");
            }
        }
        
        String nome = "";
        String cpf = "";
        String email = "";
        String fone = "";
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            PreparedStatement pstmt = con.prepareStatement("select * from pessoa where id = ?");
            pstmt.setString(1, request.getParameter("alterar"));
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                nome = rs.getString("nome");
                cpf = rs.getString("cpf");
                email = rs.getString("email");
                fone = rs.getString("fone");
            }
        } catch (SQLException err) {
            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
        }
    %>
    <div id=formPadrao>
        <form name="fCadPessoa" id="fCadPessoa" method="post" action="alterapessoa.jsp">
            <fieldset >
                <legend>Alteração dos dados da Pessoa:</legend>
                
                <label for="nome">Nome:</label><br />
                <input type="text" name="nome" id="nome" size="50" maxlength="50" value="<%out.println(nome);%>" required/><br />
                
                <label for="cpf">CPF:</label><br />
                <input type="text" name="cpf" id="cpf" size="50" maxlength="11" value="<%out.println(cpf);%>" required/><br />
                
                <label for="email">E-Mail:</label><br />
                <input type="email" name="email" id="email" size="50" maxlength="100" value="<%out.println(email);%>" required/><br />
                
                <label for="fone">Fone:</label><br />
                <input type="text" name="fone" id="fone" size="50" maxlength="30" value="<%out.println(fone);%>" ><br />
                
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
    <br />
    <a href="cadpessoa.jsp">Cadastrar Pessoas</a><br />
    <a href="listapessoa.jsp">Listar Pessoas</a>
</body>
</html>