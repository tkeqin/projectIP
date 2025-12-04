// package com.secj3303.controller.student;

// import javax.servlet.http.HttpSession;
// import java.util.ArrayList;
// import java.util.List;

// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RequestParam;

// import com.secj3303.model.ChatbotModel;
// import com.secj3303.model.EducationalModule; // Import the new model
// import com.secj3303.model.User;

// @Controller
// @RequestMapping("/student")
// public class studentcontroller {

//     // --- STUDENT HOME PAGE (GET) ---
//     @GetMapping("/home")
//     public String showStudentHomePage(Model model, HttpSession session) {
        
//         // Retrieve the logged-in user from the session
//         User loggedInUser = (User) session.getAttribute("loggedInUser");
        
//         if (loggedInUser == null) {
//             // If no user is logged in, redirect to the login page
//             return "redirect:/auth/login";
//         }

//         // Add the logged-in user to the model
//         model.addAttribute("user", loggedInUser);
        
//         // Render the student homepage
//         return "/student/peer";  // => /WEB-INF/views/student/home.jsp
//     }

//     // --- STUDENT PROFILE PAGE (GET) ---
//     @GetMapping("/profile")
//     public String showStudentProfilePage(Model model, HttpSession session) {
        
//         // Retrieve the logged-in user from the session
//         User loggedInUser = (User) session.getAttribute("loggedInUser");
        
//         if (loggedInUser == null) {
//             // If no user is logged in, redirect to the login page
//             return "redirect:/auth/login";
//         }

//         // Add the logged-in user details to the model
//         model.addAttribute("user", loggedInUser);
        
//         // Render the student profile page
//         return "/student/profile";  // => /WEB-INF/views/student/profile.jsp
//     }

//     // --- STUDENT DASHBOARD PAGE (GET) ---
//     @GetMapping("/dashboard")
//     public String showStudentDashboardPage(Model model, HttpSession session) {
        
//         // Retrieve the logged-in user from the session
//         User loggedInUser = (User) session.getAttribute("loggedInUser");
        
//         if (loggedInUser == null) {
//             // If no user is logged in, redirect to the login page
//             return "redirect:/auth/login";
//         }

//         // Add the logged-in user and other necessary data to the model
//         model.addAttribute("user", loggedInUser);
        
//         // Render the student dashboard page
//         return "/student/dashboard";  // => /WEB-INF/views/student/dashboard.jsp
//     }

//     // --- STUDENT LOGOUT (GET) ---
//     @GetMapping("/logout")
//     public String studentLogout(HttpSession session) {
//         session.invalidate();  // Invalidate the session to log out
//         return "redirect:/auth/login";  // Redirect to the login page
//     }

//     // --- NEW POST PAGE (GET) ---
//     @GetMapping("/new-post")
//     public String showNewPostPage(Model model) {
//         // Add model attributes if needed
//         return "/student/new-post"; // Resolves to /WEB-INF/views/student/new-post.jsp
//     }

//     private ChatbotModel chatbotModel = new ChatbotModel();

//     @GetMapping("/chatbot")
//     public String showChatbotPage(Model model) {
//         // Static data for chatbot responses
//         model.addAttribute("chatbotResponses", chatbotModel.getResponse("default"));
//         return "/student/chatbot"; 
//     }

//     // Method to handle sending messages (in the case of dynamic user input)
//     @PostMapping("/chatbot")
//     public String handleUserMessage(@RequestParam("userMessage") String userMessage, Model model) {
//         // Get the chatbot response based on user message
//         String botResponse = chatbotModel.getResponse(userMessage);

//         model.addAttribute("chatbotResponses", botResponse);
//         return "/student/chatbot";
//     }

//      // --- EDUCATIONAL MODULES PAGE (GET) ---
//     @GetMapping("/education")
//     public String showEducationPage(Model model, HttpSession session) {
//         User loggedInUser = (User) session.getAttribute("loggedInUser");
//         if (loggedInUser == null) {
//             return "redirect:/auth/login";
//         }
//         model.addAttribute("user", loggedInUser);

//         // Create the dummy data to match your screenshot
//         List<EducationalModule> modules = new ArrayList<>();
        
//         modules.add(new EducationalModule("1", "Understanding Mental Health", 
//             "Introduces students to the basics of mental health, its importance, and how it affects daily life.", 
//             "2 min", "fas fa-heartbeat", "/student/module/1"));
            
//         modules.add(new EducationalModule("2", "Recognizing Signs and Symptoms", 
//             "Helps students identify early warning signs and understand common mental health challenges.", 
//             "10 min", "fas fa-chart-line", "/student/module/2"));
            
//         modules.add(new EducationalModule("3", "Coping Strategies and Self Care", 
//             "Focuses on practical ways to manage stress and maintain mental balance.", 
//             "7 min", "fas fa-spa", "/student/module/3"));
            
