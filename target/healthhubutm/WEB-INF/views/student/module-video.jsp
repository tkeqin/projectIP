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

        /* Tabs (1.0, 2.0, 3.0) - kept for visual consistency */
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

        /* Video Container Styling */
        .video-wrapper {
            position: relative;
            padding-bottom: 56.25%; /* 16:9 Aspect Ratio */
            height: 0;
            overflow: hidden;
            border-radius: 12px;
            background-color: #000;
            margin-bottom: 25px;
        }

        .video-wrapper iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 0;
        }

        .video-info h3 {
            font-size: 1.25rem;
            color: #2c3e50;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .video-info p {
            color: #7f8c8d;
            line-height: 1.6;
            font-size: 1rem;
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

        <!-- Tabs Navigation -->
        <div class="tabs-container">
            <div class="tab active">Video Lesson</div>
            <!-- Quiz tab deleted as requested -->
        </div>

        <!-- Content Card with Video -->
        <div class="content-card">
            <div class="video-wrapper">
                <!-- Using a specific valid YouTube Embed ID (Psych2Go: 5 Signs You're Struggling With Mental Health) -->
                <iframe src="https://www.youtube.com/embed/1i9OktVk5VE" title="YouTube video player" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
            
            <div class="video-info">
                <h3>Key Takeaways</h3>
                <p>This video explores the subtle and obvious signs of mental health challenges. Pay attention to changes in sleep patterns, appetite, mood stability, and social withdrawal. Recognizing these signs early is the first step toward getting help.</p>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <!-- Save Progress: Goes back to Education Dashboard -->
            <a href="${pageContext.request.contextPath}/student/education" class="btn btn-save">
                Save Progress & Leave
            </a>

            <!-- Finish Module -->
            <a href="${pageContext.request.contextPath}/student/education" class="btn btn-continue">
                Mark as Complete
            </a>
        </div>
    </div>

</body>
</html>