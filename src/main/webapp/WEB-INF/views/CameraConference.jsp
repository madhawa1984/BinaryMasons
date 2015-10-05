<!DOCTYPE html>
<html lang="en">
<head>
  <title>Video Conferencing</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
  <link rel="author" type="">
  <meta name="author" content="">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <link rel="stylesheet" href="css/style.css">
  <style>
    audio,
    video {
      -moz-transition: all 1s ease;
      -ms-transition: all 1s ease;
      -o-transition: all 1s ease;
      -webkit-transition: all 1s ease;
      transition: all 1s ease;
      vertical-align: top;
    }
    input {
      border: 1px solid #d9d9d9;
      border-radius: 1px;
      font-size: 2em;
      margin: .2em;
      width: 30%;
    }
    .setup {
      border-bottom-left-radius: 0;
      border-top-left-radius: 0;
      font-size: 102%;
      height: 47px;
      margin-left: -9px;
      margin-top: 8px;
      position: absolute;
    }
    p {
      padding: 1em;
    }
    li {
      border-bottom: 1px solid rgb(189, 189, 189);
      border-left: 1px solid rgb(189, 189, 189);
      padding: .5em;
    }
  </style>
  <script>
    document.createElement('article');
    document.createElement('footer');
  </script>
  <!-- scripts used for broadcasting -->
  <script src="scripts/firebase.js">
  </script>
  <script src="scripts/RTCMultiConnection.js">
  </script>
