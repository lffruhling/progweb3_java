/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WSAulaIFFar;

import IFFar.CadastrosRemote;
import javax.ejb.EJB;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

/**
 *
 * @author Aula
 */
@WebService(serviceName = "WSCadastros")
public class WSCadastros {

    @EJB
    private CadastrosRemote ejbRef;// Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Web Service Operation")

    @WebMethod(operationName = "cadastrarPessoa")
    public String cadastrarPessoa(@WebParam(name = "nome") String nome, @WebParam(name = "cpf") String cpf, @WebParam(name = "email") String email, @WebParam(name = "fone") String fone) {
        return ejbRef.cadastrarPessoa(nome, cpf, email, fone);
    }

    @WebMethod(operationName = "alterarPessoa")
    public String alterarPessoa(@WebParam(name = "id") String id, @WebParam(name = "nome") String nome, @WebParam(name = "cpf") String cpf, @WebParam(name = "email") String email, @WebParam(name = "fone") String fone) {
        return ejbRef.alterarPessoa(id, nome, cpf, email, fone);
    }

    @WebMethod(operationName = "excluirPessoa")
    public String excluirPessoa(@WebParam(name = "id") String id) {
        return ejbRef.excluirPessoa(id);
    }

    @WebMethod(operationName = "listarPessoa")
    public String listarPessoa(@WebParam(name = "id") String id) {
        return ejbRef.listarPessoa(id);
    }

    @WebMethod(operationName = "listarTodos")
    public String listarTodos() {
        return ejbRef.listarTodos();
    }
    
}
