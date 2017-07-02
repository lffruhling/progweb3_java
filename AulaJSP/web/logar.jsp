<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
        PreparedStatement pstmt = con.prepareStatement("select * from usuario, pessoa where login = ? and senha = sha1(?) and pessoa_id = id; ");
        pstmt.setString(1, request.getParameter("login"));
        pstmt.setString(2, request.getParameter("password"));
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            String nome = rs.getString("nome");
            String login = rs.getString("login");            
            session.setAttribute("login",login); //cria a sessão gravando o login
            session.setAttribute("nome",nome); //cria a sessão gravando o nome         
            response.sendRedirect("index.jsp"); //redireciona para a página principal
        }
        else {
            session.setAttribute("errormsg","Usuario não autorizado ou senha incorreta!");
            response.sendRedirect("login.jsp"); //redireciona para o login
        }
    } catch (SQLException err) {
        session.setAttribute("errormsg","Erro conectando com o Banco de Dados.");
        response.sendRedirect("login.jsp"); //redireciona para o login
    }
%>
