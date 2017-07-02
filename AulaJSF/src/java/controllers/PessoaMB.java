/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.inject.Named;
import javax.faces.view.ViewScoped;
import models.Pessoa;
import java.sql.*;

/**
 *
 * @author Aula
 */
@Named(value = "pessoaMB")
@ViewScoped
public class PessoaMB implements Serializable {

    private Pessoa pessoa = new Pessoa();
    private List<Pessoa> pessoaLista = new ArrayList<Pessoa>();

    /**
     * Creates a new instance of PessoaMB
     */
    public PessoaMB() {
    }

    public Pessoa getPessoa() {
        return pessoa;
    }

    public void setPessoa(Pessoa pessoa) {
        this.pessoa = pessoa;
    }

    public List<Pessoa> getPessoaLista() {
        pessoaLista = new ArrayList<Pessoa>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con
                    = DriverManager.getConnection("jdbc:mysql://localhost/javaee?user=javaee&password=javaee");
            PreparedStatement pstmt = con.prepareStatement("select * from pessoa order by nome");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Pessoa p = new Pessoa();
                p.setCpf(rs.getString("cpf"));
                p.setNome(rs.getString("nome"));
                p.setEmail(rs.getString("email"));
                pessoaLista.add(p);
            }
        } catch (SQLException | ClassNotFoundException err) {
            System.out.println("Erro listando pessoa.");
        }
        return pessoaLista;
    }

    public void setPessoaLista(List<Pessoa> pessoaLista) {
        this.pessoaLista = pessoaLista;
    }

    public void salvarPessoa() {

        //adicionando pessoas a lista
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con
                    = DriverManager.getConnection("jdbc:mysql://localhost/javaee?user=javaee&password=javaee");
            PreparedStatement pstmt = con.prepareStatement(" INSERT INTO pessoa (cpf, nome, email ) VALUES( ?,  ?,  ?)");
            pstmt.setString(1, pessoa.getCpf());
            pstmt.setString(2, pessoa.getNome());
            pstmt.setString(3, pessoa.getEmail());
            pstmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException err) {
            System.out.println("Erro inserindo pessoa." + err.getMessage());
        }
        pessoa = new Pessoa();

        //instanciado uma nova para ser cadastrada
        pessoa = new Pessoa();
    }
}
