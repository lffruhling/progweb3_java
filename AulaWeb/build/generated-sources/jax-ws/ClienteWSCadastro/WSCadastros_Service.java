
package ClienteWSCadastro;

import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceException;
import javax.xml.ws.WebServiceFeature;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.11-b150120.1832
 * Generated source version: 2.2
 * 
 */
@WebServiceClient(name = "WSCadastros", targetNamespace = "http://WSAulaIFFar/", wsdlLocation = "http://localhost:8080/AulaWeb/WSCadastros?wsdl")
public class WSCadastros_Service
    extends Service
{

    private final static URL WSCADASTROS_WSDL_LOCATION;
    private final static WebServiceException WSCADASTROS_EXCEPTION;
    private final static QName WSCADASTROS_QNAME = new QName("http://WSAulaIFFar/", "WSCadastros");

    static {
        URL url = null;
        WebServiceException e = null;
        try {
            url = new URL("http://localhost:8080/AulaWeb/WSCadastros?wsdl");
        } catch (MalformedURLException ex) {
            e = new WebServiceException(ex);
        }
        WSCADASTROS_WSDL_LOCATION = url;
        WSCADASTROS_EXCEPTION = e;
    }

    public WSCadastros_Service() {
        super(__getWsdlLocation(), WSCADASTROS_QNAME);
    }

    public WSCadastros_Service(WebServiceFeature... features) {
        super(__getWsdlLocation(), WSCADASTROS_QNAME, features);
    }

    public WSCadastros_Service(URL wsdlLocation) {
        super(wsdlLocation, WSCADASTROS_QNAME);
    }

    public WSCadastros_Service(URL wsdlLocation, WebServiceFeature... features) {
        super(wsdlLocation, WSCADASTROS_QNAME, features);
    }

    public WSCadastros_Service(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public WSCadastros_Service(URL wsdlLocation, QName serviceName, WebServiceFeature... features) {
        super(wsdlLocation, serviceName, features);
    }

    /**
     * 
     * @return
     *     returns WSCadastros
     */
    @WebEndpoint(name = "WSCadastrosPort")
    public WSCadastros getWSCadastrosPort() {
        return super.getPort(new QName("http://WSAulaIFFar/", "WSCadastrosPort"), WSCadastros.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns WSCadastros
     */
    @WebEndpoint(name = "WSCadastrosPort")
    public WSCadastros getWSCadastrosPort(WebServiceFeature... features) {
        return super.getPort(new QName("http://WSAulaIFFar/", "WSCadastrosPort"), WSCadastros.class, features);
    }

    private static URL __getWsdlLocation() {
        if (WSCADASTROS_EXCEPTION!= null) {
            throw WSCADASTROS_EXCEPTION;
        }
        return WSCADASTROS_WSDL_LOCATION;
    }

}
