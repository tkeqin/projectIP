package com.secj3303.model;

import java.util.ArrayList;
import java.util.List;

public class ContentRepository {
    
    // This static list acts like a database table
    private static final List<mhpDashboardContent> contentStore = new ArrayList<>();

    // Initialize with some dummy data
    static {
        // Using the Constructor 2 (Full fields) so updates work correctly
        contentStore.add(new mhpDashboardContent("1", "Managing Study Stress", "published", "Video", "Stress Management", "2024-01-15", "Learn to manage stress", "Content here...", "Beginner", 15, 10));
        contentStore.add(new mhpDashboardContent("2", "Understanding Anxiety", "draft", "Article", "Mental Health", "2024-01-20", "Anxiety basics", "Content here...", "Intermediate", 10, 5));
        contentStore.add(new mhpDashboardContent("3", "Mindfulness Exercises", "published", "Interactive", "Wellness", "2024-01-10", "Practice mindfulness", "Content here...", "Beginner", 5, 10));
    }

    public static List<mhpDashboardContent> getAllContent() {
        return contentStore;
    }

    public static void addContent(mhpDashboardContent content) {
        contentStore.add(0, content); // Add to top
    }

    // --- NEW METHODS FOR EDIT/DELETE ---

    public static mhpDashboardContent getContentById(String id) {
        for (mhpDashboardContent c : contentStore) {
            if (c.getId().equals(id)) {
                return c;
            }
        }
        return null;
    }

    public static void updateContent(mhpDashboardContent updatedContent) {
        for (int i = 0; i < contentStore.size(); i++) {
            if (contentStore.get(i).getId().equals(updatedContent.getId())) {
                contentStore.set(i, updatedContent);
                return;
            }
        }
    }

    public static void deleteContent(String id) {
        contentStore.removeIf(c -> c.getId().equals(id));
    }
}