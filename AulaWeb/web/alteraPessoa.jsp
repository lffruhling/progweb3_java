<%-- 
    Document   : alteraPessoa
    Created on : 24/02/2017, 20:39:24
    Author     : Aula
--%>

<%@page import="IFFar.CadastrosRemote"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro de Pessoa</title>
</head>
<body>
    <h1>Alterar Pessoa</h1>
    <div id=formPadrao>
        <%
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
            
            if (request.getParameter("botao") != null && request.getParameter("botao").equals("Salvar")) {
                if (cp != null) {
                    String r = cp.alterarPessoa(request.getParameter("alterar"),
                    request.getParameter("nome"), request.getParameter("cpf"), request.getParameter("email"),
                    request.getParameter("fone"));
                    
                    if (r.equals("OK")) {
                        response.sendRedirect("listaPessoa.jsp");
                    } else {
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
            
            String nome = "";
            String cpf = "";
            String email = "";
            String fone = "";
            
            if (request.getParameter("alterar") != null) {
                if (cp != null) {

                    String s = cp.listarPessoa(request.getParameter("alterar"));
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
                out.println(
                        "<script> if(confirm('Você deseja excluir definitivamente apessoa "
                        + nome + "?')) { location.href ='alteraPessoa.jsp?acao=ConfirmaExcluir&id="
                        + request.getParameter("alterar") + "';}else{ "+ "alert('Registro não excluido!'); "
                        + "location.href = 'listaPessoa.jsp'; "
                        + "} </script>"
                );
            }
            
            if (request.getParameter("acao") != null && request.getParameter("acao").equals("ConfirmaExcluir")) {
                if (cp != null) {
                    String r = cp.excluirPessoa(request.getParameter("id"));
                    if (r.equals("OK")) {
                        response.sendRedirect("listaPessoa.jsp");
                    } else {
                        out.println("<script>alert(\"Erro. Não é possível excluir esse registro: \");</script>");
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
    <div id=formPadrao>
        <form name="fCadPessoa" id="fCadPessoa" method="post" action="alteraPessoa.jsp">
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
    <a href="cadPessoa.jsp">Cadastrar Pessoas</a><br />
    <a href="listaPessoa.jsp">Listar Pessoas</a>
</body>
</html>