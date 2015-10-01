var stompClient = null;

function connect() {
    var socket = new SockJS('/socket');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function(frame) {
        console.log('Connected: ' + frame);
        stompClient.subscribe('/operation/get', function(objectOperation){
            doObjectOperation(objectOperation.body);
        });
    });
}

function disconnect() {
    if (stompClient != null) {
        stompClient.disconnect();
    }
    console.log("Disconnected");
}

function sendOperation(){
    stompClient.send("/app/socket", {}, JSON.stringify($('#editorContainer').html()));
}

function doObjectOperation(message) {
   $('#editorContainer').html(JSON.parse(message));
}

$(document).ready(function(){
    connect();
});