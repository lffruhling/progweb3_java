<%-- 
    Document   : WSalteraPessoa
    Created on : 03/03/2017, 20:42:21
    Author     : Aula
--%>

<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro de Pessoa</title>
</head>
<body>
    <h1>Cadastro de Pessoa usando Web Service</h1>
    <%
        ClienteWSCadastro.WSCadastros port = null;
        
        try {
            ClienteWSCadastro.WSCadastros_Service service = new
            ClienteWSCadastro.WSCadastros_Service();
            port = service.getWSCadastrosPort();
        } catch (Exception ex) {
            out.println("<script>alert('Erro: " + ex.getMessage() + "');</script>");
        }
        
        if (request.getParameter("botao") != null && request.getParameter("botao").equals("Salvar")) {
            if (port != null) {
                String r = port.alterarPessoa(request.getParameter("alterar"), new
                String(request.getParameter("nome").getBytes("iso-8859-1"), "UTF-8"),
                request.getParameter("cpf"), request.getParameter("email"), request.getParameter("fone"));
            
                if (r.equals("OK")) {
                    response.sendRedirect("WSlistaPessoa.jsp");
                } else {
                    out.println("<script>alert(\"" + r + "\");</script>");
                }
            
            } else {
                out.println("<script>alert('Erro acessando aplicação.');</script>");
            }
        }
        
        String nome = "";
        String cpf = "";
        String email = "";
        String fone = "";
        
        if (request.getParameter("alterar") != null) {
            if (port != null) {
                String s = port.listarPessoa(request.getParameter("alterar"));
                JSONParser parser = new JSONParser();
                
                try {
                    Object obj = parser.parse(s);
                    JSONObject obj2 = (JSONObject) obj;
                    nome = obj2.get("nome").toString();
                    cpf = obj2.get("cpf").toString();
                    email = obj2.get("email").toString();
                    fone = obj2.get("fone").toString();
                } catch (ParseException pe) {
                    System.out.println("position: " + pe.getPosition());
                    System.out.println(pe);
                }
            } else {
                out.println("<script>alert(\"Erro no acesso ao servidor de aplicações.\");</script>");
            }
        }
        
        if (request.getParameter("botao") != null && request.getParameter("botao").equals("Excluir")) {
            out.println("<script> if(confirm('Você deseja excluir definitivamente a pessoa "
            + nome + "?')) { location.href = 'WSalteraPessoa.jsp?acao=ConfirmaExcluir&id="
            + request.getParameter("alterar") + "';}else{ "
            + "alert('Registro não excluido!'); "
            + "location.href = 'WSlistaPessoa.jsp'; "
            + "} </script>");
        }
        
        if (request.getParameter("acao") != null && request.getParameter("acao").equals("ConfirmaExcluir")) {
        
            if (port != null) {
                String r = port.excluirPessoa(request.getParameter("id"));
                if (r.equals("OK")) {
                    response.sendRedirect("WSlistaPessoa.jsp");
                } else {
                    out.println("<script>alert(\"Erro. Não é possível excluir esse registro: \");</script>");
                }
            } else {
                out.println("<script>alert('Erro acessando aplicação.');</script>");
            }
        }
    %>
    <div id=formPadrao>
        <form name="fCadPessoa" id="fCadPessoa" method="post"
        action="WSalteraPessoa.jsp">
            <fieldset >
                <legend>Alteração dos dados da Pessoa:</legend>
                
                <label for="nome">Nome:</label><br />
                <input type="text" name="nome" id="nome" size="50" maxlength="50" value="<%out.println(nome);%>" required/><br />
                
                <label for="cpf">CPF:</label><br />
                <input type="text" name="cpf" id="cpf" size="50" maxlength="11" value="<%out.println(cpf);%>" required/><br />
                
                <label for="email">E-Mail:</label><br />
                <input type="email" name="email" id="email" size="50" maxlength="100" value="<%out.println(email);%>" required/><br />
                
                <label for="fone">Fone:</label><br />
                <input type="text" name="fone" id="fone" size="50" maxlength="30" value="<%out.println(fone);%>" ><br />
                
                <br />
                <input type="submit" name="botao" id="botao" value="Salvar" />
                
                <input type="submit" name="botao" id="botao" value="Excluir" />
                
                <%
                    if (request.getParameter("alterar") != null) {
                        out.println("<INPUT TYPE=\"hidden\" NAME=\"alterar\" VALUE=\"" +
                        request.getParameter("alterar") + "\">");
                    }
                %>
            </fieldset>
        </form>
    </div>
    <br />
    <a href="WScadPessoa.jsp">Cadastrar Pessoas (WS)</a><br />
    <a href="WSlistaPessoa.jsp">Listar Pessoas (WS)</a>
</body>
</html>