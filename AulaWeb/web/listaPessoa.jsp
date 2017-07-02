<%-- 
    Document   : listaPessoa
    Created on : 24/02/2017, 20:39:35
    Author     : Aula
--%>

<%@page import="IFFar.CadastrosRemote"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lista de Pessoas</title>
</head>
<body>
    <h1>Lista de Pessoas</h1>
    <div id=formPadrao>
        <form name="fAlterarPessoa" id="fAlterarPessoa" method="post"
        action="alteraPessoa.jsp">
            <fieldset >
                <legend>Pessoas Cadastradas:</legend>
                <table border=0><tr><th>Id</th><th>Nome</th><th></th></tr>
                    <%
                        InitialContext ctx = null;
                        CadastrosRemote cp;
                        cp = null;
                        
                        try {
                            ctx = new InitialContext();// ser for aplicação local ou
                            /* o codigo a seguir se for aplicação remota
                            Properties p = new Properties();
                            p.put("org.omg.CORBA.ORBInitialHost", "192.168.1.192");
                            p.put("org.omg.CORBA.ORBInitialPort", "3700");
                            ctx = new InitialContext(p); */
                        } catch (NamingException ex) {
                            System.out.println("Erro: " + ex);
                        }
                        
                        try {
                            cp = (CadastrosRemote)
                            ctx.lookup("java:global/EJBAulaWeb/Cadastros");
                        } catch (NamingException ex) {
                            System.out.println("Erro: " + ex);
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
                                    out.println("<td><button type=\"submit\" name=\"alterar\" id=\"alterar\" value=\"" + obj2.get("id") + "\">Alterar</button></td></tr>");
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
    <a href="cadPessoa.jsp">Cadastrar Pessoas</a>
</html>