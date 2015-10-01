<%
  if(session!=null) {
    String onlinestatus = (String) session.getAttribute("onlineStatus");
    if ("online".equals(onlinestatus)) {
      String url = request.getScheme()+"://"+request.getServerName();
      if(request.getServerPort() != 80 && request.getServerPort() != 443){
        url = url + ":" + request.getServerPort();
      }
      url = url + "/BinaryMasons/au/success";
      response.sendRedirect(url);
    }
    System.out.println("onlinestatus --- jsp "+onlinestatus);
    //System.out.println("url" + request. + "xxx" + request.getContextPath());
  }
%>
<html>
<script type="text/javascript">
  function submitForm() {
    alert('running the submit');
    document.forms["login"].submit();
  }
</script>

<body>

onlin status :- ${onlineStatus}

<form metHod="POST" name="login" action="/BinaryMasons/ui/loginPost" >
  <input type="text" name="UNAME"/>
  <input type="password" name="PWD"/>
  <input type="submit" value="login" onclick="submitForm()"/>
</form>
</body>
</html>