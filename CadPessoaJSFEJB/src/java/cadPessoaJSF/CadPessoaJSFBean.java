/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cadPessoaJSF;

import com.frili.CadPessoaBeanRemote;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 *
 * @author Aula
 */
@Named(value = "cadPessoaJSFBean")
@RequestScoped
public class CadPessoaJSFBean {
private String cpf;
 private String nome;
 private String email;
    /**
     * Creates a new instance of CadPessoaJSFBean
     */
    public CadPessoaJSFBean() {
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public void cadastrar() {
 InitialContext ctx = null;
 CadPessoaBeanRemote cp;
 cp = null;
 try {
 ctx = new InitialContext();// ser for aplicação local ou
 /* o codigo a seguir se for aplicação remota
 Properties p = new Properties();
 p.put("org.omg.CORBA.ORBInitialHost", "192.168.1.175");
 p.put("org.omg.CORBA.ORBInitialPort", "3700");
 ctx = new InitialContext(p); */
 } catch (NamingException ex) {
 System.out.println("Erro: " + ex);
 }
 try {
 cp = (CadPessoaBeanRemote) ctx.lookup("java:global/EJBCadPessoa/CadPessoaBean");
 } catch (NamingException ex) {
 System.out.println("Erro: " + ex);
 }
 if (cp != null && cpf.length()>1 && cp.CadastrarPessoa(cpf, nome, email)) {
 nome = "";
 cpf = "";
 email = "";
 FacesMessage msg = new FacesMessage("Cadastro ok...");
 FacesContext.getCurrentInstance().addMessage(null, msg);
 } else {
 FacesMessage msg = new FacesMessage("Erro no Cadastro.");
 FacesContext.getCurrentInstance().addMessage(null, msg);
 }
 }
    
}
