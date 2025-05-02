const express = require("express");
const soap = require("soap");
const axios = require("axios");
const app = express();
const port = 3001;

const service = {
    SearchHistoryService: {
        SearchHistoryPort: {
            getSearchHistoryStats: async function (args, callback) {
                try {
                    const keyword = args.keyword;
                    const response = await axios.get(`http://localhost:3000/api/historial-busqueda?palabra=${encodeURIComponent(keyword)}`);
                    const docs = response.data;
                    const result = {
                        total: 0,
                        by_anio: {},
                        by_jerarquia: {},
                        by_vigente: {
                            true: 0,
                            false: 0
                        }
                    };
                    if (docs.length === 0) {
                        return callback(null, result);
                    }

                    result.total = docs.length;
                    for (const doc of docs) {
                        // Agregar por año
                        if (!result.by_anio[doc.anio]) {
                          result.by_anio[doc.anio] = 0;
                        }
                        result.by_anio[doc.anio]++;
                    
                        // Agreagar por jerarquía
                        if (!result.by_jerarquia[doc.jerarquia]) {
                          result.by_jerarquia[doc.jerarquia] = 0;
                        }
                        result.by_jerarquia[doc.jerarquia]++;
                    
                        // Agregar por vigente (true/false)
                        const vigenteKey = doc.vigente === 1 ? "true" : "false";
                        result.by_vigente[vigenteKey]++;
                      }
                    
                    return callback(null, result);
                } catch (error) {
                    console.error("Error al obtener los resultados de búsqueda:", error);
                    return callback(error);
                }
            },
        },
    },
};


const xml = `
<?xml version="1.0" encoding="UTF-8"?>
<definitions name="SearchHistoryService"
             targetNamespace="http://www.example.com/documents"
             xmlns="http://schemas.xmlsoap.org/wsdl/"
             xmlns:tns="http://www.example.com/documents"
             xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
             xmlns:xsd="http://www.w3.org/2001/XMLSchema">

  <types>
    <xsd:schema targetNamespace="http://www.example.com/documents">

      <xsd:element name="getSearchHistoryStats">
        <xsd:complexType>
          <xsd:sequence>
            <xsd:element name="keyword" type="xsd:string"/>
          </xsd:sequence>
        </xsd:complexType>
      </xsd:element>

    <xsd:element name="getDocumentStatsResponse">
      <xsd:complexType>
        <xsd:sequence>
          <xsd:element name="total" type="xsd:int"/>
          <xsd:element name="by_anio" type="tns:StatEntryList"/>
          <xsd:element name="by_jerarquia" type="tns:StatEntryList"/>
          <xsd:element name="by_vigente" type="tns:StatEntryList"/>
        </xsd:sequence>
      </xsd:complexType>
    </xsd:element>

    <xsd:complexType name="StatEntryList">
      <xsd:sequence>
        <xsd:element name="entry" type="tns:StatEntry" minOccurs="0" maxOccurs="unbounded"/>
      </xsd:sequence>
    </xsd:complexType>

    <xsd:complexType name="StatEntry">
      <xsd:sequence>
        <xsd:element name="key" type="xsd:string"/>
        <xsd:element name="value" type="xsd:int"/>
      </xsd:sequence>
    </xsd:complexType>

    </xsd:schema>
  </types>

  <message name="getSearchHistoryStatsRequest">
    <part name="parameters" element="tns:getSearchHistoryStats"/>
  </message>

  <message name="getSearchHistoryStatsResponse">
    <part name="parameters" element="tns:getDocumentStatsResponse"/>
  </message>

  <portType name="SearchHistoryPort">
    <operation name="getSearchHistoryStats">
      <input message="tns:getSearchHistoryStatsRequest"/>
      <output message="tns:getSearchHistoryStatsResponse"/>
    </operation>
  </portType>

  <binding name="SearchHistoryBinding" type="tns:SearchHistoryPort">
    <soap:binding style="document" transport="http://schemas.xmlsoap.org/soap/http"/>
    <operation name="getSearchHistoryStats">
      <soap:operation soapAction="getSearchHistoryStats"/>
      <input>
        <soap:body use="literal"/>
      </input>
      <output>
        <soap:body use="literal"/>
      </output>
    </operation>
  </binding>

  <service name="SearchHistoryService">
    <port name="SearchHistoryPort" binding="tns:SearchHistoryBinding">
      <soap:address location="http://localhost:${port}/wsdl"/>
    </port>
  </service>
</definitions>
`;

app.use(express.json());
app.listen(port, () => {
 console.log(`Servicio WSDL corriendo en http://localhost:${port}/wsdl`);
});
soap.listen(app, "/wsdl", service, xml);