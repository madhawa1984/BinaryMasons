<%--
  Created by IntelliJ IDEA.
  User: madhawa
  Date: 10/1/15
  Time: 7:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>




<html>
<script type="text/javascript">
    function submitForm() {
        alert('running the submit');
        document.forms["login"].submit();
    }
</script>

<body>
unauthorised login please logon again
<form metHod="POST" name="login" action="/BinaryMasons/ui/loginPost" >
    <input type="text" name="UNAME"/>
    <input type="password" name="PWD"/>
    <input type="submit" value="login" onclick="submitForm()"/>
</form>
</body>
</html>

