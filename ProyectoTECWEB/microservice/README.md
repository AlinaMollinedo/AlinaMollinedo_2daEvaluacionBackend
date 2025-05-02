Microservicio WSDL (SOAP) para obtener estadísticas de documentos que contengan una palabra clave

Descripción General: Este proyecto implementa un microservicio independiente utilizando un servicio web WSDL que consume la API REST del sistema MIGA que obtiene documentos que contengan una palabra clave determinada en su descripción o relevancia. 

El microservicio se encarga de:
• Obtener la cantidad de documentos que cumplen la condición.
• Obtener la cantidad de documentos por año.
• Obtener la cantidad de documentos por jerarquía.
• Obtener la cantidad de documentos por año.
• Obtener la cantidad de documentos por vigencia.

Tecnologías Utilizadas
• Node.js
• Express.js
• WSDL (SOAP)
• Axios para consumir la API REST externa

Instalación
• Clonar el repositorio: https://github.com/AlinaMollinedo/AlinaMollinedo_2daEvaluacionBackend.git
• Instalar dependencias: npm install express soap axios.
• Entrar a la carpeta ProyectoTECWEB/Back y levantar el servidor para acceder a la API REST:
cd ProyectoTECWEB/Back
node server.js
• Entrar a la carpeta ProyectoTECWEB/microservice y levantar el servidor para acceder a la API REST:
cd ProyectoTECWEB/microservice
node wsdl-server.js

Uso
Para poder utilizar el servicio en Postman, configurar de la siguiente manera:
• Seleccionar la opción POST.
• En la URL, ingresar la dirección http://localhost:3001/wsdl
• Ir a la pestaña "Headers" y colocar:
    Content-Type → text/xml; charset=utf-8
    SOAPAction → "getSearchHistoryStats"
• En la pestaña "Body", seleccionar la opción "raw" y utilizar el siguiente XML para realizar la consula. Colocar en <keyword>palabraClave</keyword> la palabra clave a buscar en los documentos:

<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
    xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:tns="http://www.example.com/documents">

    <SOAP-ENV:Header/>

    <SOAP-ENV:Body>
        <tns:getSearchHistoryStats>
            <keyword>alimentacion</keyword>
        </tns:getSearchHistoryStats>
    </SOAP-ENV:Body>
</SOAP-ENV:Envelope>

• Ejecutar la solicitud. La respuesta esperada debería verse de la siguiente manera:

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"  xmlns:tns="http://www.example.com/documents">
    <soap:Body>
        <tns:getDocumentStatsResponse>
            <total>6</total>
            <by_anio>
                <2009>1</2009>
                <2021>1</2021>
                <2024>4</2024>
            </by_anio>
            <by_jerarquia>
                <Suprema>1</Suprema>
                <Media alta>5</Media alta>
            </by_jerarquia>
            <by_vigente>
                <true>6</true>
                <false>0</false>
            </by_vigente>
        </tns:getDocumentStatsResponse>
    </soap:Body>
</soap:Envelope>

Estructura del Proyecto
├───Back
│ ├───controllers
│ ├───middleware
│ ├───models
│ ├───node_modules
│ ├───routes
│ └───utils
└───microservice
└───README.md