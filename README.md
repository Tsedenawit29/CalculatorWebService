# Calculator SOAP Web Service ✅

A clean, working SOAP web service calculator built with JAX-WS (Java API for XML Web Services).

---

## ✨ Features

Nine mathematical operations via SOAP protocol:

**Basic Operations:**
- **Add** - Addition of two numbers
- **Subtract** - Subtraction of two numbers
- **Multiply** - Multiplication of two numbers
- **Divide** - Division with zero-check protection

**Advanced Operations:**
- **Power** - Raise a number to an exponent (a^b)
- **Square Root** - Calculate square root with negative number check
- **Percentage** - Calculate percentage of a number
- **Modulo** - Get remainder of division
- **Absolute** - Get absolute value of a number

---

## 📁 Project Structure

```
calculator app/
├── src/main/java/com/calculator/
│   ├── CalcWebService.java       # SOAP service (calculator operations)
│   ├── ServicePublisher.java     # Server startup class
│   └── CORSFilter.java           # CORS support (optional)
├── calculator.html                # Web calculator interface
├── cors-proxy.py                  # CORS proxy server
├── pom.xml                        # Maven dependencies & config
├── start-soap-service.sh          # Start SOAP service
├── test-soap-service.sh           # Test all operations
└── README.md                      # This file
```

**Core: Only 2 Java files (67 lines of code)!**

---

## 🚀 How to Run

### Option 1: Web Calculator (Recommended)

The easiest way to use the calculator is through the web interface!

#### 1. Start the SOAP Service
```bash
./start-soap-service.sh
```

#### 2. Start the Web Calculator
In a **new terminal window**:
```bash
python3 cors-proxy.py
```

#### 3. Open in Browser
Open http://localhost:8000/calculator.html

**Features:**
- ✅ Sleek black & white design (like iPhone calculator)
- ✅ Circular buttons with number pad (0-9)
- ✅ All 9 operations accessible via buttons
- ✅ Real-time SOAP communication
- ✅ Connection status indicator
- ✅ Keyboard support (0-9, Enter, Escape)
- ✅ Professional calculator layout

---

### Option 2: Command Line Testing

#### 1. Start the Service
```bash
./start-soap-service.sh
```

**Output:**
```
🚀 Starting Calculator SOAP Web Service...
📍 URL: http://localhost:9090/calculator
✅ Calculator Service is running!
📄 WSDL: http://localhost:9090/calculator?wsdl
```

#### 2. Test It
```bash
./test-soap-service.sh
```

**Output:**
```
Test 1: Add 10 + 5              → 15.0 ✅
Test 2: Subtract 20 - 8         → 12.0 ✅
Test 3: Multiply 6 × 7          → 42.0 ✅
Test 4: Divide 100 ÷ 4          → 25.0 ✅
Test 5: Power 2^8               → 256.0 ✅
Test 6: Square Root of 144      → 12.0 ✅
Test 7: 20% of 500              → 100.0 ✅
Test 8: Modulo 17 % 5           → 2.0 ✅
Test 9: Absolute value of -42   → 42.0 ✅
✅ All tests completed!
```

#### 3. View WSDL
```bash
curl http://localhost:9090/calculator?wsdl
```
Or open in browser: http://localhost:9090/calculator?wsdl

### Manual Build & Run

If you want to run manually without scripts:

```bash
# 1. Compile the code
mvn clean compile

# 2. Generate classpath
mvn dependency:build-classpath -Dmdep.outputFile=classpath.txt

# 3. Run with JVM arguments (needed for Java 11+)
java \
  --add-opens java.base/java.lang.reflect=ALL-UNNAMED \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/jdk.internal.misc=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED \
  --add-opens java.base/sun.nio.ch=ALL-UNNAMED \
  -cp "target/classes:$(cat classpath.txt)" \
  com.calculator.ServicePublisher
```

**Why the `--add-opens` arguments?**  
Java 9+ introduced a module system that restricts access to internal JDK classes. JAX-WS needs these for SOAP processing.

---

## 🎯 How It Works

### Architecture Overview

```
┌─────────────────┐
│     CLIENT      │  (Browser, SoapUI, curl, Python, .NET, etc.)
└────────┬────────┘
         │ Sends SOAP XML Request
         │ <cal:add><a>10</a><b>5</b></cal:add>
         ↓
┌─────────────────────────────────┐
│   HTTP Server (Port 9090)       │
│   Created by JAX-WS Library     │
└────────┬────────────────────────┘
         │ Routes request to
         ↓
┌─────────────────────────────────┐
│   ServicePublisher.java         │
│   Endpoint.publish(...)         │
└────────┬────────────────────────┘
         │ Invokes
         ↓
┌─────────────────────────────────┐
│   CalcWebService.java           │
│   @WebMethod                    │
│   public double add(a, b) {     │
│       return a + b;  // 15      │
│   }                             │
└────────┬────────────────────────┘
         │ Returns 15.0
         ↓
┌─────────────────────────────────┐
│   JAX-WS Converts to XML        │
│   <return>15.0</return>         │
└────────┬────────────────────────┘
         │ Sends SOAP Response
         ↓
┌─────────────────┐
│     CLIENT      │  Receives: 15.0
└─────────────────┘
```

