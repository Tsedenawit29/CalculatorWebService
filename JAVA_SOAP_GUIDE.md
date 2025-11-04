# ✅ Java SOAP Calculator Web Service - WORKING!

## 🎉 Current Status: RUNNING

**Service URL:** http://localhost:9090/calculator  
**WSDL URL:** http://localhost:9090/calculator?wsdl

---

## 📝 Why We Use Python vs Java

You asked a great question: "Why use Python when we have a Java web service?"

### The Answer:
- **Python** was ONLY used to serve the HTML calculator file (calculator-web.html) - it's just a simple file server
- **Java** is used for the actual SOAP web service backend
- These are two different calculators:
  1. **HTML Calculator** → Browser-based, no backend needed, uses Python for file serving
  2. **Java SOAP Service** → Enterprise web service, uses Java for SOAP protocol

---

## 🔧 The Error You Encountered - FIXED!

### What Was the Problem?
```
java.lang.reflect.InaccessibleObjectException: 
Unable to make field private static final jdk.internal.misc.Unsafe 
jdk.internal.misc.Unsafe.theUnsafe accessible
```

### Why Did It Happen?
- Java 9+ introduced a **module system** that restricts access to internal JDK classes
- JAX-WS (the SOAP library) needs to access these internal modules
- Without proper JVM arguments, access is blocked

### How We Fixed It
Added special JVM arguments to **open the required modules**:
```bash
--add-opens java.base/java.lang.reflect=ALL-UNNAMED
--add-opens java.base/java.util=ALL-UNNAMED
--add-opens java.base/jdk.internal.misc=ALL-UNNAMED
--add-opens java.base/java.lang=ALL-UNNAMED
--add-opens java.base/sun.nio.ch=ALL-UNNAMED
```

---

## 🚀 How to Start the Java SOAP Service

### Quick Start (Easiest Method)
```bash
cd "/home/tsedenawit/calculator app"

# Compile the code
mvn clean compile

# Generate classpath
mvn dependency:build-classpath -Dmdep.outputFile=classpath.txt

# Run with JVM arguments
java \
  --add-opens java.base/java.lang.reflect=ALL-UNNAMED \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/jdk.internal.misc=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED \
  --add-opens java.base/sun.nio.ch=ALL-UNNAMED \
  -cp "target/classes:$(cat classpath.txt)" \
  com.calculator.ServicePublisher
```

### Using the Startup Script
```bash
./start-soap-service.sh
```

---

## 🧪 Test Results

All operations tested and **working perfectly**:

| Operation | Test | Result | Status |
|-----------|------|--------|--------|
| Add | 10 + 5 | 15.0 | ✅ |
| Subtract | 20 - 8 | 12.0 | ✅ |
| Multiply | 6 × 7 | 42.0 | ✅ |
| Divide | 100 ÷ 4 | 25.0 | ✅ |

### Run Tests Yourself
```bash
./test-soap-service.sh
```

---

## 📖 SOAP Service API

### 1. Add Operation
**SOAP Request:**
```xml
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
<return>15.0</return>
```

### 2. Subtract Operation
```xml
<cal:subtract>
  <a>20</a>
  <b>8</b>
</cal:subtract>
```

### 3. Multiply Operation
```xml
<cal:multiply>
  <a>6</a>
  <b>7</b>
</cal:multiply>
```

### 4. Divide Operation
```xml
<cal:divide>
  <a>100</a>
  <b>4</b>
</cal:divide>
```

---

## 🌐 Testing with curl

### Add: 10 + 5
```bash
curl -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Body>
           <cal:add>
             <a>10</a>
             <b>5</b>
           </cal:add>
         </soapenv:Body>
       </soapenv:Envelope>'
```

---

## 🛠️ Troubleshooting

### Port Already in Use
If you get "Address already in use":
```bash
# Find the process using the port
ps aux | grep ServicePublisher

# Kill it (replace PID with actual process ID)
kill <PID>

# Wait 2 seconds and restart
sleep 2
./start-soap-service.sh
```

### Module Access Errors
Always use the JVM arguments when starting:
```bash
--add-opens java.base/java.lang.reflect=ALL-UNNAMED
--add-opens java.base/java.util=ALL-UNNAMED
--add-opens java.base/jdk.internal.misc=ALL-UNNAMED
```

---

## 📂 Project Files

### Java Source Files
- `CalcWebService.java` - Main SOAP service with calculator operations
- `ServicePublisher.java` - Publishes the service on port 9090
- `CalculatorService.java` - Alternative service implementation
- `CalculatorServer.java` - Server launcher

### Helper Scripts
- ✅ `start-soap-service.sh` - Start the SOAP service
- ✅ `test-soap-service.sh` - Test all operations
- ✅ `classpath.txt` - Generated classpath file

---

## ✅ Summary

**Your Java SOAP Calculator Web Service is:**
- ✅ Compiled successfully
- ✅ Running on port 9090
- ✅ All operations tested and working
- ✅ WSDL accessible at http://localhost:9090/calculator?wsdl
- ✅ No module access errors

**The service is ready for production use!** 🎉

---

## 📞 WSDL Access

View the service definition:
- **Browser:** http://localhost:9090/calculator?wsdl
- **curl:** `curl http://localhost:9090/calculator?wsdl`

Import this WSDL into SoapUI or any SOAP client to test all operations.
