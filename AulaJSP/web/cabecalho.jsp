<!DOCTYPE HTML>
<html>

    <head>
        <title>Cadastros</title>
        <meta name="description" content="website description" />
        <meta name="keywords" content="website keywords, website keywords" />
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <!-- modernizr enables HTML5 elements and feature detects -->
        <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
    </head>

    <body>
        <%
            String login = "";
            String nome = "";
            
                try {
                    //recupera o atributo da sessão, converte para string e armazena na variável
                    login = session.getAttribute("login").toString();
                    nome = session.getAttribute("nome").toString();                    
                } catch (Exception e) {//caso a sessão não tenha sido inicializada                    
                }
String errormsg = "";                
                try {                  
                    errormsg = session.getAttribute("errormsg").toString();
                } catch (Exception e) {//caso a sessão não tenha sido inicializada                    
                }
                if (errormsg.length()>0) {
                    out.println("<script>alert(\"" + errormsg + "\");</script>");
                    session.setAttribute("errormsg","");
                }

        %>



    </script>
    <div id="main">
        <header>
            <div id="logo">
                <div id="logo_text">
                    <!-- class="logo_c'olour", allows you to change the colour of the text -->
                    <img src="logo.png" height="90px">          
                    <div id="usuario">
                        <div id="usuario-name">
                            <%= nome %>
                        </div>
                    </div>
                </div>

            </div>
            <nav>
                <ul class="sf-menu" id="nav">
                    <li class="selected"><a href="index.jsp">Página Principal</a></li>
                    <li><a href="#">Cadastros</a>
                        <ul>
                            <li><a href="cadpessoa.jsp" >Pessoas</a></li>
                            <li><a href="cadusuario.jsp">Usuários</a></li>
                            <li><a href="cadproduto.jsp">Produtos</a></li>
                        </ul>
                    <li><a href="#">Listagem</a>
                        <ul>
                            <li><a href="listapessoa.jsp" >Pessoas</a></li>
                            <li><a href="listaproduto.jsp" >Produtos</a></li>
                            <li><a href="relListaProdutos.jsp" >Lista de Preços</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Operações</a>
                        <ul>
                            <li><a href="venda.jsp" >Vender</a></li>
                        </ul>
                    </li>

                    <%
                        if (login.length()==0) {
                            out.println("<li><a href=\"login.jsp\">Login</a></li>");
                        } else {
                            out.println("<li><a href=\"logout.jsp\">Sair</a></li>");
                        }
                    %>                    

                </ul>
            </nav>
        </header>