</head>
<body>
<article>
  <header style="text-align: center;">
    <h1>
      <a href=""></a> Video Conferencing
      <!--<a href="">MultiConnection</a>-->
    </h1>
    <!-- <p>
         <a href="https://www.webrtc-experiment.com/">HOME</a>
         <span> &copy; </span>
         <a href="http://www.MuazKhan.com/" target="_blank">Muaz Khan</a> .
         <a href="http://twitter.com/WebRTCWeb" target="_blank" title="Twitter profile for WebRTC Experiments">@WebRTCWeb</a> .
         <a href="https://github.com/muaz-khan?tab=repositories" target="_blank" title="Github Profile">Github</a> .
         <a href="https://github.com/muaz-khan/WebRTC-Experiment/issues?state=open" target="_blank">Latest issues</a> .
         <a href="https://github.com/muaz-khan/WebRTC-Experiment/commits/master" target="_blank">What's New?</a>
     </p>-->
  </header>
  <!-- just copy this <section> and next script -->

  <div>
    <section>
            <span>
            Private
            <a href="" target="_blank" title="Open this link in new tab. Then your room will be private!">
              <code>
                <strong id="unique-token">#123456789</strong>
              </code>
            </a>
            </span>
      <input type="text" id="conference-name">
      <button id="setup-new-conference" class="setup">Setup New Conference</button>
    </section>
  </div>

  <section class="experiment">
    <!--<section>
        <span>
        Private ??
        <a href="" target="_blank" title="Open this link in new tab. Then your room will be private!">
            <code>
                <strong id="unique-token">#123456789</strong>
            </code>
        </a>
        </span>
        <input type="text" id="conference-name">
        <button id="setup-new-conference" class="setup">Setup New Conference</button>
    </section>-->
    <!-- list of all available broadcasting rooms -->
    <table style="width: 100%;" id="rooms-list"></table>
    <!-- local/remote videos container -->
    <div id="videos-container"></div>
  </section>
  <script>
    // Muaz Khan - https://github.com/muaz-khan
    // MIT License - https://www.webrtc-experiment.com/licence/
    // Documentation - https://github.com/muaz-khan/RTCMultiConnection
    var connection = new RTCMultiConnection();
    connection.session = {
      audio: true,
      video: true
    };
    connection.onstream = function(e) {
      e.mediaElement.width = 300;
      videosContainer.insertBefore(e.mediaElement, videosContainer.firstChild);
      rotateVideo(e.mediaElement);
      //scaleVideos();
    };
    function rotateVideo(mediaElement) {
      mediaElement.style[navigator.mozGetUserMedia ? 'transform' : '-webkit-transform'] = 'rotate(0deg)';
      setTimeout(function() {
        mediaElement.style[navigator.mozGetUserMedia ? 'transform' : '-webkit-transform'] = 'rotate(360deg)';
      }, 1000);
    }
    connection.onstreamended = function(e) {
      e.mediaElement.style.opacity = 0;
      rotateVideo(e.mediaElement);
      setTimeout(function() {
        if (e.mediaElement.parentNode) {
          e.mediaElement.parentNode.removeChild(e.mediaElement);
        }
        //scaleVideos();
      }, 1000);
    };
    var sessions = {};
    connection.onNewSession = function(session) {
      if (sessions[session.sessionid]) return;
      sessions[session.sessionid] = session;
      var tr = document.createElement('tr');
      tr.innerHTML = '<td><strong>' + session.sessionid + '</strong> is running a conference!</td>' +
              '<td><button class="join">Join</button></td>';
      roomsList.insertBefore(tr, roomsList.firstChild);
      var joinRoomButton = tr.querySelector('.join');
      joinRoomButton.setAttribute('data-sessionid', session.sessionid);
      joinRoomButton.onclick = function() {
        this.disabled = true;
        var sessionid = this.getAttribute('data-sessionid');
        session = sessions[sessionid];
        if (!session) throw 'No such session exists.';
        connection.join(session);
      };
    };
    var videosContainer = document.getElementById('videos-container') || document.body;
    var roomsList = document.getElementById('rooms-list');
    document.getElementById('setup-new-conference').onclick = function() {
      this.disabled = true;
      connection.open(document.getElementById('conference-name').value || 'Anonymous');
    };
    // setup signaling to search existing sessions
    connection.connect();
    (function() {
      var uniqueToken = document.getElementById('unique-token');
      if (uniqueToken)
        if (location.hash.length > 2) uniqueToken.parentNode.parentNode.parentNode.innerHTML = '<h2 style="text-align:center;"><a href="' + location.href + '" target="_blank">Share this link</a></h2>';
        else uniqueToken.innerHTML = uniqueToken.parentNode.parentNode.href = '#' + (Math.random() * new Date().getTime()).toString(36).toUpperCase().replace(/\./g, '-');
    })();
    function scaleVideos() {
      var videos = document.querySelectorAll('video'),
              length = videos.length,
              video;
      var minus = 130;
      var windowHeight = 700;
      var windowWidth = 600;
      var windowAspectRatio = windowWidth / windowHeight;
      var videoAspectRatio = 4 / 3;
      var blockAspectRatio;
      var tempVideoWidth = 0;
      var maxVideoWidth = 0;
      for (var i = length; i > 0; i--) {
        blockAspectRatio = i * videoAspectRatio / Math.ceil(length / i);
        if (blockAspectRatio <= windowAspectRatio) {
          tempVideoWidth = videoAspectRatio * windowHeight / Math.ceil(length / i);
        } else {
          tempVideoWidth = windowWidth / i;
        }
        if (tempVideoWidth > maxVideoWidth)
          maxVideoWidth = tempVideoWidth;
      }
      for (var i = 0; i < length; i++) {
        video = videos[i];
        if (video)
          video.width = maxVideoWidth - minus;
      }
    }
    window.onresize = scaleVideos;
  </script>
  <!--<section class="experiment">
      <h2 class="header" id="feedback">Feedback</h2>
      <div>
          <textarea id="message" style="border: 1px solid rgb(189, 189, 189); height: 8em; margin: .2em; outline: none; resize: vertical; width: 98%;" placeholder="Have any message? Suggestions or something went wrong?"></textarea>
      </div>
      <button id="send-message" style="font-size: 1em;">Send Message</button>
      <small style="margin-left: 1em;">Enter your email too; if you want "direct" reply!</small>
  </section>-->
  <!--<section class="experiment own-widgets latest-commits">
      <h2 class="header" id="updates" style="color: red; padding-bottom: .1em;"><a href="https://github.com/muaz-khan/WebRTC-Experiment/commits/master" target="_blank">Latest Updates</a>
      </h2>
      <div id="github-commits"></div>
  </section>-->
</article>
<!--<a href="https://github.com/muaz-khan/RTCMultiConnection" class="fork-left"></a>-->
<footer>
  <!--<a href="https://www.webrtc-experiment.com/" target="_blank">WebRTC Experiments!</a> and
  <a href="http://www.RTCMultiConnection.org/docs/" target="_blank">RTCMultiConnection.js</a> ©
  <a href="mailto:muazkh@gmail.com" target="_blank">Muaz Khan</a>:
  <a href="https://twitter.com/WebRTCWeb" target="_blank">@WebRTCWeb</a>-->
</footer>
<!-- commits.js is useless for you! -->
<script src="scripts/commits.js" async>
</script>
</body>