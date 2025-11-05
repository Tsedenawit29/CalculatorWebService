#!/bin/bash

echo "🧪 Testing Calculator SOAP Web Service"
echo "======================================="
echo ""

# Test 1: Add operation
echo "Test 1: Add 10 + 5"
curl -s -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Header/>
         <soapenv:Body>
           <cal:add>
             <a>10</a>
             <b>5</b>
           </cal:add>
         </soapenv:Body>
       </soapenv:Envelope>' | grep -o '<return>.*</return>'
echo ""

# Test 2: Subtract operation  
echo "Test 2: Subtract 20 - 8"
curl -s -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Header/>
         <soapenv:Body>
           <cal:subtract>
             <a>20</a>
             <b>8</b>
           </cal:subtract>
         </soapenv:Body>
       </soapenv:Envelope>' | grep -o '<return>.*</return>'
echo ""

# Test 3: Multiply operation
echo "Test 3: Multiply 6 × 7"
curl -s -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Header/>
         <soapenv:Body>
           <cal:multiply>
             <a>6</a>
             <b>7</b>
           </cal:multiply>
         </soapenv:Body>
       </soapenv:Envelope>' | grep -o '<return>.*</return>'
echo ""

# Test 4: Divide operation
echo "Test 4: Divide 100 ÷ 4"
curl -s -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Header/>
         <soapenv:Body>
           <cal:divide>
             <a>100</a>
             <b>4</b>
           </cal:divide>
         </soapenv:Body>
       </soapenv:Envelope>' | grep -o '<return>.*</return>'
echo ""

echo ""

# Test 5: Power operation
echo "Test 5: Power 2^8"
curl -s -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Body>
           <cal:power>
             <base>2</base>
             <exponent>8</exponent>
           </cal:power>
         </soapenv:Body>
       </soapenv:Envelope>' | grep -o '<return>.*</return>'
echo ""

# Test 6: Square Root
echo "Test 6: Square Root of 144"
curl -s -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Body>
           <cal:squareRoot>
             <number>144</number>
           </cal:squareRoot>
         </soapenv:Body>
       </soapenv:Envelope>' | grep -o '<return>.*</return>'
echo ""

# Test 7: Percentage
echo "Test 7: 20% of 500"
curl -s -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Body>
           <cal:percentage>
             <number>500</number>
             <percent>20</percent>
           </cal:percentage>
         </soapenv:Body>
       </soapenv:Envelope>' | grep -o '<return>.*</return>'
echo ""

# Test 8: Modulo
echo "Test 8: Modulo 17 % 5"
curl -s -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Body>
           <cal:modulo>
             <a>17</a>
             <b>5</b>
           </cal:modulo>
         </soapenv:Body>
       </soapenv:Envelope>' | grep -o '<return>.*</return>'
echo ""

# Test 9: Absolute value
echo "Test 9: Absolute value of -42"
curl -s -X POST http://localhost:9090/calculator \
  -H "Content-Type: text/xml" \
  -d '<?xml version="1.0" encoding="UTF-8"?>
       <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                         xmlns:cal="http://calculator.com/">
         <soapenv:Body>
           <cal:absolute>
             <number>-42</number>
           </cal:absolute>
         </soapenv:Body>
       </soapenv:Envelope>' | grep -o '<return>.*</return>'
echo ""

echo "✅ All tests completed!"
