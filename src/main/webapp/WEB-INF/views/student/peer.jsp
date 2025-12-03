<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Peer Support Forum</title>
    <link rel="stylesheet" href="path_to_your_styles.css">
</head>
<body>
    <div class="forum-container">
        <header>
            <h1>Peer Support Forum</h1>
            <p>A safe space to share, connect, and support each other</p>
        </header>
        
        <!-- New Post Button -->
        <div class="new-post-button">
            <button onclick="window.location.href='${pageContext.request.contextPath}/student/new-post'">+ New Post</button>
        </div>

        <!-- Post Categories Filter -->
        <div class="filter-container">
            <button class="category-button" onclick="filterPosts('All')">All</button>
            <button class="category-button" onclick="filterPosts('Stress')">Stress</button>
            <button class="category-button" onclick="filterPosts('Anxiety')">Anxiety</button>
            <button class="category-button" onclick="filterPosts('Depression')">Depression</button>
            <button class="category-button" onclick="filterPosts('Wellness')">Wellness</button>
            <button class="category-button" onclick="filterPosts('Self-Care')">Self-Care</button>
            <button class="category-button" onclick="filterPosts('Relationships')">Relationships</button>
        </div>

        <!-- Posts Section -->
        <div class="posts-section">
            <div class="post">
                <h3>Managing exam stress - what works for you?</h3>
                <p>Finals are coming up and I'm feeling overwhelmed. What strategies have helped you cope with academic pressure?</p>
                <div class="post-info">
                    <span class="post-author">Anonymous - Stress</span>
                    <span class="post-time">2 hours ago</span>
                </div>
                <div class="post-interactions">
                    <span>24 Likes</span>
                    <span>18 Replies</span>
                </div>
            </div>

            <div class="post">
                <h3>Meditation apps recommendations</h3>
                <p>Looking for good meditation apps. Any recommendations for apps that helped you with wellness?</p>
                <div class="post-info">
                    <span class="post-author">Student123 - Wellness</span>
                    <span class="post-time">5 hours ago</span>
                </div>
                <div class="post-interactions">
                    <span>12 Likes</span>
                    <span>5 Replies</span>
                </div>
            </div>

            <!-- Add more posts dynamically here -->
        </div>
    </div>

    <script>
        function filterPosts(category) {
            // Add filtering functionality based on the selected category.
            console.log("Filtering posts for category: " + category);
            // In a real-world scenario, this could involve an AJAX request to filter posts from the database.
        }
    </script>
</body>
</html>
