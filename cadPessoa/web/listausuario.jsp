<%-- 
    Document   : alterapessoa
    Created on : 20/02/2017, 21:13:56
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
    <h1>Lista de Usuários</h1>
    <div id=formPadrao>
        <form name="fAlterarUsuario" id="fAlterarUsuario" method="post" action="alterausuario.jsp">
            <fieldset >
                <legend>Usuários Cadastrados:</legend>
                <table border=0><tr><th>Login</th><th>Pessoa</th><th></th></tr>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                            PreparedStatement pstmt = con.prepareStatement("SELECT p.nome, u.login FROM iffar.usuario u left join pessoa p on p.id = u.pessoa_id order by p.nome;");
                            ResultSet rs = pstmt.executeQuery();
                            while (rs.next())
                            {
                                out.println( "<tr><td>"+rs.getString("login")+"</td>"); //mostra o identificador
                                out.println( "<td>"+rs.getString("nome")+"</td>"); //mostra o nome da pessoa
                                out.println( "<td><button type=\"submit\" name=\"alterar\" id=\"alterar\" value=\""+rs.getString("login")+"\">Alterar</button></td></tr>");
                            }
                        } catch (SQLException err) {
                            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                        }
                    %>
                </table>
            </fieldset>
        </form>
    </div>
    <br />
    <a href="cadusuario.jsp">Cadastrar Usuário</a>
</body>
</html>