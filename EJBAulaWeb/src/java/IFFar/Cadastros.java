/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package IFFar;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

/**
 *
 * @author Aula
 */
@Stateless
public class Cadastros implements CadastrosRemote {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    @Override
    public String cadastrarPessoa(String nome, String cpf, String email, String fone) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            PreparedStatement pstmt = con.prepareStatement(" INSERT INTO pessoa (nome, cpf,email, fone) VALUES( ?, ?, ?, ?)");
            pstmt.setString(1, nome);
            pstmt.setString(2, cpf);
            pstmt.setString(3, email);
            pstmt.setString(4, fone);
            pstmt.executeUpdate();
        } catch (SQLException err) {
            String r = err.getMessage();
            String s1 = "" + (char) 10;
            String s2 = "" + (char) 13;
            r = r.replaceAll(s1, " ");
            r = r.replaceAll(s2, " ");
            return "ERRO1: " + r;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Cadastros.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "OK";
    }

    @Override
    public String alterarPessoa(String id, String nome, String cpf, String email, String fone) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            PreparedStatement pstmt = con.prepareStatement("update pessoa set nome=?, cpf=?, email=?, fone=? where id = ? ");
            pstmt.setString(1, nome);
            pstmt.setString(2, cpf);
            pstmt.setString(3, email);
            pstmt.setString(4, fone);
            pstmt.setString(5, id);
            System.out.println("Alterando: " + id + nome);
            pstmt.executeUpdate();
        } catch (SQLException err) {
            String r = err.getMessage();
            String s1 = "" + (char) 10;
            String s2 = "" + (char) 13;
            r = r.replaceAll(s1, " ");
            r = r.replaceAll(s2, " ");
            return "ERRO: " + r;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Cadastros.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "OK";
    }

    @Override
    public String excluirPessoa(String id) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            PreparedStatement pstmt = con.prepareStatement(" delete from pessoa where id = ?");
            pstmt.setString(1, id);
            pstmt.executeUpdate();
        } catch (SQLException err) {
            String r = err.getMessage();
            String s1 = "" + (char) 10;
            String s2 = "" + (char) 13;
            r = r.replaceAll(s1, " ");
            r = r.replaceAll(s2, " ");
            return "ERRO: " + r;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Cadastros.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "OK";
    }

    @Override
    public String listarPessoa(String id) {
        JSONObject obj = new JSONObject();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            PreparedStatement pstmt = con.prepareStatement("select * from pessoa where id = ? or cpf = ?");
            pstmt.setString(1, id);
            pstmt.setString(2, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                obj.put("nome", rs.getString("nome"));
                obj.put("cpf", rs.getString("cpf"));
                obj.put("email", rs.getString("email"));
                obj.put("fone", rs.getString("fone"));
            }
        } catch (SQLException err) {
            return ("Erro");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Cadastros.class.getName()).log(Level.SEVERE, null, ex);
        }
        return obj.toJSONString();
    }

    @Override
    public String listarTodos() {
        List l1 = new LinkedList();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/iffar?user=iffar&password=iffar");
            PreparedStatement pstmt = con.prepareStatement("select * from pessoa order by nome");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Map m1 = new LinkedHashMap();
                m1.put("id", rs.getString("id"));
                m1.put("nome", rs.getString("nome"));
                l1.add(m1);
            }
        } catch (SQLException err) {
            return ("Erro");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Cadastros.class.getName()).log(Level.SEVERE, null, ex);
        }
        String jsonString;
        jsonString = JSONValue.toJSONString(l1);
        return jsonString;
    }

}
