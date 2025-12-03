<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - MindWell</title>
    <meta charset="UTF-8"/>
</head>
<body>
<h2>User Login</h2>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

<c:if test="${not empty msg}">
    <p style="color:green;">${msg}</p>
</c:if>

<form action="${pageContext.request.contextPath}/auth/login" method="post">
    <label>Username:</label>
    <input type="text" name="username" required/><br/><br/>

    <label>Password:</label>
    <input type="password" name="password" required/><br/><br/>

    <label>Role:</label>
    <select name="role" required>
        <c:forEach var="r" items="${roles}">
            <option value="${r}">${r}</option>
        </c:forEach>
    </select><br/><br/>

    <button type="submit">Login</button>
</form>

<p>Don't have an account? <a href="${pageContext.request.contextPath}/auth/register">Register here</a></p>

</body>
</html>
