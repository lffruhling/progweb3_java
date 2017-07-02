
package clienteWS;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the clienteWS package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _CadastrarPessoa_QNAME = new QName("http://WSAulaIFFar/", "cadastrarPessoa");
    private final static QName _CadastrarPessoaResponse_QNAME = new QName("http://WSAulaIFFar/", "cadastrarPessoaResponse");
    private final static QName _ExcluirPessoa_QNAME = new QName("http://WSAulaIFFar/", "excluirPessoa");
    private final static QName _ExcluirPessoaResponse_QNAME = new QName("http://WSAulaIFFar/", "excluirPessoaResponse");
    private final static QName _ListarTodosResponse_QNAME = new QName("http://WSAulaIFFar/", "listarTodosResponse");
    private final static QName _ListarPessoa_QNAME = new QName("http://WSAulaIFFar/", "listarPessoa");
    private final static QName _ListarTodos_QNAME = new QName("http://WSAulaIFFar/", "listarTodos");
    private final static QName _AlterarPessoa_QNAME = new QName("http://WSAulaIFFar/", "alterarPessoa");
    private final static QName _ListarPessoaResponse_QNAME = new QName("http://WSAulaIFFar/", "listarPessoaResponse");
    private final static QName _AlterarPessoaResponse_QNAME = new QName("http://WSAulaIFFar/", "alterarPessoaResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: clienteWS
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link AlterarPessoaResponse }
     * 
     */
    public AlterarPessoaResponse createAlterarPessoaResponse() {
        return new AlterarPessoaResponse();
    }

    /**
     * Create an instance of {@link AlterarPessoa }
     * 
     */
    public AlterarPessoa createAlterarPessoa() {
        return new AlterarPessoa();
    }

    /**
     * Create an instance of {@link ListarPessoaResponse }
     * 
     */
    public ListarPessoaResponse createListarPessoaResponse() {
        return new ListarPessoaResponse();
    }

    /**
     * Create an instance of {@link ListarPessoa }
     * 
     */
    public ListarPessoa createListarPessoa() {
        return new ListarPessoa();
    }

    /**
     * Create an instance of {@link ListarTodos }
     * 
     */
    public ListarTodos createListarTodos() {
        return new ListarTodos();
    }

    /**
     * Create an instance of {@link ExcluirPessoaResponse }
     * 
     */
    public ExcluirPessoaResponse createExcluirPessoaResponse() {
        return new ExcluirPessoaResponse();
    }

    /**
     * Create an instance of {@link ListarTodosResponse }
     * 
     */
    public ListarTodosResponse createListarTodosResponse() {
        return new ListarTodosResponse();
    }

    /**
     * Create an instance of {@link ExcluirPessoa }
     * 
     */
    public ExcluirPessoa createExcluirPessoa() {
        return new ExcluirPessoa();
    }

    /**
     * Create an instance of {@link CadastrarPessoa }
     * 
     */
    public CadastrarPessoa createCadastrarPessoa() {
        return new CadastrarPessoa();
    }

    /**
     * Create an instance of {@link CadastrarPessoaResponse }
     * 
     */
    public CadastrarPessoaResponse createCadastrarPessoaResponse() {
        return new CadastrarPessoaResponse();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CadastrarPessoa }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "cadastrarPessoa")
    public JAXBElement<CadastrarPessoa> createCadastrarPessoa(CadastrarPessoa value) {
        return new JAXBElement<CadastrarPessoa>(_CadastrarPessoa_QNAME, CadastrarPessoa.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CadastrarPessoaResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "cadastrarPessoaResponse")
    public JAXBElement<CadastrarPessoaResponse> createCadastrarPessoaResponse(CadastrarPessoaResponse value) {
        return new JAXBElement<CadastrarPessoaResponse>(_CadastrarPessoaResponse_QNAME, CadastrarPessoaResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ExcluirPessoa }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "excluirPessoa")
    public JAXBElement<ExcluirPessoa> createExcluirPessoa(ExcluirPessoa value) {
        return new JAXBElement<ExcluirPessoa>(_ExcluirPessoa_QNAME, ExcluirPessoa.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ExcluirPessoaResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "excluirPessoaResponse")
    public JAXBElement<ExcluirPessoaResponse> createExcluirPessoaResponse(ExcluirPessoaResponse value) {
        return new JAXBElement<ExcluirPessoaResponse>(_ExcluirPessoaResponse_QNAME, ExcluirPessoaResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ListarTodosResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "listarTodosResponse")
    public JAXBElement<ListarTodosResponse> createListarTodosResponse(ListarTodosResponse value) {
        return new JAXBElement<ListarTodosResponse>(_ListarTodosResponse_QNAME, ListarTodosResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ListarPessoa }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "listarPessoa")
    public JAXBElement<ListarPessoa> createListarPessoa(ListarPessoa value) {
        return new JAXBElement<ListarPessoa>(_ListarPessoa_QNAME, ListarPessoa.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ListarTodos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "listarTodos")
    public JAXBElement<ListarTodos> createListarTodos(ListarTodos value) {
        return new JAXBElement<ListarTodos>(_ListarTodos_QNAME, ListarTodos.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AlterarPessoa }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "alterarPessoa")
    public JAXBElement<AlterarPessoa> createAlterarPessoa(AlterarPessoa value) {
        return new JAXBElement<AlterarPessoa>(_AlterarPessoa_QNAME, AlterarPessoa.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ListarPessoaResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "listarPessoaResponse")
    public JAXBElement<ListarPessoaResponse> createListarPessoaResponse(ListarPessoaResponse value) {
        return new JAXBElement<ListarPessoaResponse>(_ListarPessoaResponse_QNAME, ListarPessoaResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AlterarPessoaResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://WSAulaIFFar/", name = "alterarPessoaResponse")
    public JAXBElement<AlterarPessoaResponse> createAlterarPessoaResponse(AlterarPessoaResponse value) {
        return new JAXBElement<AlterarPessoaResponse>(_AlterarPessoaResponse_QNAME, AlterarPessoaResponse.class, null, value);
    }

}
