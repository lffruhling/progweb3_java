<%-- 
    Document   : WSlistaPessoa
    Created on : 03/03/2017, 20:42:42
    Author     : Aula
--%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro de Pessoas</title>
</head>
<body>
    <h1>Cadastro de Pessoas Usando Web Service</h1>
    <div id=formPadrao>
        <form name="fAlterarPessoa" id="fAlterarPessoa" method="post" action="WSalteraPessoa.jsp">
        <fieldset >
            <legend>Pessoas Cadastradas:</legend>
            
            <table border=0><tr><th>Id</th><th>Nome</th><th></th></tr>
                <%
                    ClienteWSCadastro.WSCadastros cp = null;
                    
                    try {
                        ClienteWSCadastro.WSCadastros_Service service = new
                        ClienteWSCadastro.WSCadastros_Service();
                        cp = service.getWSCadastrosPort();
                    } catch (Exception ex) {
                        out.println("<script>alert('Erro: " + ex.getMessage() + "');</script>");
                    }
                    
                    if (cp != null) {
                        String s = cp.listarTodos();
                        JSONParser parser = new JSONParser();
                        Object obj;
                        obj = null;
                        
                        try {
                            obj = parser.parse(s);
                        } catch (ParseException ex) {
                            System.out.println("Erro: " + ex);
                        }
                        
                        JSONArray slideContent = (JSONArray) obj;
                        Iterator i = slideContent.iterator();
                        
                        while (i.hasNext()) {
                            String s2 = i.next().toString();
                            try {
                                Object objs = parser.parse(s2);
                                JSONObject obj2 = (JSONObject) objs;
                                out.println("<tr><td>" + obj2.get("id") +
                                "</td>"); //mostra o identificador
                                out.println("<td>" + obj2.get("nome") +
                                "</td>"); //mostra o nome da pessoa
                                out.println("<td><button type=\"submit\"name=\"alterar\" id=\"alterar\" value=\"" + obj2.get("id") + "\">Alterar</button></td></tr>");
                            } catch (ParseException pe) {
                                System.out.println("position: " +
                                pe.getPosition());
                                System.out.println(pe);
                            }
                        }
                    }
                %>
            </table>
        </fieldset>
        </form>
    </div>
    <br />
    <a href="WScadPessoa.jsp">Cadastrar Pessoas (WS)</a>
</html>