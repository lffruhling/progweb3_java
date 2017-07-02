/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package IFFar;

import javax.ejb.Remote;

/**
 *
 * @author Aula
 */
@Remote
public interface CadastrosRemote {

    String cadastrarPessoa(String nome, String cpf, String email, String fone);

    String alterarPessoa(String id, String nome, String cpf, String email, String fone);

    String excluirPessoa(String id);

    String listarPessoa(String id);

    String listarTodos();
    
}
