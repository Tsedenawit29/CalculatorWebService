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

echo "✅ All tests completed!"
