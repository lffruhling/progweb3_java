<%-- 
    Document   : listaimovel
    Created on : 23/06/2017, 19:55:37
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
                        <li class="active"><a href="listaimovel.jps">Lista de Imóveis</a></li>
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
                        <li class="active"><a href="listaimovel.jsp">Imóveis Cadastrados</a></li>
                    </ul><br>
                </div>
                <br>

                <div class="col-sm-9">
                    <div class="well">
                        <h1>Lista de Imóveis Cadastrados</h1>
                        <div id=formPadrao>
                            <form name="fAlterarImovel" id="fAlterarImovel" method="post" action="alteraimovel.jsp">
                                <fieldset >
                                    <legend>Imóveis Cadastrados:</legend>
                                    <table class="table table-striped"><tr><th>Código</th><th>Descricao</th><th></th></tr>
                                                <%
                                                    try {
                                                        Class.forName("com.mysql.jdbc.Driver");
                                                        Connection con
                                                                = DriverManager.getConnection("jdbc:mysql://localhost/provapw3?user=iffar&password=iffar");
                                                        PreparedStatement pstmt
                                                                = con.prepareStatement("select * from imovel order by codigo desc");
                                                        ResultSet rs = pstmt.executeQuery();
                                                        while (rs.next()) {
                                                            out.println(
                                                                    "<tr><td>" + rs.getString("codigo") + "</td>"); //mostra o identificador
                                                            out.println(
                                                                    "<td>" + rs.getString("descricao") + "</td>"); //mostra o nome da pessoa
                                                            out.println("<td><button class='btn btn-warning' type=\"submit\"name=\"alterar\" id=\"alterar\" value=\"" + rs.getString("codigo") + "\">Alterar</button></td></tr>");
                                                        }
                                                    } catch (SQLException err) {
                                                        out.println("<script>alert(\"Erro: "
                                                                + err.getMessage() + "\");</script>");
                                                    }

                                                %>
                                    </table>
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
