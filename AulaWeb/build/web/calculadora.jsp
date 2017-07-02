<%-- 
    Document   : cadPessoa
    Created on : 10/04/2017, 20:39:01
    Author     : Leonardo
--%>

<%@page import="java.lang.System.out"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="IFFar.CadastrosRemote"%>
<%@page language = "java" %>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Calculadora de Políticos</title>
</head>
<body>
    <h1>Calculadora de Políticos</h1>
    <%!
        double AtualizaValor (){
            double retorno = 0;
            try{
                Class.forName("com.mysql.jdbc.Driver");}
            catch (Exception e){
            }
            
            try{
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement("select valor from propina");
                ResultSet rs = pstmt.executeQuery();
                while (rs.next())
                {
                    retorno = rs.getDouble("valor");
                }
            }catch (SQLException err) {
                retorno = 0;
                out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
            }
         return retorno;   
        } 
    %>
    
    <%
        int v1 = 0;
        int v2 = 0;
        double result = 0;
        double porcentagemBase = 0;
        double porcentagemCalc = 0;
        
        
        //Busca Valor Base
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            PreparedStatement pstmt = con.prepareStatement("select valor from propina");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next())
            {
                porcentagemBase = rs.getDouble("valor");
            }
        } catch (SQLException err) {
            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
        }
        
        //Calcula Adição
        if (request.getParameter("adicao")!=null && request.getParameter("adicao").equals("+")) {

            v1 = Integer.parseInt(request.getParameter("v1"));
            v2 = Integer.parseInt(request.getParameter("v2"));
            
            result = v1 + v2;
            
            porcentagemCalc = ((result * 10)/100);
            
            out.println("<hr><h2>Resultado da Soma: </h2><p> R$: "+(result-porcentagemCalc)+"</p>");
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement("update propina set valor = ? where id = 1;");
                pstmt.setDouble(1, (porcentagemCalc + porcentagemBase));
                pstmt.executeUpdate();
            } catch (SQLException err) {
                out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
            } 
        }
        
        //Calcula subtração
        if (request.getParameter("subtrai")!=null && request.getParameter("subtrai").equals("-")) {

            v1 = Integer.parseInt(request.getParameter("v1"));
            v2 = Integer.parseInt(request.getParameter("v2"));
            
            result = v1 - v2;
            
            porcentagemCalc = ((result * 10)/100);
            
            out.println("<hr><h2>Resultado da Subtração </h2><p>"+(result-porcentagemCalc)+"</p>");
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement("update propina set valor = ? where id = 1;");
                pstmt.setDouble(1, (porcentagemCalc + porcentagemBase));
                pstmt.executeUpdate();
            } catch (SQLException err) {
                out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
            } 
        }
        
        //Calcula Multiplicação
        if (request.getParameter("multiplica")!=null && request.getParameter("multiplica").equals("*")) {

            v1 = Integer.parseInt(request.getParameter("v1"));
            v2 = Integer.parseInt(request.getParameter("v2"));
            
            result = v1 * v2;
            
            porcentagemCalc = ((result * 10)/100);
            
            out.println("<hr><h2>Resultado da Multiplicação: </h2><p>"+(result-porcentagemCalc)+"</p>");
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement("update propina set valor = ? where id = 1;");
                pstmt.setDouble(1, (porcentagemCalc + porcentagemBase));
                pstmt.executeUpdate();
            } catch (SQLException err) {
                out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
            } 
        }
        
        //Calcula Divisão
        if (request.getParameter("divisao")!=null && request.getParameter("divisao").equals("/")) {

            v1 = Integer.parseInt(request.getParameter("v1"));
            v2 = Integer.parseInt(request.getParameter("v2"));
            
            result = v1 / v2;
            
            porcentagemCalc = ((result * 10)/100);
            
            out.println("<hr><h2>Resultado da Divisão </h2><p>"+(result-porcentagemCalc)+"</p>");
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
                PreparedStatement pstmt = con.prepareStatement("update propina set valor = ? where id = 1;");
                pstmt.setDouble(1, (porcentagemCalc + porcentagemBase));
                pstmt.executeUpdate();
            } catch (SQLException err) {
                out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
            } 
        }
        
        //Busca Valor Base
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            PreparedStatement pstmt = con.prepareStatement("select valor from propina");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next())
            {
                porcentagemBase = rs.getDouble("valor");
            }
        } catch (SQLException err) {
            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
        }
        if(porcentagemBase > 0 ){
                out.println("<h2>Tarifa acumulada dos Cálculos: </h2><p>R$: "+String.format("%.2f", porcentagemBase)+"</p><hr>");
        }
        
    %>    
    
    <div id=formPadrao> <!— mostra um formulário para cadastrar pessoas -->
        <form name="fcalcula" id="fCadPessoa" method="post" action="calculadora.jsp">
            <fieldset >
                <legend>Informe os Valores</legend>
                <label for="v1">Valor 1:</label><br />
                <input type="number" name="v1" id="v1" size="50" maxlength="50" required/><br/>
                <label for="v2">Valor 2:</label><br />
                <input type="number" name="v2" id="v2" size="50" maxlength="11" required/><br />
                
                <br />
                <input type="submit" name="adicao"      id="adicao"     value="+" />
                <input type="submit" name="subtrai"     id="subtrai"    value="-" />
                <input type="submit" name="multiplica"  id="multiplica" value="*" />
                <input type="submit" name="divisao"     id="divisao"    value="/" />
            </fieldset>
        </form>
    </div>
</body>
</html>
