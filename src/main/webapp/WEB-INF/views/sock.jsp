<!DOCTYPE html>
<html>
<head>
  <title>Hello WebSocket</title>
  <script src="http://cdn.jsdelivr.net/sockjs/1.0.0/sockjs.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

  <script type="text/javascript">
    var stompClient = null;

    function connect() {
      var socket = new SockJS('/socket');
      stompClient = Stomp.over(socket);
      stompClient.connect({}, function(frame) {
        console.log('Connected: ' + frame);
        stompClient.subscribe('/operation/get', function(objectOperation){
          doObjectOperation(JSON.parse(objectOperation.body).content);
        });
      });
    }

    function disconnect() {
      if (stompClient != null) {
        stompClient.disconnect();
      }
      console.log("Disconnected");
    }

    function sendName() {
      var name = document.getElementById('name').value;
      stompClient.send("/app/socket", {}, JSON.stringify({ 'name': name }));
    }

    function doObjectOperation(message) {
      var response = document.getElementById('response');
      var p = document.createElement('p');
      p.style.wordWrap = 'break-word';
      p.appendChild(document.createTextNode(message));
      response.appendChild(p);
    }
  </script>
</head>
<body onload="connect()">
<noscript><h2 style="color: #ff0000">Seems your browser doesn't support Javascript! Websocket relies on Javascript being enabled. Please enable
  Javascript and reload this page!</h2></noscript>
<div>
   <div id="conversationDiv">
    <label>What is your name?</label><input type="text" id="name" />
    <button id="sendName" onclick="sendName();">Send</button>
    <p id="response"></p>
  </div>
</div>
</body>
</html>