//         modules.add(new EducationalModule("4", "Supporting Peers and Building Empathy", 
//             "Builds skills to support friends and create a caring, stigma-free environment.", 
//             "15 min", "fas fa-check-circle", "/student/module/4"));

//         model.addAttribute("modules", modules);

//         return "/student/education"; // Resolves to /WEB-INF/views/student/education.jsp
//     }

// }


package com.secj3303.controller.student;

import javax.servlet.http.HttpSession;
import java.util.ArrayList; // Added for List
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;      // Added for List
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.secj3303.model.ChatbotModel;
import com.secj3303.model.EducationalModule; // Import the new model
import com.secj3303.model.User;
import com.secj3303.model.Role; // Import Role for dummy user

@Controller
@RequestMapping("/student")
public class studentcontroller {

    // --- STUDENT HOME PAGE (GET) ---
    @GetMapping("/home")
    public String showStudentHomePage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }
        model.addAttribute("user", loggedInUser);
        return "/student/peer"; 
    }

// --- EDUCATIONAL MODULES DASHBOARD ---
    @GetMapping("/education")
    public String showEducationPage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            loggedInUser = new User("guest", "guest", "Guest User", "guest@example.com", Role.STUDENT);
        }
        model.addAttribute("user", loggedInUser);

        List<EducationalModule> modules = new ArrayList<>();
        modules.add(new EducationalModule("1", "Understanding Mental Health", "Introduces students to the basics of mental health.", "2 min", "fas fa-heartbeat", "/student/module/1"));
        modules.add(new EducationalModule("2", "Recognizing Signs and Symptoms", "Helps students identify early warning signs.", "10 min", "fas fa-chart-line", "/student/module/2"));
        modules.add(new EducationalModule("3", "Coping Strategies and Self Care", "Focuses on practical ways to manage stress.", "7 min", "fas fa-spa", "/student/module/3"));
        modules.add(new EducationalModule("4", "Supporting Peers", "Builds skills to support friends.", "15 min", "fas fa-check-circle", "/student/module/4"));

        model.addAttribute("modules", modules);
        return "/student/education";
    }

    // --- SPECIFIC MODULE CONTENT PAGE ---
    @GetMapping("/module/{moduleId}")
    public String showModuleContent(@PathVariable String moduleId, 
                                    @RequestParam(defaultValue = "1") int page, 
                                    Model model, 
                                    HttpSession session) {
        
        model.addAttribute("moduleId", moduleId);
        model.addAttribute("currentPage", page);
        model.addAttribute("nextPage", page + 1);

        // --- MODULE 1: Text Based (Restored Content) ---
        if ("1".equals(moduleId)) {
            model.addAttribute("moduleTitle", "Understanding Mental Health");
            model.addAttribute("moduleSubtitle", "Introduces students to the basics of mental health, its importance, and it affects daily life.");

            Map<String, String> content = new HashMap<>();
            if (page == 1) {
                // Restored full content
                content.put("html", 
                    "<h3>1.1 Definition of Mental Health</h3>" +
                    "<p>Mental health refers to a state of emotional, psychological, and social well-being in which a person can use their abilities, cope with normal stresses, work productively, and contribute to their community.</p>" +
                    "<h3>1.2 Importance of Mental Health</h3>" +
                    "<p>Good mental health allows us to: Think clearly, make good decisions, and build healthy relationships.</p>" +
                    "<ul><li>Build healthy relationships with friends, family, and peers.</li><li>Handle academic and life challenges with resilience.</li><li>Stay motivated and confident.</li></ul>" +
                    "<h3>1.3 Common Myths and Misconceptions</h3>" +
                    "<p>There are many misunderstandings about mental health that create stigma. One common myth is that mental health problems only affect weak people. In reality, they can happen to anyone.</p>" +
                    "<h3>1.4 Why Mental Health Matters for Students</h3>" +
                    "<p>University life is an exciting phase filled with new opportunities, but it also brings stress from academic pressure and social adjustments.</p>"
                );
            } else if (page == 2) {
                 // Additional pages can be added here if needed
                 content.put("html", 
                    "<h3>2.0 Factors Affecting Mental Health</h3>" +
                    "<p>Mental health is shaped by a complex interaction of biological, psychological, and social factors.</p>" +
                    "<h3>2.1 Biological Factors</h3>" +
                    "<p>Biological factors include genetic, neurological, and physical components.</p>" +
                    "<h3>2.2 Psychological Factors</h3>" +
                    "<p>Psychological factors refer to internal emotional processes, coping styles, and thought patterns.</p>"
                 );
            } else {
                 content.put("html", "<h3>Conclusion</h3><p>You have completed this module.</p>");
            }
            model.addAttribute("contentHtml", content.get("html"));
            return "/student/module-content"; 
        }

        // --- MODULE 2: Video Based ---
        else if ("2".equals(moduleId)) {
            model.addAttribute("moduleTitle", "Recognizing Signs and Symptoms");
            model.addAttribute("moduleSubtitle", "Watch this guided session to learn how to identify early warning signs.");
            model.addAttribute("videoUrl", "https://www.youtube.com/embed/1i9OktVk5VE"); 
            return "/student/module-video"; 
        }

        // --- MODULE 3: Coping Strategies (Text Content + Quiz) ---
        else if ("3".equals(moduleId)) {
            model.addAttribute("moduleTitle", "Coping Strategies and Self Care");
            model.addAttribute("moduleSubtitle", "Focuses on practical ways to manage stress and maintain mental balance.");

            // Page 1: Text Content (Using module-content.jsp)
            if (page == 1) {
                String htmlContent = 
                    "<h3>Understanding Stress Management</h3>" +
                    "<p>Stress is a natural reaction to life's challenges, but chronic stress can harm your health. Effective management involves identifying triggers and using positive coping mechanisms.</p>" +
                    "<h3>Healthy Coping Mechanisms</h3>" +
                    "<ul>" +
                    "<li><strong>Mindfulness & Meditation:</strong> Staying present can reduce anxiety.</li>" +
                    "<li><strong>Physical Activity:</strong> Exercise releases endorphins that boost mood.</li>" +
                    "<li><strong>Social Support:</strong> Talking to trusted friends or counselors helps process emotions.</li>" +
                    "</ul>" +
                    "<h3>Self-Care Essentials</h3>" +
                    "<p>Self-care isn't a luxury; it's necessary maintenance. Prioritize sleep (7-9 hours), eat balanced meals, and take breaks when studying.</p>";
                
                model.addAttribute("contentHtml", htmlContent);
                return "/student/module-content";
            } 
            // Page 2: Quiz (Using module-quiz.jsp)
            else {
                // Quiz Data
                List<Map<String, Object>> quizQuestions = new ArrayList<>();
                
                Map<String, Object> q1 = new HashMap<>();
                q1.put("id", 1);
                q1.put("question", "Which of the following is considered a healthy coping strategy for academic stress?");
                q1.put("options", Arrays.asList("Pulling an all-nighter with energy drinks", "Practicing mindfulness and deep breathing", "Isolating yourself from friends", "Skipping meals to save time"));
                q1.put("correctIndex", 1); 
                quizQuestions.add(q1);

                Map<String, Object> q2 = new HashMap<>();
                q2.put("id", 2);
                q2.put("question", "True or False: Self-care is selfish and should only be done when you have free time.");
                q2.put("options", Arrays.asList("True", "False"));
                q2.put("correctIndex", 1); 
                quizQuestions.add(q2);

                Map<String, Object> q3 = new HashMap<>();
                q3.put("id", 3);
                q3.put("question", "If you notice a friend withdrawing socially and acting differently, what is the best approach?");
                q3.put("options", Arrays.asList("Ignore them until they come to you", "Tell them to 'cheer up'", "Ask them gently how they are doing and listen", "Post about it on social media"));
                q3.put("correctIndex", 2); 
                quizQuestions.add(q3);

                model.addAttribute("quizQuestions", quizQuestions);
                model.addAttribute("moduleSubtitle", "Test your knowledge on healthy coping mechanisms and self-care practices.");
                return "/student/module-quiz";
            }
        }

        return "redirect:/student/education";
    }

    // --- STUDENT PROFILE PAGE (GET) ---
    @GetMapping("/profile")
    public String showStudentProfilePage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }
        model.addAttribute("user", loggedInUser);
        return "/student/profile";
    }

    // --- STUDENT DASHBOARD PAGE (GET) ---
    @GetMapping("/dashboard")
    public String showStudentDashboardPage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }
        model.addAttribute("user", loggedInUser);
        return "/student/dashboard";
    }

    // --- STUDENT LOGOUT (GET) ---
    @GetMapping("/logout")
    public String studentLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }

    // --- NEW POST PAGE (GET) ---
    @GetMapping("/new-post")
    public String showNewPostPage(Model model) {
        return "/student/new-post";
    }

    private ChatbotModel chatbotModel = new ChatbotModel();

    @GetMapping("/chatbot")
    public String showChatbotPage(Model model) {
        model.addAttribute("chatbotResponses", chatbotModel.getResponse("default"));
        return "/student/chatbot"; 
    }

    @PostMapping("/chatbot")
    public String handleUserMessage(@RequestParam("userMessage") String userMessage, Model model) {
        String botResponse = chatbotModel.getResponse(userMessage);
        model.addAttribute("chatbotResponses", botResponse);
        return "/student/chatbot";
    }
}
