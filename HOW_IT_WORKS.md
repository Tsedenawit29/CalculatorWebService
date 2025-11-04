# 🎯 How Your Calculator SOAP Service Works

## 📦 What You Have (Clean Project)

```
calculator app/
├── src/main/java/com/calculator/
│   ├── CalcWebService.java      ← Calculator operations (add, subtract, etc.)
│   └── ServicePublisher.java    ← Starts the server
├── pom.xml                       ← Maven configuration
├── start-soap-service.sh         ← Start script
├── test-soap-service.sh          ← Test script
├── README.md                     ← Quick reference
├── JAVA_SOAP_GUIDE.md           ← Detailed guide
└── HOW_IT_WORKS.md              ← This file
```

**Removed unused files:**
- ❌ CalcService.java (duplicate)
- ❌ CalculatorServer.java (duplicate)
- ❌ CalculatorService.java (duplicate)
- ❌ CalculatorServlet.java (not needed)
- ❌ SimpleSOAPServer.java (not needed)
- ❌ calculator-web.html (different calculator)
- ❌ Other duplicate documentation files

---

## 🔄 How It Works - Simple Explanation

### Step-by-Step Flow:

```
1. You run: ./start-soap-service.sh
   ↓
2. ServicePublisher.main() starts
   ↓
3. Creates HTTP server on port 9090
   ↓
4. Publishes CalcWebService at http://localhost:9090/calculator
   ↓
5. Server is running and waiting for SOAP requests
   ↓
6. Client sends SOAP XML request (e.g., add 10 + 5)
   ↓
7. CalcWebService.add() method is called
   ↓
8. Returns result: 15.0
   ↓
9. Server sends SOAP XML response back to client
```

---

## 💡 What Each Component Does

### 1. CalcWebService.java (The Calculator)

```java
@WebService(serviceName = "CalculatorService")
public class CalcWebService {
    
    @WebMethod(operationName = "add")
    public double add(double a, double b) {
        return a + b;
    }
}
```

**What it does:**
- `@WebService` tells JAX-WS: "This is a SOAP service"
- `@WebMethod` tells JAX-WS: "This method is a SOAP operation"
- Contains 4 methods: add, subtract, multiply, divide
- Each method takes 2 numbers and returns 1 number

**Magic happening:**
- JAX-WS automatically converts Java methods into SOAP operations
- Handles XML conversion (you don't write XML!)
- Generates WSDL automatically

---

### 2. ServicePublisher.java (The Server)

```java
public class ServicePublisher {
    public static void main(String[] args) {
        String url = "http://localhost:9090/calculator";
        Endpoint.publish(url, new CalcWebService());
        System.out.println("Service is running!");
    }
}
```

**What it does:**
- Creates an HTTP server on port 9090
- Takes CalcWebService and makes it available via SOAP
- One line does it all: `Endpoint.publish()`

**Magic happening:**
- JAX-WS creates HTTP server automatically
- Handles all SOAP protocol details
- Generates WSDL at `/calculator?wsdl`

---

### 3. pom.xml (Dependencies)

```xml
<dependency>
    <groupId>com.sun.xml.ws</groupId>
    <artifactId>jaxws-rt</artifactId>
    <version>2.3.3</version>
</dependency>
```

**What it does:**
- Tells Maven to download JAX-WS library
- JAX-WS contains all SOAP magic
- Includes XML parsers, HTTP server, WSDL generator

---

## 🔍 What Actually Happens

### When You Start the Service:

```bash
./start-soap-service.sh
```

**Behind the scenes:**
1. ✅ Maven compiles Java code → `.class` files
2. ✅ Gets all JAR dependencies from Maven repository
3. ✅ Runs Java with special arguments (--add-opens for Java 11+)
4. ✅ ServicePublisher.main() executes
5. ✅ HTTP server starts on port 9090
6. ✅ CalcWebService is registered
7. ✅ WSDL is auto-generated
8. ✅ Server waits for requests

### When Client Calls add(10, 5):

**1. Client sends SOAP XML:**
```xml
<soapenv:Envelope>
  <soapenv:Body>
    <cal:add>
      <a>10</a>
      <b>5</b>
    </cal:add>
  </soapenv:Body>
</soapenv:Envelope>
```

**2. JAX-WS receives XML:**
- Parses the XML
- Extracts: operation=add, a=10, b=5

**3. JAX-WS calls your Java method:**
```java
CalcWebService service = new CalcWebService();
double result = service.add(10, 5);  // returns 15.0
```

**4. JAX-WS creates response XML:**
```xml
<soap:Envelope>
  <soap:Body>
    <return>15.0</return>
  </soap:Body>
</soap:Envelope>
```

**5. Client receives result!**

---

## 🎓 Key Concepts

### SOAP (Simple Object Access Protocol)
- Protocol for calling methods over HTTP
- Uses XML for messages
- Language-independent (Java service, Python client works!)

### WSDL (Web Services Description Language)
- XML document describing your service
- Lists all operations (add, subtract, etc.)
- Auto-generated at `http://localhost:9090/calculator?wsdl`
- Clients use it to know how to call your service

### JAX-WS (Java API for XML Web Services)
- Java framework for SOAP services
- Does the hard work for you:
  - Java ↔ XML conversion
  - HTTP server
  - WSDL generation
  - Request routing

---

## 🚀 Quick Commands

### Start Service:
```bash
./start-soap-service.sh
```

### Test It:
```bash
./test-soap-service.sh
```

### View WSDL:
```bash
curl http://localhost:9090/calculator?wsdl
```

### Manual Test (Add 10 + 5):
```bash
curl -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Body>
           <cal:add><a>10</a><b>5</b></cal:add>
         </soapenv:Body>
       </soapenv:Envelope>'
```

---

## ✅ Summary

**What you created:**
- ✅ A working SOAP web service
- ✅ Clean, minimal code (2 Java files!)
- ✅ Professional API with WSDL
- ✅ Test scripts
- ✅ Documentation

**How it works:**
1. Java annotations (@WebService, @WebMethod) mark your code
2. JAX-WS library handles all SOAP complexity
3. ServicePublisher starts HTTP server
4. Clients send XML requests
5. Your Java methods process them
6. JAX-WS sends XML responses back

**The beauty:**
- You write simple Java code
- JAX-WS does all the SOAP magic
- No manual XML writing needed!
