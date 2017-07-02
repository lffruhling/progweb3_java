<%-- 
    Document   : cadpessoa
    Created on : 20/02/2017, 11:21:15
    Author     : Evandro
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%
    String login = "";
    try {
        login = session.getAttribute("login").toString();
    } catch (Exception e) {//caso a sessão não tenha sido inicializada
        response.sendRedirect("login.jsp");
        return;
    }
    if (login.trim().length() == 0) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="cabecalho.jsp"/>

<div id="site_content">            
    <div class="content">

        <h1>Venda</h1>
        <%
            Connection con = null;
            int idvenda = 0;
            int contitem = 1;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            } catch (Exception e) {
                out.println("<script>alert(\"Erro conectando com o banco de dados.\");</script>");
            }
            if (request.getParameter("botao") != null && request.getParameter("botao").equals("Finalizar")) {                
                try {
                    PreparedStatement pstmt = con.prepareStatement("update venda set total = (select sum(preco*quant) as total from detalhevenda, produto where detalhevenda.idproduto=produto.idproduto and idvenda=?) where idvenda=?");
                    pstmt.setString(1, request.getParameter("hidvenda"));
                    pstmt.setString(2, request.getParameter("hidvenda"));
                    pstmt.executeUpdate();
                    out.println("<script>alert(\"Venda finalizada!\");</script>");
               
                } catch (SQLException err) {
                    out.println("<script>alert(\"Ocorreu um finalizando a venda " + err.getMessage() + "\");</script>");
                }
                idvenda = 0;
                contitem = 1;
            }
            
            if (request.getParameter("excluir") != null) {
                idvenda = Integer.parseInt(request.getParameter("hidvenda"));
                contitem = Integer.parseInt(request.getParameter("hcontitem"));
                try {
                    PreparedStatement pstmt = con.prepareStatement("delete from detalhevenda where item = ? and idvenda = ? ");
                    pstmt.setString(1, request.getParameter("excluir"));
                    pstmt.setString(2, request.getParameter("hidvenda"));
                    pstmt.executeUpdate();
                } catch (SQLException err) {
                    out.println("<script>alert(\"Ocorreu um Erro na Exclusão do item " + err.getMessage() + "\");</script>");
                }
            }

            if (request.getParameter("botao") != null && request.getParameter("botao").equals("Vender")) {
                if (request.getParameter("idvenda") == null || request.getParameter("idvenda").equals("0")) {
                    try {
                        PreparedStatement pstmt = con.prepareStatement(" insert into venda (data, pessoa_id) values (now(),?);");
                        pstmt.setString(1, request.getParameter("pessoa_id"));
                        pstmt.executeUpdate();
                        pstmt = con.prepareStatement("SELECT LAST_INSERT_ID() as idvenda ");
                        ResultSet rs = pstmt.executeQuery();
                        if (rs.next()) {
                            idvenda = rs.getInt("idvenda");
                        }
                    } catch (SQLException err) {
                        out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                    }
                } else {
                    idvenda = Integer.parseInt(request.getParameter("idvenda"));
                }
                if (request.getParameter("contitem") == null) {
                    contitem = 1;
                } else {
                    contitem = Integer.parseInt(request.getParameter("contitem")) + 1;
                }
                try {
                    String sql = " insert into detalhevenda "
                            + "(idvenda, item, quant, precoun, idproduto) "
                            + " values (?,?,"
                            + " ?, (select preco from produto where codigobarras = ?),(select idproduto from produto where codigobarras = ?));";
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, idvenda);
                    pstmt.setString(2, request.getParameter("contitem"));
                    pstmt.setString(3, request.getParameter("quant"));
                    pstmt.setString(4, request.getParameter("codbarras"));
                    pstmt.setString(5, request.getParameter("codbarras"));
                    pstmt.executeUpdate();
                    pstmt = con.prepareStatement("update produto set estoque = estoque - ? where codigobarras = ? ");
                    pstmt.setString(1, request.getParameter("quant"));
                    pstmt.setString(2, request.getParameter("codbarras"));
                    pstmt.executeUpdate();
                } catch (SQLException err) {
                    out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                }
            }
        %>
        <div id=formPadrao> <!— mostra um formulário para realizar a venda -->
            <form name="fVenda" id="fVenda" method="post" action="venda.jsp" >
                <fieldset >
                    <legend>Dados do Cliente</legend>  
                    <br>
                    <label for="pessoa_id">Pessoa: </label>
                    <%
                        String id = "";
                        String nome = "";
                        if (idvenda == 0) {  %>                                             
                    <a href="#" onClick="window.open('popuppessoa_venda.jsp', 'Consulta', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width=500, height=400'); return false;">Localizar</a><br />                                                    
                    <% } else {
                            try {
                                PreparedStatement pstmt = con.prepareStatement("select id, nome from pessoa where id = (select pessoa_id from venda where idvenda= ?)");
                                pstmt.setInt(1, idvenda);
                                ResultSet rs = pstmt.executeQuery();
                                if (rs.next()) {
                                    nome = rs.getString("nome");
                                    id = rs.getString("id");
                                }
                            } catch (SQLException err) {
                                out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                            }
                        }
                    %>
                    <input type="text" name="pessoa_id" id="pessoa_id" size="5" value="<%=id%>" maxlength="5" readonly />
                    <input type="text" name="pessoa_nome" id="pessoa_nome" size="30" value="<%=nome%>"maxlength="50" readonly />
                    <br />    
                    <br />

                    <label for="codbarras">Barcode:</label>
                    <a href="#" onClick="window.open('popupproduto_venda.jsp', 'Consulta', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width=500, height=400'); return false;">Localizar</a><br />                                                                            
                    <br />
                    <input type="text" name="codbarras" id="codbarras" size="20" maxlength="25" required/><br /><br />
                    <label for="nome">Descricao:</label><br />
                    <input type="text" name="nomeproduto" id="nomeproduto" size="40" maxlength="50" readonly/><br /><br />
                    <label for="nome">Preço Unit.:</label><br />
                    <input type="text" name="precounit" id="precounit" size="12" maxlength="12" readonly/><br /><br />
                    <label for="quant">Quant:</label><br />
                    <input type="text" name="quant" id="quant" size="10" maxlength="10" value="1" required/><br /><br />
                    <input type="hidden" name="contitem" id="contitem" value="<%=contitem%>" >
                    <input type="hidden" name="idvenda" id="idvenda" value="<%=idvenda%>" >
                    <input type="submit" name="botao" id="botao" value="Vender" />
                </fieldset>
            </form>
        </div>    
        <div id="formPadrao">
            <table width="80%">
                <form method="post" action="venda.jsp">
                    <input type="hidden" name="hidvenda" value="<%=idvenda%>" >
                    <input type="hidden" name="hcontitem" value="<%=contitem%>" >
                    <%

                        try {

                            PreparedStatement pstmt = con.prepareStatement("select item, nome, preco, quant, preco*quant as subtotal from detalhevenda, produto where detalhevenda.idproduto=produto.idproduto and idvenda=? order by item");
                            pstmt.setInt(1, idvenda);
                            ResultSet rs = pstmt.executeQuery();
                            while (rs.next()) {
                                if (rs.getRow() == 1) {
                                    out.println("<tr><th></th><th>Descrição</th><th>Preço Unit.</th><th>Quant.</th><th>Subtotal</th><th></th></tr>");
                                }
                                out.println("<tr><td>" + rs.getString("item") + "</td>"); //mostra o identificador
                                out.println("<td>" + rs.getString("nome") + "</td>"); //mostra o nome da pessoa
                                out.println("<td>" + rs.getString("preco") + "</td>"); //mostra o nome da pessoa
                                out.println("<td>" + rs.getString("quant") + "</td>"); //mostra o nome da pessoa                        
                                out.println("<td>" + String.format("%.2f", rs.getDouble("subtotal")) + "</td>"); //mostra o nome da pessoa                        
                                out.println("<td> <button type=\"submit\" name=\"excluir\" id=\"excluir\" value=\"" + rs.getString("item") + "\">Excluir</button></td></tr>");
                            }

                            out.println("<br><br>");
                            pstmt = con.prepareStatement("select sum(preco*quant) as total from detalhevenda, produto where detalhevenda.idproduto=produto.idproduto and idvenda=?");
                            pstmt.setInt(1, idvenda);
                            rs = pstmt.executeQuery();
                            if (rs.next()) {

                            }
                        } catch (SQLException err) {
                            out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                        }
                    %>

                    </table>
                    <%
                        if (idvenda > 0) {
                            try {

                                PreparedStatement pstmt = con.prepareStatement("select sum(preco*quant) as total from detalhevenda, produto where detalhevenda.idproduto=produto.idproduto and idvenda=? ");
                                pstmt.setInt(1, idvenda);
                                ResultSet rs = pstmt.executeQuery();
                                if (rs.next()) {

                                    out.println("<h3>Total: R$ " + String.format("%.2f", rs.getDouble("total")) + "</h3>");
                                }
                            } catch (SQLException err) {
                                out.println("<script>alert(\"Erro: " + err.getMessage() + "\");</script>");
                            }

                    %>

                    <input type="submit" name="botao" id="botao" value="Finalizar" />
                    <% }%>
                </form>

        </div>
    </div>
</div>

<br />
<jsp:include page="rodape.jsp"/>
