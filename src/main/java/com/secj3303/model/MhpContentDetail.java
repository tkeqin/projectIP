package com.secj3303.model;

public class MhpContentDetail {
    // Basic Info
    private String title;
    private String contentType;     // Video, Article, Interactive
    private String category;        // Stress Management, Wellness, etc.
    
    // Detailed Content
    private String description;     // Short description
    private String contentBody;     // The main long text/HTML
    
    // Metadata
    private String difficultyLevel; // Beginner, Intermediate, Advanced
    private int durationMinutes;
    private int points;
    
    // System fields (for saving later)
    private String status;          // "draft" or "published"

    public MhpContentDetail() {
        // Default constructor for form binding
    }

    public MhpContentDetail(String title, String contentType, String category, String description, 
                            String contentBody, String difficultyLevel, int durationMinutes, int points) {
        this.title = title;
        this.contentType = contentType;
        this.category = category;
        this.description = description;
        this.contentBody = contentBody;
        this.difficultyLevel = difficultyLevel;
        this.durationMinutes = durationMinutes;
        this.points = points;
        this.status = "draft"; // Default to draft
    }

    // Getters and Setters
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContentType() { return contentType; }
    public void setContentType(String contentType) { this.contentType = contentType; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getContentBody() { return contentBody; }
    public void setContentBody(String contentBody) { this.contentBody = contentBody; }

    public String getDifficultyLevel() { return difficultyLevel; }
    public void setDifficultyLevel(String difficultyLevel) { this.difficultyLevel = difficultyLevel; }

    public int getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(int durationMinutes) { this.durationMinutes = durationMinutes; }

    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}