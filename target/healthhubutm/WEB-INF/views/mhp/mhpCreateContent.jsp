<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit Content' : 'Create Content'} - HealthHub MHP</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        /* [Keeping CSS exactly the same] */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #ffffff; color: #333; padding: 40px; }
        .main-layout { display: flex; gap: 40px; max-width: 1400px; margin: 0 auto; }
        .content-column { flex: 3; }
        .sidebar-column { flex: 1; }
        .page-header { margin-bottom: 25px; }
        .page-header h1 { font-size: 1.8rem; color: #2c3e50; margin-bottom: 5px; }
        .page-header p { color: #95a5a6; font-size: 0.9rem; }
        .btn-header-action { background-color: #00d2d3; color: white; padding: 10px 20px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; float: right; font-size: 0.9rem; text-decoration: none; }
        .tabs { display: flex; gap: 10px; margin-bottom: 30px; }
        .tab-btn { background: none; border: none; padding: 8px 15px; font-weight: 600; color: #95a5a6; cursor: pointer; border-radius: 20px; }
        .tab-btn.active { background-color: #f1f2f6; color: #2c3e50; }
        .tab-btn:hover { color: #2c3e50; background-color: #f8f9fa; }
        .form-card { border: 1px solid #eee; border-radius: 12px; padding: 30px; background-color: #fff; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        .form-title { font-size: 1.4rem; color: #2c3e50; margin-bottom: 10px; font-weight: 600; }
        .form-subtitle { color: #95a5a6; font-size: 0.9rem; margin-bottom: 30px; display: block; }
        .form-group { margin-bottom: 25px; }
        .form-row { display: flex; gap: 30px; margin-bottom: 25px; }
        .col-half { flex: 1; }
        .col-third { flex: 1; }
        label { display: block; font-weight: 600; color: #34495e; margin-bottom: 8px; font-size: 0.95rem; }
        input[type="text"], input[type="number"], select, textarea { width: 100%; padding: 12px 15px; border: 1px solid #e0e0e0; border-radius: 8px; font-size: 0.95rem; color: #555; background-color: #fff; transition: border-color 0.2s; outline: none; }
        input:focus, select:focus, textarea:focus { border-color: #00d2d3; }
        textarea.short { height: 80px; resize: none; }
        textarea.long { height: 300px; resize: vertical; }
        .form-actions { display: flex; gap: 20px; margin-top: 40px; }
        .btn-submit { flex: 1; padding: 15px; border-radius: 8px; font-weight: 600; font-size: 1rem; cursor: pointer; border: none; text-align: center; }
        .btn-save-draft { background-color: #00d2d3; color: white; opacity: 0.9; }
        .btn-publish { background-color: #00d2d3; color: white; }
        .btn-publish:hover, .btn-save-draft:hover { opacity: 1; filter: brightness(1.05); }
        .ai-card { border: 1px solid #eee; border-radius: 12px; padding: 20px; background-color: #fff; height: fit-content; }
        .ai-header { display: flex; align-items: center; gap: 10px; margin-bottom: 15px; }
        .ai-header h3 { font-size: 1.2rem; color: #2c3e50; }
        .ai-input-box { position: relative; width: 100%; }
        .ai-input-box input { width: 100%; padding: 12px 40px 12px 15px; border: 1px solid #ddd; border-radius: 20px; outline: none; font-size: 0.9rem; }
        .ai-input-box i { position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: #95a5a6; cursor: pointer; }
    </style>
</head>
<body>

    <div class="main-layout">
        <div class="content-column">
            
            <div class="page-header">
                <a href="${pageContext.request.contextPath}/mhp/content" class="btn-header-action">
                     <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
                <h1>Content Management</h1>
                <p>Create and manage educational content</p>
            </div>

            <div class="tabs">
                <button class="tab-btn" onclick="window.location.href='${pageContext.request.contextPath}/mhp/content'">My Content</button>
                <button class="tab-btn active">${isEdit ? 'Edit Content' : 'Create New'}</button>
                <button class="tab-btn">Analytics</button>
            </div>

            <div class="form-card">
                <div class="form-title">${isEdit ? 'Edit Content' : 'Create New Content'}</div>
                <span class="form-subtitle">${isEdit ? 'Update your existing content details below' : 'Share your expertise with students'}</span>

                <!-- FORM START -->
                <form action="${pageContext.request.contextPath}/mhp/save-content" method="post" id="createForm">
                    
                    <!-- HIDDEN FIELDS: ID (for updates) & Status -->
                    <input type="hidden" name="id" value="${content.id}">
                    <input type="hidden" name="status" id="statusInput" value="${content.status != null ? content.status : 'draft'}">

                    <!-- Title -->
                    <div class="form-group">
                        <label>Title</label>
                        <input type="text" name="title" placeholder="Enter content title" required value="${content.title}">
                    </div>

                    <!-- Type & Category Row -->
                    <div class="form-row">
                        <div class="col-half">
                            <label>Content Type</label>
                            <select name="contentType" required>
                                <option disabled ${content.type == null ? 'selected' : ''} value="">Select type</option>
                                <option value="Video" ${content.type == 'Video' ? 'selected' : ''}>Video</option>
                                <option value="Article" ${content.type == 'Article' ? 'selected' : ''}>Article</option>
                                <option value="Interactive" ${content.type == 'Interactive' ? 'selected' : ''}>Interactive</option>
                            </select>
                        </div>
                        <div class="col-half">
                            <label>Category</label>
                            <select name="category" required>
                                <option disabled ${content.category == null ? 'selected' : ''} value="">Select category</option>
                                <option value="Stress Management" ${content.category == 'Stress Management' ? 'selected' : ''}>Stress Management</option>
                                <option value="Mental Health" ${content.category == 'Mental Health' ? 'selected' : ''}>Mental Health</option>
                                <option value="Wellness" ${content.category == 'Wellness' ? 'selected' : ''}>Wellness</option>
                                <option value="Self-Care" ${content.category == 'Self-Care' ? 'selected' : ''}>Self-Care</option>
                            </select>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" class="short" placeholder="Brief description of the content">${content.description}</textarea>
                    </div>

                    <!-- Main Content -->
                    <div class="form-group">
                        <label>Content</label>
                        <textarea name="contentBody" class="long" placeholder="Enter your content here">${content.contentBody}</textarea>
                    </div>

                    <!-- Bottom Row -->
                    <div class="form-row">
                        <div class="col-third">
                            <label>Difficulty Level</label>
                            <select name="difficulty">
                                <option disabled ${content.difficulty == null ? 'selected' : ''}>Select level</option>
                                <option value="Beginner" ${content.difficulty == 'Beginner' ? 'selected' : ''}>Beginner</option>
                                <option value="Intermediate" ${content.difficulty == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
                                <option value="Advanced" ${content.difficulty == 'Advanced' ? 'selected' : ''}>Advanced</option>
                            </select>
                        </div>
                        <div class="col-third">
                            <label>Duration (minutes)</label>
                            <input type="number" name="duration" value="${content.duration != 0 ? content.duration : 15}">
                        </div>
                        <div class="col-third">
                            <label>Points</label>
                            <input type="number" name="points" value="${content.points != 0 ? content.points : 10}">
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="form-actions">
                        <button type="button" class="btn-submit btn-save-draft" onclick="submitContent('draft')">
                            ${isEdit ? 'Update as Draft' : 'Save as Draft'}
                        </button>
                        <button type="button" class="btn-submit btn-publish" onclick="submitContent('published')">
                            ${isEdit ? 'Update & Publish' : 'Publish'}
                        </button>
                    </div>

                </form>
            </div>
        </div>

        <div class="sidebar-column">
            <div class="ai-card">
                <div class="ai-header">
                    <h3>Ask AI <i class="fas fa-robot" style="color:#00d2d3;"></i></h3>
                </div>
                <div class="ai-input-box">
                    <input type="text" placeholder="Feel free to ask any!">
                    <i class="fas fa-paper-plane"></i>
                </div>
            </div>
        </div>
    </div>

    <script>
        function submitContent(status) {
            document.getElementById('statusInput').value = status;
            var title = document.querySelector('input[name="title"]').value;
            if(!title.trim()) {
                alert("Please enter a title.");
                return;
            }
            document.getElementById('createForm').submit();
        }
    </script>
</body>
</html>