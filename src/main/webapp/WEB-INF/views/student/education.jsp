<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Educational Modules - HealthHub</title>
    <!-- Using FontAwesome for the icons -->
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
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 50px;
        }

        .header h1 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .header p {
            color: #7f8c8d;
            font-size: 1.1rem;
        }

        /* Grid Layout */
        .modules-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2 Columns like the image */
            gap: 30px;
        }

        /* Card Styling */
        .module-card {
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .module-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        .card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .icon-box {
            width: 50px;
            height: 50px;
            background-color: #f0fdfc; /* Light teal bg for icon */
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .icon-box i {
            font-size: 24px;
            color: #00c4cc; /* Teal color */
        }

        .duration-badge {
            background-color: #fff;
            border: 1px solid #eee;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            color: #555;
        }

        .card-content h3 {
            font-size: 1.25rem;
            color: #2c3e50;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .card-content p {
            color: #7f8c8d;
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 25px;
        }

        .start-btn {
            width: 100%;
            padding: 12px;
            background-color: #00d2d3; /* Bright Teal */
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            display: block;
            transition: background-color 0.2s;
        }

        .start-btn:hover {
            background-color: #00b8b9;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .modules-grid {
                grid-template-columns: 1fr; /* Stack on mobile */
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <h1>Educational Modules</h1>
            <p>Choose a module to your self-paced learning and track your own progress!</p>
        </div>

        <div class="modules-grid">
            <!-- JSTL ForEach Loop to render modules from Controller -->
            <c:forEach var="module" items="${modules}">
                <div class="module-card">
                    <div class="card-top">
                        <div class="icon-box">
                            <!-- Dynamic Icon Class -->
                            <i class="${module.iconClass}"></i>
                        </div>
                        <span class="duration-badge">${module.duration}</span>
                    </div>
                    
                    <div class="card-content">
                        <h3>${module.title}</h3>
                        <p>${module.description}</p>
                    </div>

                    <a href="${pageContext.request.contextPath}${module.link}" class="start-btn">Start Module</a>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>