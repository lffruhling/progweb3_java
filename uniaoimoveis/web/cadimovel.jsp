<%-- 
    Document   : cadimovel
    Created on : 23/06/2017, 19:36:40
    Author     : Leonardo
--%>

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
                        <li class="active"><a href="cadimovel.jsp">Novo Imóvel</a></li>
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
                        <li class="active"><a href="cadimovel.jsp">Novo Imóvel</a></li>
                        <li><a href="listaimovel.jsp">Imóveis Cadastrados</a></li>
                    </ul><br>
                </div>
                <br>

                <div class="col-sm-9">
                    <div class="well">
                        <h1>Cadastro de Imóvel</h1>
                        <div id=formPadrao> <!— mostra um formulário para cadastrar imovel -->
                            <%
                                if (request.getParameter("botao") != null
                                        && request.getParameter("botao").equals("Cadastrar")) {
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/provapw3?user=iffar&password=iffar");
                                        PreparedStatement pstmt = con.prepareStatement(" INSERT INTO imovel (descricao, tipo, nroquartos, valor) VALUES( ?, ?, ?, ?)");
                                        pstmt.setString(1, request.getParameter("descricao"));
                                        pstmt.setString(2, request.getParameter("tipo"));
                                        pstmt.setString(3, request.getParameter("nroquartos"));
                                        pstmt.setString(4, request.getParameter("valor"));
                                        pstmt.executeUpdate();
                                        out.println("<script>alert('Imóvel Cadastrado com Sucesso!');</script>");
                                    } catch (SQLException err) {
                                        out.println("<script>alert(\"Erro: " + err.getMessage()
                                                + "\");</script>");
                                    }
                                }
                            %>
                            <form name="fCadImovel" id="fCadImovel" method="post" action="cadimovel.jsp">
                                <fieldset class="form-group">
                                    <legend>Informe os dados da Imóvel:</legend>
                                    <label for="descricao">Descrição:*</label><br />
                                    <input class="form-control" type="text" name="descricao" id="descricao" size="50" maxlength="255" required /><br />
                                    <label for="tipo">Tipo</label><br />
                                    <input class="form-control" type="text" name="tipo" id="tipo" size="50" maxlength="255"/><br />
                                    <label for="nroquartos">Número de Dormitórios</label><br />
                                    <input class="form-control" type="number" name="nroquartos" id="nroquartos" size="50" maxlength="100"/><br />
                                    <label for="valor">Valor</label><br />
                                    <input class="form-control" type="number" name="valor" id="valor" size="50" maxlength="30" step="0.01"><br />
                                    <br />
                                    <input type="submit" name="botao" id="botao" value="Cadastrar" class="btn btn-success"/>
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