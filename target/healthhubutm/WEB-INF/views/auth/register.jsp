<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - MindWell</title>
    <meta charset="UTF-8"/>
</head>
<body>
<h2>User Registration</h2>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/auth/register" method="post">
    <label>Full Name:</label>
    <input type="text" name="fullName" required/><br/><br/>

    <label>Email:</label>
    <input type="email" name="email" required/><br/><br/>

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

    <button type="submit">Register</button>
</form>

<p>Already have an account?
    <a href="${pageContext.request.contextPath}/auth/login">Login here</a>
</p>

</body>
</html>
