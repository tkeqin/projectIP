<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${moduleTitle} - HealthHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #ffffff;
            color: #333;
            padding: 40px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
        }

        /* Header Section */
        .module-header {
            margin-bottom: 30px;
        }

        .module-header h1 {
            font-size: 2rem;
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .module-header p {
            color: #95a5a6;
            font-size: 0.95rem;
        }

        /* Tabs Navigation */
        .tabs-container {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .tab {
            padding: 8px 30px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: default;
            background-color: #f8f9fa;
            color: #95a5a6;
        }

        .tab.active {
            background-color: #ffffff;
            color: #333;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        /* Main Content Card */
        .content-card {
            background: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.04);
            margin-bottom: 30px;
        }

        .content-card h3 {
            font-size: 1.25rem;
            color: #2c3e50;
            margin-top: 25px;
            margin-bottom: 15px;
            font-weight: 700;
        }
        
        .content-card h3:first-child {
            margin-top: 0;
        }

        .content-card p {
            color: #7f8c8d;
            line-height: 1.6;
            margin-bottom: 15px;
            font-size: 1rem;
        }

        .content-card ul {
            margin-left: 20px;
            margin-bottom: 20px;
            color: #7f8c8d;
        }
        
        .content-card li {
            margin-bottom: 5px;
            line-height: 1.6;
        }

        /* Footer Actions */
        .action-buttons {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .btn {
            flex: 1;
            padding: 15px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            text-align: center;
            cursor: pointer;
            text-decoration: none;
            transition: opacity 0.2s;
            border: none;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .btn-save {
            background-color: #1abc9c; /* Teal */
            color: white;
        }

        .btn-continue {
            background-color: #00d2d3; /* Slightly brighter teal */
            color: white;
        }

    </style>
</head>
<body>

    <div class="container">
        <!-- Header -->
        <div class="module-header">
            <h1>${moduleTitle}</h1>
            <p>${moduleSubtitle}</p>
        </div>

        <!-- TABS LOGIC -->
        <div class="tabs-container">
            <c:choose>
                <%-- If this is Module 3 (The Quiz Module), show "Content" and "Quiz Assessment" --%>
                <c:when test="${moduleId eq '3'}">
                    <div class="tab active">Content</div>
                    <div class="tab">Quiz Assessment</div>
                </c:when>

                <%-- OTHERWISE (Module 1, etc.), show the 1.0, 2.0, 3.0 tabs --%>
                <c:otherwise>
                    <div class="tab ${currentPage == 1 ? 'active' : ''}">1.0</div>
                    <div class="tab ${currentPage == 2 ? 'active' : ''}">2.0</div>
                    <div class="tab ${currentPage == 3 ? 'active' : ''}">3.0</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Content Area -->
        <div class="content-card">
            ${contentHtml}
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/student/education" class="btn btn-save">
                Save Progress & Leave
            </a>

            <c:choose>
                <%-- If Module 3, button directs to the Quiz Page (Page 2) --%>
                <c:when test="${moduleId eq '3'}">
                     <a href="${pageContext.request.contextPath}/student/module/${moduleId}?page=2" class="btn btn-continue">
                        Proceed to Quiz
                    </a>
                </c:when>

                <%-- Standard Logic for other modules --%>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${currentPage < 3}">
                            <a href="${pageContext.request.contextPath}/student/module/${moduleId}?page=${currentPage + 1}" class="btn btn-continue">
                                Continue On
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/student/education" class="btn btn-continue">
                                Finish Module
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</body>
</html>