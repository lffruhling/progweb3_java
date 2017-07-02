<jsp:include page="cabecalho.jsp"/>
<div id="site_content"> 
    <div class="content">        
            <form class="contato" action="logar.jsp" method="POST">
                <h1>Login</h1>
                <fieldset>
                    <label for="login">
                        Login:
                    </label>
                    <input type="text" name="login" id="login" value="" required autofocus>
                    <label for="password">Senha:</label>
                    <input type="password" name="password" id="password" required value="">
                    <input type="submit" name="go" value="Enviar">                            
                </fieldset>
            </form>        
    </div>
</div>   

<jsp:include page="rodape.jsp"/>