<%@page import="net.sf.jasperreports.engine.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>JSP Page</title>
 </head>
 <body>
 <h2>Hello World!</h2>
 <%
 Connection conn = null;
 try {
 Class.forName("com.mysql.jdbc.Driver");
 conn = DriverManager.getConnection("jdbc:mysql://localhost/iffar", "iffar","iffar");
 } catch (Exception ex) {
 ex.printStackTrace();
 }
 File reportFile = new
File(application.getRealPath("relListaProdutos.jasper"));//your report_name.jasper file
 Map parameters = new HashMap();

 byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters,conn);
 response.setContentType("application/pdf");
 response.setContentLength(bytes.length);
 ServletOutputStream outStream = response.getOutputStream();
 outStream.write(bytes, 0, bytes.length);
 outStream.flush();
 outStream.close();
 %>
 </body>
</html>
