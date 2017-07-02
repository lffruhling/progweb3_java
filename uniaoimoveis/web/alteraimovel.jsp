<%-- 
    Document   : alteraimovel
    Created on : 23/06/2017, 20:02:02
    Author     : Leonardo
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
        <title>União Imóveis</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
            /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
            .row.content {height: 550px}

            /* Set gray background color and 100% height */
            .sidenav {
                background-color: #f1f1f1;
                height: 100%;
            }

            /* On small screens, set height to 'auto' for the grid */
            @media screen and (max-width: 767px) {
                .row.content {height: auto;} 
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-inverse visible-xs">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>                        
                    </button>
                    <a class="navbar-brand" href="#">Logo</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li><a href="/uniaoimoveis">Início</a></li>
                        <li><a href="cadimovel.jsp">Novo Imóvel</a></li>
                        <li><a href="listaimovel.jsp">Lista de Imóveis</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row content">
                <div class="col-sm-3 sidenav hidden-xs">
                    <img style="margin-top: 15px" src="img/logo_hor.png" class="img-responsive"/>
                    <hr>
                    <ul class="nav nav-pills nav-stacked">
                        <li><a href="/uniaoimoveis">Início</a></li>
                        <li><a href="cadimovel.jsp">Novo Imóvel</a></li>
                        <li><a href="listaimovel.jsp">Imóveis Cadastrados</a></li>
                    </ul><br>
                </div>
                <br>

                <div class="col-sm-9">
                    <div class="well">
                        <h1>Edição do Imóvel</h1>
                        <div id=formPadrao>
                            <%
                                if (request.getParameter("botao") != null
                                        && request.getParameter("botao").equals("Excluir")) {
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con
                                                = DriverManager.getConnection("jdbc:mysql://localhost/provapw3?user=iffar&password=iffar");
                                        PreparedStatement pstmt = con.prepareStatement("select * from imovel where codigo = ?");
                                        pstmt.setString(1, request.getParameter("alterar"));
                                        ResultSet rs = pstmt.executeQuery();
                                        if (rs.next()) {
                                            String nome = rs.getString("descricao");
                                            out.println("<script> if(confirm('Você deseja excluir definitivamente o imóvel " + nome + "?')) { location.href ='alteraimovel.jsp?acao=ConfirmaExcluir&id=" + request.getParameter("alterar") + "';}else{ "
                                                    + "alert('Registro não excluido!'); "
                                                    + "location.href = 'listaimovel.jsp'; "
                                                    + "} </script>");
                                        }
                                    } catch (SQLException err) {
                                        out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                                    }
                                }
                                if (request.getParameter("acao") != null
                                        && request.getParameter("acao").equals("ConfirmaExcluir")) {
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con
                                                = DriverManager.getConnection("jdbc:mysql://localhost/provapw3?user=iffar&password=iffar");
                                        PreparedStatement pstmt = con.prepareStatement(" delete from imovel where codigo = ?");
                                        pstmt.setString(1, request.getParameter("id"));
                                        pstmt.executeUpdate();
                                        response.sendRedirect("listaimovel.jsp");
                                    } catch (SQLException err) {
                                        out.println("<script>alert(\"Erro. Não é possível excluir esse registro:" + err.getMessage() + "\");</script>");
                                    }
                                }

                                if (request.getParameter("botao") != null
                                        && request.getParameter("botao").equals("Salvar")) {
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con
                                                = DriverManager.getConnection("jdbc:mysql://localhost/provapw3?user=iffar&password=iffar");
                                        PreparedStatement pstmt = con.prepareStatement("update imovel set descricao=?, tipo=?, nroquartos=?, valor=? where codigo = ? ");
                                        pstmt.setString(1, request.getParameter("descricao"));
                                        pstmt.setString(2, request.getParameter("tipo"));
                                        pstmt.setString(3, request.getParameter("nroquartos"));
                                        pstmt.setString(4, request.getParameter("valor"));
                                        pstmt.setString(5, request.getParameter("alterar"));
                                        pstmt.executeUpdate();
                                        response.sendRedirect("listaimovel.jsp");
                                    } catch (SQLException err) {
                                        out.println("<script>alert(\"Ocorreu um Erro na Alteração: " + err.getMessage() + "\");</script>");
                                    }
                                }
                                String descricao = "";
                                String tipo = "";
                                String nroquartos = "";
                                String valor = "";
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con
                                            = DriverManager.getConnection("jdbc:mysql://localhost/provapw3?user=iffar&password=iffar");
                                    PreparedStatement pstmt = con.prepareStatement("select * from imovel where codigo = ?");
                                    pstmt.setString(1, request.getParameter("alterar"));
                                    ResultSet rs = pstmt.executeQuery();
                                    if (rs.next()) {
                                        descricao = rs.getString("descricao");
                                        tipo = rs.getString("tipo");
                                        nroquartos = rs.getString("nroquartos");
                                        valor = rs.getString("valor");
                                    }
                                } catch (SQLException err) {

                                    out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                                }
                            %>
                            <div id=formPadrao>
                                <form name="fCadImovel" id="fCadImovel" method="post" action="alteraimovel.jsp">
                                    <fieldset class="form-group">
                                        <legend>Alteração dos dados do Imóvel</legend>
                                        <label for="descricao">Descrição:*</label><br />
                                        <input class="form-control" type="text" name="descricao" id="descricao" size="50" maxlength="255" value="<%out.println(descricao);%>" required/><br />
                                        <label for="tipo">Tipo:</label><br />
                                        <input class="form-control" type="text" name="tipo" id="tipo" size="50" maxlength="255" value="<%out.println(tipo);%>"/><br />
                                        <label for="nroquartos">Número de Dormitórios:</label><br />
                                        <input class="form-control" type="text" name="nroquartos" id="nroquartos" size="50" value="<%out.println(nroquartos);%>"/><br />
                                        <label for="valor">Valor:</label><br />
                                        <input class="form-control" type="text" name="valor" id="valor" size="50" step="any" value="<%out.println(valor);%>" ><br />
                                        <br />
                                        <input class="btn btn-success" type="submit" name="botao" id="botao" value="Salvar" />
                                        <input class="btn btn-danger" type="submit" name="botao" id="botao" value="Excluir" />
                                        <%
                                            if (request.getParameter("alterar") != null) {
                                                out.println("<INPUT TYPE=\"hidden\" NAME=\"alterar\" VALUE=\"" + request.getParameter("alterar") + "\">");
                                            }
                                        %>
                                    </fieldset>
                                </form>
                            </div>
                            <br />

                        </div>
                    </div>
                </div>
            </div>

    </body>
</html>
