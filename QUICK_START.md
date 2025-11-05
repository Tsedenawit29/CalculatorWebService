# 🚀 Quick Start Commands

## ✅ Both Services Are Currently Running!

### Service Status:
- ✅ **SOAP Backend** - Port 9090 (Java)
- ✅ **Web Server** - Port 8000 (Python)

---

## 📝 Commands to Run Everything

### Option 1: Two Terminal Windows (Recommended)

#### Terminal 1 - Start SOAP Backend:
```bash
cd "/home/tsedenawit/calculator app"
./start-soap-service.sh
```

**Expected Output:**
```
🚀 Starting Calculator SOAP Web Service...
📍 URL: http://localhost:9090/calculator
✅ Calculator Service is running!
📄 WSDL: http://localhost:9090/calculator?wsdl

🔧 Available Operations:
   Basic:
   - add(a, b)
   - subtract(a, b)
   - multiply(a, b)
   - divide(a, b)
   Advanced:
   - power(base, exponent)
   - squareRoot(number)
   - percentage(number, percent)
   - modulo(a, b)
   - absolute(number)

⏹️  Press Ctrl+C to stop the service.
```

#### Terminal 2 - Start Web Server:
```bash
cd "/home/tsedenawit/calculator app"
python3 cors-proxy.py
```

**Expected Output:**
```
============================================================
🌐 CORS Proxy Server for SOAP Calculator
============================================================
📍 Web Calculator: http://localhost:8000/calculator.html
🔗 Proxying to: http://localhost:9090/calculator

⚠️  Make sure SOAP service is running!
   Run in another terminal: ./start-soap-service.sh

Press Ctrl+C to stop...
============================================================
```

#### Open Browser:
```
http://localhost:8000/calculator.html
```

---

### Option 2: One-Line Commands

#### Start Backend (in background):
```bash
cd "/home/tsedenawit/calculator app" && ./start-soap-service.sh &
```

#### Start Web Server (in background):
```bash
cd "/home/tsedenawit/calculator app" && python3 cors-proxy.py &
```

#### Open Browser:
```bash
xdg-open http://localhost:8000/calculator.html
# OR for macOS:
# open http://localhost:8000/calculator.html
```

---

## 🛑 Stop Services

### Stop SOAP Backend:
```bash
pkill -f ServicePublisher
```

### Stop Web Server:
```bash
pkill -f cors-proxy
```

### Stop Both:
```bash
pkill -f ServicePublisher && pkill -f cors-proxy
```

---

## 🔍 Check If Services Are Running

```bash
ps aux | grep -E "(ServicePublisher|cors-proxy)" | grep -v grep
```

**Expected Output (if running):**
```
tsedena+    7039  ... java ... com.calculator.ServicePublisher
tsedena+    7178  ... python3 cors-proxy.py
```

---

## 🧪 Test Services

### Test SOAP Backend:
```bash
curl http://localhost:9090/calculator?wsdl
```

### Test Web Server:
```bash
curl http://localhost:8000/calculator.html
```

### Test Complete Flow:
```bash
./test-soap-service.sh
```

---

## 📋 Quick Reference

| What | Command | Port |
|------|---------|------|
| **SOAP Backend** | `./start-soap-service.sh` | 9090 |
| **Web Server** | `python3 cors-proxy.py` | 8000 |
| **Open Calculator** | Open `http://localhost:8000/calculator.html` | - |
| **Stop SOAP** | `pkill -f ServicePublisher` | - |
| **Stop Web** | `pkill -f cors-proxy` | - |
| **Test** | `./test-soap-service.sh` | - |

---

## ✅ Current Status

**Everything is RUNNING! 🎉**

Just open your browser to:
**http://localhost:8000/calculator.html**
