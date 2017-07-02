/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.frili;

import javax.ejb.Remote;

/**
 *
 * @author Aula
 */
@Remote
public interface CadPessoaBeanRemote {

    boolean CadastrarPessoa(String cpf, String nome, String email);
    
}
