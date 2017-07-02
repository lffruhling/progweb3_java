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
    <h1>Alterar Usuário</h1>
    <div id=formPadrao>
    <%
        if (request.getParameter("botao") != null && request.getParameter("botao").equals("Excluir")) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement("select * from usuario where login = ?");
                pstmt.setString(1, request.getParameter("alterar"));
                ResultSet rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    String nome = rs.getString("login");
                    out.println("<script> if(confirm('Você deseja excluir definitivamente o usuario "
                    + nome + "?')) { location.href = 'alterausuario.jsp?acao=ConfirmaExcluir&login="
                    + request.getParameter("alterar") + "';}else{ "
                    + "alert('Registro não excluido!'); "
                    + "location.href = 'listausuario.jsp'; "
                    + "} </script>");
                }
            } catch (SQLException err) {
            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
            }
        }
        
        if (request.getParameter("acao") != null && request.getParameter("acao").equals("ConfirmaExcluir")) {
            try {
                out.println("<script>alert(\" registro: " + request.getParameter("login") + "\");</script>");
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement(" delete from usuario where login = ?");
                pstmt.setString(1, request.getParameter("login"));
                pstmt.executeUpdate();
                
                response.sendRedirect("listausuario.jsp");
            } catch (SQLException err) {
                out.println("<script>alert(\"Erro. Não é possível excluir esse registro: " + err.getMessage() + "\");</script>");
            }
        }
        
        if (request.getParameter("botao") != null && request.getParameter("botao").equals("Salvar")) {
            if(request.getParameter("senha").trim().equals("")){
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                    PreparedStatement pstmt = con.prepareStatement("update usuario set nivel=?, pessoa_id=? where login = ? ");
                    pstmt.setString(1, request.getParameter("nivel"));
                    pstmt.setString(2, request.getParameter("pessoa_id"));
                    pstmt.setString(3, request.getParameter("alterar"));
                    pstmt.executeUpdate();
                    response.sendRedirect("listausuario.jsp");
                } catch (SQLException err) {
                    out.println("<script>alert(\"Ocorreu um Erro na Alteração: " + err.getMessage() + "\");</script>");
                }
            }else{
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                    PreparedStatement pstmt = con.prepareStatement("update usuario set senha= sha1(?), nivel=?, pessoa_id=? where login = ? ");
                    pstmt.setString(1, request.getParameter("senha"));
                    pstmt.setString(2, request.getParameter("nivel"));
                    pstmt.setString(3, request.getParameter("pessoa_id"));
                    pstmt.setString(4, request.getParameter("alterar"));
                    pstmt.executeUpdate();
                    response.sendRedirect("listausuario.jsp");
                } catch (SQLException err) {
                    out.println("<script>alert(\"Ocorreu um Erro na Alteração: " + err.getMessage() + "\");</script>");
                }
            }
        }
        
        String senha = "";
        String nivel = "";
        String pessoa_id = "";
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            PreparedStatement pstmt = con.prepareStatement("select * from usuario where login = ?");
            pstmt.setString(1, request.getParameter("alterar"));
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                senha = rs.getString("senha");
                nivel = rs.getString("nivel");
                pessoa_id = rs.getString("pessoa_id");
            }
        } catch (SQLException err) {
            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
        }
    %>
    <div id=formPadrao>
        <form name="fCadUsuario" id="fCadUsuario" method="post" action="alterausuario.jsp">
            <fieldset >
                <legend>Alteração dos dados do Usuário:</legend>
                
                <label for="senha">Senha:</label><br />
                <input type="text" name="senha" id="senha" size="50" maxlength="50" value=""/><br />
                
                <label for="nivel">Nível:</label><br />
                <select name="nivel" id="nivel">
                    <option value="1">Administrador</option>
                    <option value="2">Usuário</option>
                </select><br />
                
                <label for="pessoa">Pessoa:</label><br />
                <select name="pessoa_id" id="pessoa_id">
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                        PreparedStatement pstmt = con.prepareStatement("select * from pessoa order by nome");
                        ResultSet rs = pstmt.executeQuery();
                        while (rs.next())
                        {
                            out.println( "<option value="+rs.getString("id")+">"+rs.getString("nome")+"</option>"); //mostra o identificador
                        }

                    %>
                </select><br />
                
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
    <a href="cadusuario.jsp">Cadastrar Pessoas</a><br />
    <a href="listausuario.jsp">Listar Pessoas</a>
</body>
</html>