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
        <h1>Cadastro de Pessoas</h1>
        <div id=formPadrao>
            <form name="fAlterarPessoa" id="fAlterarPessoa" method="post" action="alterapessoa.jsp">
                <fieldset >
                    <legend>Pessoas Cadastradas:</legend>
                    <table border=0><tr><th>Id</th><th>Nome</th><th></th></tr>
                                <%
                                    try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                                            PreparedStatement pstmt = con.prepareStatement("select * from pessoa order by nome");
                                            ResultSet rs = pstmt.executeQuery();
                                            while (rs.next())
                                                    {                                                        
                                                    out.println( "<tr><td>"+rs.getString("id")+"</td>"); //mostra o identificador
                                                    out.println( "<td>"+rs.getString("nome")+"</td>"); //mostra o nome da pessoa
                                                    out.println( "<td><button type=\"submit\" name=\"alterar\" id=\"alterar\" value=\""+rs.getString("id")+"\">Alterar</button></td></tr>");
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
        </article>
    </div>
</div>
<br />
<jsp:include page="rodape.jsp"/>