### Step-by-Step Flow

1. **You run:** `./start-soap-service.sh`
2. **ServicePublisher** starts and creates HTTP server on port 9090
3. **CalcWebService** is published at `http://localhost:9090/calculator`
4. **Server waits** for SOAP requests
5. **Client sends** SOAP XML request (e.g., add 10 + 5)
6. **CalcWebService.add()** method is called with a=10, b=5
7. **Method returns** 15.0
8. **JAX-WS converts** result to SOAP XML response
9. **Client receives** `<return>15.0</return>`

### What Each File Does

#### CalcWebService.java (33 lines)
The calculator operations.

```java
@WebService(serviceName = "CalculatorService")  // ← Makes it a SOAP service
public class CalcWebService {
    
    @WebMethod(operationName = "add")           // ← Exposes as SOAP operation
    public double add(@WebParam(name = "a") double a, 
                      @WebParam(name = "b") double b) {
        return a + b;                           // ← Does the calculation
    }
    
    @WebMethod(operationName = "subtract")
    public double subtract(double a, double b) {
        return a - b;
    }
    
    @WebMethod(operationName = "multiply")
    public double multiply(double a, double b) {
        return a * b;
    }
    
    @WebMethod(operationName = "divide")
    public double divide(double a, double b) {
        if (b == 0) {
            throw new IllegalArgumentException("ERROR: Cannot divide by zero");
        }
        return a / b;
    }
}
```

**Key Points:**
- `@WebService` tells JAX-WS: "This is a SOAP service"
- `@WebMethod` tells JAX-WS: "Expose this method as a SOAP operation"
- `@WebParam` names the parameters in WSDL
- JAX-WS handles all XML conversion automatically!

#### ServicePublisher.java (34 lines)
Starts the server.

```java
public class ServicePublisher {
    public static void main(String[] args) {
        String url = "http://localhost:9090/calculator";
        
        System.out.println("🚀 Starting Calculator SOAP Web Service...");
        
        try {
            Endpoint.publish(url, new CalcWebService());  // ← One line starts it all!
            
            System.out.println("✅ Calculator Service is running!");
            System.out.println("📄 WSDL: " + url + "?wsdl");
            System.out.println("\n⏹️  Press Ctrl+C to stop the service.");
        } catch (Exception e) {
            System.err.println("❌ Failed to start service: " + e.getMessage());
        }
    }
}
```

**Key Points:**
- `Endpoint.publish()` creates HTTP server, publishes service, generates WSDL
- One line does everything!
- JAX-WS handles all SOAP protocol details

#### pom.xml (115 lines)
Maven configuration and dependencies.

```xml
<dependencies>
    <!-- JAX-WS Annotations -->
    <dependency>
        <groupId>javax.jws</groupId>
        <artifactId>javax.jws-api</artifactId>
        <version>1.1</version>
    </dependency>
    
    <!-- JAX-WS Runtime (SOAP library) -->
    <dependency>
        <groupId>com.sun.xml.ws</groupId>
        <artifactId>jaxws-rt</artifactId>
        <version>2.3.3</version>
    </dependency>
</dependencies>
```

**Key Points:**
- Maven downloads all required libraries
- JAX-WS library contains HTTP server, XML parsers, WSDL generator

### The Magic of JAX-WS

You write simple Java code, and JAX-WS automatically:
- ✅ Converts Java methods to SOAP operations
- ✅ Converts Java types ↔ XML
- ✅ Creates HTTP server
- ✅ Generates WSDL
- ✅ Handles SOAP protocol
- ✅ Routes requests to methods

**You focus on business logic, JAX-WS handles everything else!**

---

## 📖 API Operations

### Basic Operations

| Operation | Parameters | Returns | Example |
|-----------|------------|---------|---------|
| `add(a, b)` | double a, double b | double | 10 + 5 = 15.0 |
| `subtract(a, b)` | double a, double b | double | 20 - 8 = 12.0 |
| `multiply(a, b)` | double a, double b | double | 6 × 7 = 42.0 |
| `divide(a, b)` | double a, double b | double | 100 ÷ 4 = 25.0 |

### Advanced Operations

