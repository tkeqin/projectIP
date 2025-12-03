<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Counselling Session</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
</head>
<body>
<div class="container">
    <h1>Book Counselling Session</h1>
    <p class="subtitle">Browse our experienced mental health professionals and book a session that works for you</p>

    <!-- Messages -->
    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <div class="cards">

        <c:choose>
            <c:when test="${empty mhps}">
                <p>No counsellors available.</p>
            </c:when>

            <c:otherwise>
                <c:forEach var="mhp" items="${mhps}">
                    <div class="card">

                        <!-- IMAGE FIXED -->
                        <c:url value='/images/${mhp.username}.jpg' var='profileImg'/>
                        <c:url value='/images/default.jpg' var='defaultImg'/>

                        <img src="${profileImg}"
                             onerror="this.src='${defaultImg}'"
                             alt="${mhp.fullName}" />

                        <h3>${mhp.fullName}</h3>
                        <p>General Counselling</p>

                        <%-- ORIGINAL DYNAMIC FIELDS REMOVED BECAUSE MODEL DOESN’T HAVE THE PROPERTIES --%>
                        <%-- <p>Rating: <span class="rating">${mhp.rating}</span></p> --%>
                        <%-- <p>${mhp.completedSessions} sessions completed</p> --%>

                        <!-- TEMPORARY PLACEHOLDERS (static text) -->
                        <p>Rating: 8.5/10</p>
                        <p>41 sessions completed</p>

                        <div class="available-times">
                            <p><strong>Available Times:</strong></p>

                            <c:choose>
                                <c:when test="${empty availableSlotsMap[mhp.username]}">
                                    <span>No slots available</span>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="slot" items="${availableSlotsMap[mhp.username]}">
                                        <span>${slot}</span>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <form action="<c:url value='/sessions/book'/>" method="post">
                            <input type="hidden" name="mhpUsername" value="${mhp.username}"/>

                            <select name="time" required>

                                <c:choose>
                                    <c:when test="${empty availableSlotsMap[mhp.username]}">
                                        <option disabled>No slots available</option>
                                    </c:when>

                                    <c:otherwise>
                                        <c:forEach var="slot" items="${availableSlotsMap[mhp.username]}">
                                            <option value="${slot}">${slot}</option>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                            </select>

                            <button type="submit" class="btn-book">Book Session</button>
                        </form>

                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
