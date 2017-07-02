<%
    session.removeAttribute("login");    
    session.removeAttribute("nome");
    session.invalidate();
    response.sendRedirect("login.jsp"); //redireciona para o login
%>

