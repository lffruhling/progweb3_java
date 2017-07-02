<%-- 
    Document   : exemplo1.jsp
    Created on : 03/04/2017, 12:04:33
    Author     : Evandro
--%>

<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>    
    <body>
        <%! String[] semana= {"Domingo","Segunda","Terça","Quarta","Quinta","Sexta","Sabado"}; %>
        <%! int soma (int x, int y) 
	{ 	
		return (x + y); 
	} %>

        
        <%= new java.util.Date()%>
        <br><br>
        <%
            Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Brazil/East"));
            //int ano = calendar.get(Calendar.YEAR);
            //int mes = calendar.get(Calendar.MONTH); // O mês vai de 0 a 11.
            //int semana = calendar.get(Calendar.WEEK_OF_MONTH);
            //int dia = calendar.get(Calendar.DAY_OF_MONTH);
            int hora = calendar.get(Calendar.HOUR_OF_DAY);
            //int minuto = calendar.get(Calendar.MINUTE);
            //int segundo = calendar.get(Calendar.SECOND);
            int diasem = calendar.get(Calendar.DAY_OF_WEEK);
            if (request.getParameter("Enviar") != null) {
                if (hora >= 6 && hora < 12) {
                    out.println("Olá, Bom Dia, " + request.getParameter("nome") + "!<br>");
                } else if (hora < 18) {
                    out.println("Olá, Boa Tarde, " + request.getParameter("nome") + "!<br>");
                } else {
                    out.println("Olá, Boa Noite" + request.getParameter("nome") + "!<br>");
                }
                if (diasem==1 || diasem==7) out.println("Tenha um ótimo "+semana[diasem-1]+"!<br>");
                else out.println("Tenha uma ótima "+semana[diasem-1]+"!<br>");
                switch (diasem) {
                    case 1:
                        out.println("Tenha um ótimo domingo!<br>");
                        break;
                    case 2:
                        out.println("Tenha uma ótima segunda-feira!<br>");
                        break;
                    case 3:
                        out.println("Tenha uma ótima terça-feira!<br>");
                        break;
                    case 4:
                        out.println("Tenha uma ótima quarta-feira!<br>");
                        break;
                    case 5:
                        out.println("Tenha uma ótima quinta-feira!<br>");
                        break;
                    case 6:
                        out.println("Tenha uma ótima sexta-feira!<br>");
                        break;
                    case 7:
                        out.println("Tenha um ótimo sábado!<br>");
                        break;
                }
                int v1, v2;
                try {
                v1 = Integer.parseInt(request.getParameter("v1"));
                }
                catch( Exception e) {
                    v1=0;
                }
                try {
                v2 = Integer.parseInt(request.getParameter("v2"));
                }
                catch( Exception e) {
                    v2=0;
                }   
                out.println("<br>Soma: "+String.valueOf(soma(v1,v2)));
            }
        %>
        <br><br>
        <div>
            <form action="exemplo1.jsp" method="POST">            
                Informe seu nome: <br>
                <input type="text" name="nome" value="" size="30"><br>
                Valor 1: <br>
                <input type="text" name="v1" value="" size="30"><br>
                Valor 2: <br>
                <input type="text" name="v2" value="" size="30"> <br>
                <input type="submit" value="Enviar" name="Enviar">
            </form>           
        </div>
    </body>
</html>
