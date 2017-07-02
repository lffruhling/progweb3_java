/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.frili;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;

/**
 *
 * @author Aula
 */
@Stateless
public class CadPessoaBean implements CadPessoaBeanRemote {

    @Override
    public boolean CadastrarPessoa(String cpf, String nome, String email) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/javaee?user=javaee&password=javaee");
            PreparedStatement pstmt = con.prepareStatement("INSERT INTO pessoa (cpf, nome, email) VALUES( ?, ?, ?)");
            pstmt.setString(1, cpf);
            pstmt.setString(2, nome);
            pstmt.setString(3, email);
            pstmt.executeUpdate();
        } catch (SQLException err) {
            return false;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CadPessoaBean.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return true;
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    
}
