
<html>
<script type="text/javascript">
    function submitForm() {
        alert('running the submit');
        document.forms["login"].submit();
    }
</script>

<body>
displayxxxx ____${onlineStatus}___
<form metHod="POST" name="login" action="/BinaryMasons/ui/loginPost" >
    <input type="text" name="UNAME"/>
    <input type="password" name="PWD"/>
    <input type="submit" value="login" onclick="submitForm()"/>
</form>
</body>
</html>
