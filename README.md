# Calculator SOAP Web Service ✅

A clean, working SOAP web service calculator built with JAX-WS (Java API for XML Web Services).

## ✨ Features

Four arithmetic operations via SOAP protocol:
- **Add** - Addition of two numbers
- **Subtract** - Subtraction of two numbers
- **Multiply** - Multiplication of two numbers
- **Divide** - Division with zero-check protection

## 📁 Clean Project Structure

```
calculator app/
├── src/main/java/com/calculator/
│   ├── CalcWebService.java       # SOAP service (calculator operations)
│   └── ServicePublisher.java     # Server startup class
├── pom.xml                        # Maven dependencies & config
├── start-soap-service.sh          # Easy startup script
├── test-soap-service.sh           # Test all operations
└── JAVA_SOAP_GUIDE.md            # Complete documentation
```

## 🚀 Quick Start

### 1. Start the Service
```bash
./start-soap-service.sh
```

**Service will be running at:**
- Service URL: `http://localhost:9090/calculator`
- WSDL URL: `http://localhost:9090/calculator?wsdl`

### 2. Test It
```bash
./test-soap-service.sh
```

---

## 🎯 How It Works

### The Flow:
```
Client Request (SOAP XML)
    ↓
ServicePublisher (runs on port 9090)
    ↓
CalcWebService (processes the operation)
    ↓
SOAP Response (result as XML)
```

### What Each File Does:

#### 1. **CalcWebService.java** (The Brain)
```java
@WebService                    // Makes this a SOAP service
public class CalcWebService {
    @WebMethod                 // Exposes method as SOAP operation
    public double add(double a, double b) {
        return a + b;          // Does the calculation
    }
    // ... multiply, subtract, divide
}
```
**Purpose:** Contains the calculator logic. Each `@WebMethod` becomes a SOAP operation.

#### 2. **ServicePublisher.java** (The Server)
```java
public class ServicePublisher {
    public static void main(String[] args) {
        String url = "http://localhost:9090/calculator";
        Endpoint.publish(url, new CalcWebService());  // Starts the service
    }
}
```
**Purpose:** Starts the HTTP server and publishes the SOAP service at port 9090.

#### 3. **pom.xml** (Dependencies)
```xml
<dependency>
    <groupId>com.sun.xml.ws</groupId>
    <artifactId>jaxws-rt</artifactId>  <!-- SOAP library -->
</dependency>
```
**Purpose:** Tells Maven which libraries to download (JAX-WS for SOAP).

---

## 📖 API Operations

| Operation | Parameters | Returns | Example |
|-----------|------------|---------|---------|
| `add(a, b)` | double a, double b | double | 10 + 5 = 15.0 |
| `subtract(a, b)` | double a, double b | double | 20 - 8 = 12.0 |
| `multiply(a, b)` | double a, double b | double | 6 × 7 = 42.0 |
| `divide(a, b)` | double a, double b | double | 100 ÷ 4 = 25.0 |

**Error Handling:** Division by zero throws `IllegalArgumentException`

---

## 🔧 Technologies Used

- **Java 11+** - Programming language
- **JAX-WS 2.3.3** - SOAP web service framework
- **Maven** - Build and dependency management
- **SOAP/XML** - Communication protocol
