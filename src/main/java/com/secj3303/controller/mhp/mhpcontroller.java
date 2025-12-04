package com.secj3303.controller.mhp;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.secj3303.model.Role;
import com.secj3303.model.User;
import com.secj3303.model.mhpDashboardContent;
import com.secj3303.model.ContentRepository;

@Controller
@RequestMapping("/mhp")
public class mhpcontroller {

    // --- DASHBOARD ---
    @GetMapping("/content")
    public String showContentManagementPage(Model model, HttpSession session) {
        User user = getUserOrGuest(session);
        if (!isAuthorized(user)) return "redirect:/auth/login";
        
        model.addAttribute("user", user);
        model.addAttribute("contentList", ContentRepository.getAllContent());
        return "/mhp/mhpDashboard"; 
    }

    // --- CREATE PAGE ---
    @GetMapping("/create-content")
    public String showCreateContentPage(Model model, HttpSession session) {
        User user = getUserOrGuest(session);
        if (!isAuthorized(user)) return "redirect:/auth/login";
        
        model.addAttribute("user", user);
        model.addAttribute("isEdit", false); // Signal that this is a NEW creation
        return "/mhp/mhpCreateContent";
    }

    // --- EDIT PAGE (NEW) ---
    @GetMapping("/edit-content")
    public String showEditContentPage(@RequestParam("id") String id, Model model, HttpSession session) {
        User user = getUserOrGuest(session);
        if (!isAuthorized(user)) return "redirect:/auth/login";

        mhpDashboardContent content = ContentRepository.getContentById(id);
        if (content == null) return "redirect:/mhp/content";

        model.addAttribute("user", user);
        model.addAttribute("content", content); // Pass existing data
        model.addAttribute("isEdit", true);     // Signal that this is an EDIT
        return "/mhp/mhpCreateContent";
    }

    // --- DELETE ACTION (NEW) ---
    @GetMapping("/delete-content")
    public String deleteContent(@RequestParam("id") String id, HttpSession session) {
        User user = getUserOrGuest(session);
        if (!isAuthorized(user)) return "redirect:/auth/login";

        ContentRepository.deleteContent(id);
        return "redirect:/mhp/content";
    }

    // --- SAVE / UPDATE ACTION (UPDATED) ---
    @PostMapping("/save-content")
    public String saveContent(
            @RequestParam(value = "id", required = false) String id, // ID is optional (only for edits)
            @RequestParam("title") String title,
            @RequestParam("contentType") String type,
            @RequestParam("category") String category,
            @RequestParam("description") String description,
            @RequestParam("contentBody") String contentBody,
            @RequestParam("difficulty") String difficulty,
            @RequestParam("duration") int duration,
            @RequestParam("points") int points,
            @RequestParam("status") String status) {

        String date = LocalDate.now().toString();

        if (id != null && !id.isEmpty()) {
            // UPDATE EXISTING
            // Preserve original date or update it? Let's keep original ID and Date usually, but here we update date
            mhpDashboardContent updatedContent = new mhpDashboardContent(id, title, status, type, category, date, description, contentBody, difficulty, duration, points);
            ContentRepository.updateContent(updatedContent);
        } else {
            // CREATE NEW
            String newId = UUID.randomUUID().toString().substring(0, 8);
            mhpDashboardContent newContent = new mhpDashboardContent(newId, title, status, type, category, date, description, contentBody, difficulty, duration, points);
            ContentRepository.addContent(newContent);
        }

        return "redirect:/mhp/content";
    }

    @GetMapping("/home")
    public String showMhpHome() { return "redirect:/mhp/content"; }

    // Helpers
    private User getUserOrGuest(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            user = new User(); user.setUsername("guest_mhp"); user.setFullName("Guest MHP"); user.setRole(Role.MENTAL_HEALTH_PROFESSIONAL);
        }
        return user;
    }
    private boolean isAuthorized(User user) {
        return user.getRole() == Role.MENTAL_HEALTH_PROFESSIONAL;
    }
}