| Operation | Parameters | Returns | Example |
|-----------|------------|---------|---------|
| `power(base, exponent)` | double base, double exponent | double | 2^8 = 256.0 |
| `squareRoot(number)` | double number | double | √144 = 12.0 |
| `percentage(number, percent)` | double number, double percent | double | 20% of 500 = 100.0 |
| `modulo(a, b)` | double a, double b | double | 17 % 5 = 2.0 |
| `absolute(number)` | double number | double | |-42| = 42.0 |

**Error Handling:** 
- Division/Modulo by zero throws `IllegalArgumentException`
- Square root of negative number throws `IllegalArgumentException`

### SOAP Request Example

To call `add(10, 5)`:

```xml
POST http://localhost:9090/calculator
Content-Type: text/xml

<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:cal="http://calculator.com/">
  <soapenv:Header/>
  <soapenv:Body>
    <cal:add>
      <a>10</a>
      <b>5</b>
    </cal:add>
  </soapenv:Body>
</soapenv:Envelope>
```

**Response:**
```xml
<?xml version="1.0" ?>
<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
  <S:Body>
    <ns2:addResponse xmlns:ns2="http://calculator.com/">
      <return>15.0</return>
    </ns2:addResponse>
  </S:Body>
</S:Envelope>
```

### Using curl

**Basic Operation Example (Add):**
```bash
curl -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Body>
           <cal:add><a>10</a><b>5</b></cal:add>
         </soapenv:Body>
       </soapenv:Envelope>'
```

**Advanced Operation Example (Power - 2^8):**
```bash
curl -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Body>
           <cal:power><base>2</base><exponent>8</exponent></cal:power>
         </soapenv:Body>
       </soapenv:Envelope>'
```

**Result:** `<return>256.0</return>`

---

## 🔧 Technologies Used

| Technology | Purpose | What It Does |
|-----------|---------|--------------|
| **Java 11+** | Programming Language | Runs the code |
| **JAX-WS 2.3.3** | SOAP Framework | Handles all SOAP magic (XML, HTTP, WSDL) |
| **Maven** | Build Tool | Downloads libraries, compiles code |
| **SOAP** | Protocol | XML-based web service communication |
| **HTTP** | Transport | Carries SOAP messages over the network |

---

## 🛠️ Troubleshooting

### Port Already in Use

If you get "Address already in use":

```bash
# Find the process
ps aux | grep ServicePublisher

# Kill it (replace PID with actual process ID)
kill <PID>

# Wait and restart
sleep 2
./start-soap-service.sh
```

### Module Access Errors

If you get `InaccessibleObjectException`, make sure you use the `--add-opens` arguments:

```bash
java --add-opens java.base/java.lang.reflect=ALL-UNNAMED \
     --add-opens java.base/java.util=ALL-UNNAMED \
     --add-opens java.base/jdk.internal.misc=ALL-UNNAMED \
     ...
```

The `start-soap-service.sh` script includes these automatically.

### Build Failures

```bash
# Clean and rebuild
mvn clean compile

# Check Maven version (need 3.6+)
mvn --version

# Check Java version (need 11+)
java --version
```

---

## 📚 Key Concepts

### SOAP (Simple Object Access Protocol)
- Protocol for calling methods over HTTP
- Uses XML for messages
- Language-independent (Java service ↔ Python client works!)

### WSDL (Web Services Description Language)
- XML document describing your service
- Lists all operations, parameters, return types
- Auto-generated at `http://localhost:9090/calculator?wsdl`
- Clients import WSDL to know how to call your service

### JAX-WS (Java API for XML Web Services)
- Java framework for building SOAP services
- Handles all the complexity:
  - Java ↔ XML conversion
  - HTTP server creation
  - WSDL generation
  - Request routing
  - Protocol handling

### Annotations
- `@WebService` - Marks class as SOAP service
- `@WebMethod` - Marks method as SOAP operation
- `@WebParam` - Names parameters in WSDL

---

## ✅ Summary

**What you have:**
- ✅ A working SOAP web service
- ✅ Clean, minimal code (2 Java files, 67 lines)
- ✅ Professional API with auto-generated WSDL
- ✅ Test scripts
- ✅ Easy startup

**How it works:**
1. Java annotations mark your code as SOAP service
2. JAX-WS library handles all SOAP complexity
3. ServicePublisher starts HTTP server
4. Clients send XML requests
5. Your Java methods process them
6. JAX-WS sends XML responses back

**The beauty:**
- You write simple Java code
- JAX-WS does all the SOAP magic
- No manual XML writing needed!

---

## 📞 Service Information

**When running:**
- Service URL: `http://localhost:9090/calculator`
- WSDL URL: `http://localhost:9090/calculator?wsdl`
- Operations: `add`, `subtract`, `multiply`, `divide`
- Protocol: SOAP 1.1 over HTTP
- Style: Document/Literal
