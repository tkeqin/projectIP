<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create a New Post</title>
    <link rel="stylesheet" href="path_to_your_styles.css">
</head>
<body>
    <div class="create-post-container">
        <header>
            <h1>Create a New Post</h1>
            <p>Share your thoughts or questions with the community.</p>
        </header>

        <!-- New Post Form -->
        <form action="submitPost.jsp" method="POST">
            <div class="form-group">
                <label for="postTitle">Post Title:</label>
                <input type="text" id="postTitle" name="postTitle" required>
            </div>
            <div class="form-group">
                <label for="postContent">What's on your mind?</label>
                <textarea id="postContent" name="postContent" rows="6" required></textarea>
            </div>
            <div class="form-group">
                <label for="category">Select Category:</label>
                <select id="category" name="category" required>
                    <option value="Stress">Stress</option>
                    <option value="Anxiety">Anxiety</option>
                    <option value="Depression">Depression</option>
                    <option value="Wellness">Wellness</option>
                    <option value="Self-Care">Self-Care</option>
                    <option value="Relationships">Relationships</option>
                </select>
            </div>
            <div class="form-group">
                <label for="postAnonymously">
                    <input type="checkbox" id="postAnonymously" name="postAnonymously"> Post anonymously
                </label>
            </div>

            <div class="form-actions">
                <button type="submit">Post</button>
                <button type="button" onclick="window.location.href='peer.jsp'">Cancel</button>
            </div>
        </form>
    </div>

    <script>
        // JavaScript can be added here for additional interactivity, like form validation or AJAX submission
    </script>
</body>
</html>
