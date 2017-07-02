<%-- 
    Document   : cadpessoa
    Created on : 20/02/2017, 21:09:21
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
    <title>Cadastro de Usuários</title>
</head>
<body>
    <h1>Cadastro de Usuários</h1>
    <div id=formPadrao> <!-- mostra um formulário para cadastrar pessoas -->
    <%
        if (request.getParameter("botao")!=null && request.getParameter("botao").equals("Cadastrar")) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement(" INSERT INTO usuario (login, senha, nivel, pessoa_id) VALUES( ?, sha1(?), ?, ?)");
                pstmt.setString(1, request.getParameter("login"));
                pstmt.setString(2, request.getParameter("senha"));
                pstmt.setString(3, request.getParameter("nivel"));
                pstmt.setString(4, request.getParameter("pessoa_id"));
                pstmt.executeUpdate();
                out.println("<script>alert('Usuário Cadastrado!');</script>");
            } catch (SQLException err) {
                out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
            }
        }
    %>
        <form name="fCadUsuario" id="fCadUsuario" method="post" action="cadusuario.jsp">
            <fieldset >
                <legend>Informe os dados do Usuário:</legend>
                
                <label for="login">Login:</label><br />
                <input type="text" name="login" id="login" size="50" maxlength="50" required/><br />
                
                <label for="senha">Senha:</label><br />
                <input type="text" name="senha" id="senha" size="50" maxlength="11" required/><br />
                
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
                <input type="submit" name="botao" id="botao" value="Cadastrar" />
            </fieldset>
        </form>
    </div>
    <br />
    <a href="listausuario.jsp">Listar Usuários</a>
</body>
</html>