<%-- 
    Document   : popuppessoa
    Created on : 28/04/2017, 21:48:55
    Author     : Evandro
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
    <head> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

        <script type="text/javascript"> //função javascript que retornará o codigo 
            function retorna(id, nome, preco)//passando um parametro 
            {
                window.opener.document.fVenda.codbarras.value = id;
                //a janela mãe recebe o id, você precisa passar o nome do formulario e do textfield que receberá o valor passado por parametro. 
                window.opener.document.fVenda.nomeproduto.value = nome; 
                window.opener.document.fVenda.precounit.value = preco;
                window.close();	//fecha a janela popup 
            }
        </script> 
    </head> 
    <body> 
        <%
            Connection con = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            } catch (Exception e) {
                out.println("<script>alert(\"Erro conectando com o banco de dados.\");</script>");
            }
        %>
        <form name="fConsultaProduto" id="fConsultaProduto" method="GET" action="popupproduto_venda.php">
            <label for="busca">Busca:</label><br />
            <input type="text" name="busca" id="busca" size="40" maxlength="40">
            <input type="submit" name="botao" id="botao" value="Buscar" />
            <br /><br />
            <%
                try {
                    String busca = "";
                    String sqlconsulta;
                    if (request.getParameter("botao") != null && request.getParameter("botao").equals("Buscar")) {
                        busca = request.getParameter("busca").trim();
                        sqlconsulta = "SELECT * FROM  produto WHERE nome LIKE \"%" + busca + "%\" OR codbarras LIKE \"%" + busca + "%\" order by nome ";
                    } else {
                        sqlconsulta = "SELECT * from produto order by nome ";
                    }
                    PreparedStatement pstmt = con.prepareStatement(sqlconsulta);
                    ResultSet rs = pstmt.executeQuery();
                    int total = rs.last() ? rs.getRow() : 0; //conta o total de itens              
                    int numPaginas = 0;
                    int pagina = 0;
                    int registros = 8;//seta a quantidade para 8 itens por página
                    if (total > 1) {
                        pagina = (request.getParameter("pagina") != null) ? Integer.parseInt(request.getParameter("pagina")) : 1; //verifica a página atual caso seja informada na URL, senão atribui como 1ª página
                        numPaginas = (int) Math.ceil((double)total / registros);
                        if (pagina < 1) {
                            pagina = 1;
                        }
                        if (pagina > numPaginas) {
                            pagina = numPaginas;
                        }
                        int inicio = (registros * pagina) - registros;

                        sqlconsulta = sqlconsulta + " limit " + inicio + ", " + registros;
                        pstmt = con.prepareStatement(sqlconsulta);
                        rs = pstmt.executeQuery();
                    }
                    int cont = 0;
                    out.println("<table>");
                    while (rs.next()) {
                        String nome = rs.getString("nome").replace("'", " ");
                        out.println("<tr><td><a href=\"javascript:retorna('" + rs.getString("codigobarras") + "', '" + nome + "', '"+rs.getString("preco")+"' )\">" + rs.getString("codigobarras") + "</a></td>");
                        out.println("<td><a href=\"javascript:retorna('" + rs.getString("codigobarras") + "', '" + nome + "', '"+rs.getString("preco")+"' )\">" + rs.getString("nome") + "</a></td>");
                        out.println("<td> "+rs.getString("preco") + "</td></tr>");
                        cont++;
                    }
                    for (int i = cont; i <= registros; i++) {
                        out.println("<tr><td>&nbsp</td><td></td></tr>");
                    }
                    out.println("</table>");
                    if (numPaginas > 1) { //exibe a paginação
                        out.println("<center>");
                        if (pagina > 1) {
                            int anterior = pagina - 1;
                            out.println("<a href='popupproduto_venda.jsp?busca=$busca&pagina=" + anterior + "'> << Anterior</a> ");
                        }
                        for (int i = 1; i < numPaginas + 1; i++) {
                            if (i == pagina) {
                                out.println(" <b>" + i + "</b> ");
                            } else {
                                out.println("<a href='popupproduto_venda.jsp?busca=" + busca + "&pagina=" + i + "'>" + i + "</a> ");
                            }
                        }
                        if (pagina < numPaginas) {
                            int proxima = pagina + 1;
                            out.println("<a href='popupproduto_venda.jsp?busca=" + busca + "&pagina=" + proxima + "'> Próxima >></a> ");
                        }
                        out.println("</center>");
                    }
                } catch (SQLException err) {
                    out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                }
            %> 
    </body> 
</html> 
