<%-- 
    Document   : WScadPessoa
    Created on : 03/03/2017, 20:41:58
    Author     : Aula
--%>

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
        <%
            if (request.getParameter("nome") != null) {
                String r = "";
                
                try {
                    ClienteWSCadastro.WSCadastros_Service service = new ClienteWSCadastro.WSCadastros_Service();
                    ClienteWSCadastro.WSCadastros port = service.getWSCadastrosPort();
                     // TODO initialize WS operation arguments here
                    java.lang.String nome = request.getParameter("nome");
                    java.lang.String cpf = request.getParameter("cpf");
                    java.lang.String email = request.getParameter("email");
                    java.lang.String fone = request.getParameter("fone");
                    // TODO process result here
                    r = port.cadastrarPessoa(nome, cpf, email, fone);
                } catch (Exception ex) {
                    // TODO handle custom exceptions here
                    out.println("Error  "+ ex);
                }
                
                if (r.equals("OK")) {
                out.println("<script>alert('" + request.getParameter("nome") + "Cadastrado.');</script>");
            } else {
                out.println("<script>alert(\"" + r + "\");</script>");
            }
            }
        %>
    </div>
    <div id=formPadrao> <!— mostra um formulário para cadastrar pessoas -->
        <form name="fCadPessoa" id="fCadPessoa" method="post" action="cadPessoa.jsp">
            <fieldset >
                
                <legend>Informe os dados da Pessoa:</legend>
                
                <label for="nome">Nome:</label><br />
                <input type="text" name="nome" id="nome" size="50" maxlength="50" required/><br />
                
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
    <a href="WSlistaPessoa.jsp">Listar Pessoas</a>
    
</body>
</html>