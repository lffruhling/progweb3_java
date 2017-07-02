<%-- 
    Document   : cadPessoa
    Created on : 24/02/2017, 20:39:01
    Author     : Aula
--%>

<%@page import="IFFar.CadastrosRemote"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro de Pessoa</title>
</head>
<body>
    <h1>Cadastro de Pessoa</h1>
    <div>
    <%@page language = "java" %>
    <%@page import = "java.util.*" %>
    <%@page import = "java.util.Properties" %>
    <%@page import = "java.util.logging.Level" %>
    <%@page import = "java.util.logging.Logger" %>
    <%@page import = "javax.naming.InitialContext" %>
    <%@page import = "javax.naming.NamingException" %>
        <%
            if (request.getParameter("nome") != null) {
                InitialContext ctx = null;
                CadastrosRemote cp;
                cp = null;

                try {
                    ctx = new InitialContext(); // ser for aplicação local ou
                    /* o codigo a seguir se for aplicação remota
                    Properties p = new Properties();
                    p.put("org.omg.CORBA.ORBInitialHost", "192.168.1.175");
                    p.put("org.omg.CORBA.ORBInitialPort", "3700");
                    ctx = new InitialContext(p); */
                } catch (NamingException ex) {
                    out.println("<script>alert('Erro: " + ex + "');</script>");
                }

                try {
                    cp = (CadastrosRemote) ctx.lookup("java:global/EJBAulaWeb/Cadastros");
                } catch (NamingException ex) {
                    out.println("<script>alert('Erro: " + ex + "');</script>");
                }

                if (cp != null) {
                    String r = cp.cadastrarPessoa(request.getParameter("nome"),
                    request.getParameter("cpf"), request.getParameter("email"), request.getParameter("fone"));

                    if (r.equals("OK")) {
                        out.println("<script>alert('" + request.getParameter("nome") + "Cadastrado.');</script>");
                    }else {
                        out.println("<script>alert(\"" + r + "\");</script>");
                    }

                    try {
                        ctx.close();
                    } catch (NamingException ex) {
                        out.println("<script>alert('Erro: " + ex + "');</script>");
                    }
                } else {
                    out.println("<script>alert('Erro acessando aplicação.');</script>");
                }
            }
        %>
    </div>
    <div id=formPadrao> <!— mostra um formulário para cadastrar pessoas -->
        <form name="fCadPessoa" id="fCadPessoa" method="post" action="cadPessoa.jsp">
            <fieldset >
                <legend>Informe os dados da Pessoa:</legend>
                <label for="nome">Nome:</label><br />
                <input type="text" name="nome" id="nome" size="50" maxlength="50" required/><br/>
                <label for="cpf">CPF:</label><br />
                <input type="text" name="cpf" id="cpf" size="50" maxlength="11" required/><br />
                <label for="email">E-Mail:</label><br />
                <input type="email" name="email" id="email" size="50" maxlength="100" required/><br />
                <label for="fone">Fone:</label><br />
                <input type="text" name="fone" id="fone" size="50" maxlength="30" ><br />
                <br />
                <input type="submit" name="botao" id="botao" value="Cadastrar" />
            </fieldset>
        </form>
    </div>
    <a href="listaPessoa.jsp">Listar Pessoas</a>
</body>
</html>
