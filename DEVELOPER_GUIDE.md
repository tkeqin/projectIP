# Self-Assessment Module - Developer Implementation Guide

## Architecture Overview

The Self-Assessment Module follows the MVC (Model-View-Controller) pattern:

```
REQUEST FLOW:
Student → Browser → Spring Controller → Service → Model → View → Browser
                       (Routes)         (Logic)   (Data)   (JSP)
```

## Component Breakdown

### 1. Models (com.secj3303.model)

#### Assessment.java
- **Purpose**: Represents a single assessment attempt
- **Key Fields**:
  - `assessmentId`: Unique identifier
  - `username`: Student who took the assessment
  - `assessmentType`: Type (mood, stress, anxiety, wellbeing)
  - `score`: Raw score (0-25)
  - `category`: Category (Excellent, Good, Fair, Poor)
  - `feedback`: Personalized feedback text
  - `completedAt`: Timestamp
  - `recommendations`: Array of recommendations

#### AssessmentResult.java
- **Purpose**: Contains processed assessment results
- **Key Components**:
  - `overallScore`: Calculated percentage (0-100)
  - `category`: Classification
  - `feedback`: Personalized message
  - `recommendedActions`: Array of action strings
  - `AssessmentMetrics`: Inner class containing engagement, consistency, progress percentages

#### AssessmentService.java
- **Purpose**: Business logic for assessment processing
- **Key Methods**:
  - `calculateResult()`: Main calculation method
    ```java
    public static AssessmentResult calculateResult(String assessmentType, int[] answers)
    ```
  - `categorizeScore()`: Assigns category based on score
  - `getFeedback()`: Returns personalized feedback
  - `getRecommendations()`: Returns specific recommendations
  - Metric generators: `generateEngagementScore()`, `generateConsistencyScore()`, `generateProgressScore()`

### 2. Controllers (com.secj3303.controller.student)

#### AssessmentController.java
- **Request Mapping**: `/student/assessment`
- **Key Endpoints**:

| Route | Method | Purpose |
|-------|--------|---------|
| `/` | GET | Show assessment selection page |
| `/mood` | GET | Show mood assessment form |
| `/stress` | GET | Show stress assessment form |
| `/anxiety` | GET | Show anxiety assessment form |
| `/wellbeing` | GET | Show wellbeing assessment form |
| `/submit` | POST | Process assessment and return results |
| `/results` | GET | View last assessment results |

**Authentication**: All endpoints check for logged-in user and redirect to login if needed

### 3. Views (src/main/webapp/WEB-INF/views/student)

#### assessment-list.jsp
- Landing page for assessments
- Displays 4 assessment cards with duration and description
- Grid layout (responsive, 1-4 columns)
- Integration point: Student clicks to start an assessment

#### mood-assessment.jsp / stress-assessment.jsp / anxiety-assessment.jsp / wellbeing-assessment.jsp
- Assessment form pages
- 5 questions presented one at a time
- Progress bar showing completion percentage
- Radio button selections with styling
- Previous/Next navigation
- Form submits to `/student/assessment/submit` with `assessmentType` and `answers[]`

#### assessment-result.jsp
- Results display page
- Shows:
  - Success checkmark animation
  - Overall score with category
  - Wellness metrics with animated bars
  - Personalized feedback
  - Recommended actions list
  - Navigation buttons (Take Another / Return to Dashboard)

## Data Flow in Detail

### 1. Assessment Selection Flow
```
GET /student/assessment/
↓
AssessmentController.showAssessmentPage()
↓
Add user to model
↓
Return assessment-list.jsp
↓
Display 4 assessment cards
```

### 2. Assessment Form Flow
```
GET /student/assessment/[type]
↓
AssessmentController.show[Type]Assessment()
↓
Add user, assessmentType, duration to model
↓
Return [type]-assessment.jsp
↓
Display form with 5 questions (one per screen)
```

### 3. Assessment Submission Flow
```
POST /student/assessment/submit
(assessmentType=mood, answers=[5,4,3,2,5])
↓
AssessmentController.submitAssessment()
↓
Convert string array to int array: [5,4,3,2,5]
↓
Call AssessmentService.calculateResult(assessmentType, answers)
↓
Service returns AssessmentResult object
↓
Store result in session
↓
Add to model (score, category, feedback, recommendations, metrics)
↓
Return assessment-result.jsp
↓
Display results with animations
```

## Scoring Algorithm Details

### Step 1: Collect Answers
```java
String[] answersStr = {"5", "4", "3", "2", "5"};
int[] answers = {5, 4, 3, 2, 5};
```

### Step 2: Calculate Total
```java
totalScore = 5 + 4 + 3 + 2 + 5 = 19
```

### Step 3: Convert to Percentage
```java
overallScore = (19 * 100) / (5 * 25)
            = 1900 / 125
            = 15.2 (rounded to 15)
```

### Step 4: Categorize
```java
if (15 >= 70) → "Excellent"
else if (15 >= 50) → "Good"
else if (15 >= 30) → "Fair"
else → "Poor"  // Result: "Poor"
```

### Step 5: Generate Feedback
```java
feedback = getFeedback("mood", "Poor", 15);
// Returns: "Your mood needs immediate attention..."
```

### Step 6: Generate Recommendations
```java
recommendations = getRecommendations("mood", "Poor");
// Returns: ["Practice daily mood tracking", "Try guided meditation", ...]
```

## Session Management

Assessment results are stored in HttpSession:
```java
// Storing
session.setAttribute("lastAssessmentResult", result);
session.setAttribute("lastAssessmentType", "mood");

// Retrieving
AssessmentResult result = (AssessmentResult) session.getAttribute("lastAssessmentResult");
String type = (String) session.getAttribute("lastAssessmentType");
```

## Frontend Interactivity

### Question Navigation (mood-assessment.jsp)
```javascript
let currentQuestion = 1;
const totalQuestions = 5;

function nextQuestion() {
    const selected = document.querySelector('input[name="answers"]:checked');
    if (!selected) {
        alert('Please select an answer');
        return;
    }
    
    if (currentQuestion === totalQuestions) {
        document.getElementById('assessmentForm').submit();
    } else {
        currentQuestion++;
        updateUI();
    }
}

function updateUI() {
    // Update progress bar
    const progressPercent = (currentQuestion / totalQuestions) * 100;
    document.querySelector('.progress-fill').style.width = progressPercent + '%';
    
    // Show/hide questions
    document.querySelectorAll('.question-container').forEach((q, index) => {
        q.style.display = index + 1 === currentQuestion ? 'block' : 'none';
    });
}
```

### Keyboard Navigation
```javascript
document.addEventListener('keydown', function(e) {
    if (e.key === 'Enter' || e.key === 'ArrowRight') {
        nextQuestion();
    } else if (e.key === 'ArrowLeft') {
        prevQuestion();
    }
});
```

### Animations (CSS)
```css
@keyframes popIn {
    0% { opacity: 0; transform: scale(0); }
    50% { transform: scale(1.1); }
    100% { opacity: 1; transform: scale(1); }
}

.checkmark {
    animation: popIn 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}
```

## Integration Points

### 1. Student Home Page
The home page includes a quick action button that links to assessments:
```javascript
'assessment': '/student/assessment/'  // In handleQuickAction()
```

### 2. Session Attributes
The assessment stores results in session for later retrieval:
- `lastAssessmentResult`: Full result object
- `lastAssessmentType`: Assessment type name

### 3. Model Attributes
Results are added to the model for JSP rendering:
- `user`: Logged-in student
- `score`: Overall score percentage
- `category`: Score category
- `feedback`: Personalized feedback
- `recommendations`: Array of recommendations
- `metrics`: Object containing engagement, consistency, progress

## Customization Options

### 1. Adding New Assessment Types
```java
// 1. Add question set to appropriate assessment JSP
// 2. Add case in AssessmentService:
public static String getFeedback(String assessmentType, String category, int score) {
    if ("newType".equals(assessmentType)) {
        // Add feedback map
    }
}
```

### 2. Modifying Scoring Thresholds
```java
// In categorizeScore() method
private static String categorizeScore(int score) {
    if (score >= 80) { // Changed from 70
        return "Excellent";
    }
    // ...
}
```

### 3. Customizing Feedback
Update the HashMap values in `getFeedback()` method:
```java
excellentFeedback.put("mood", "Your custom feedback message here");
```

### 4. Customizing Recommendations
Update the `getRecommendations()` method:
```java
if ("customType".equals(assessmentType)) {
    return new String[] {
        "New recommendation 1",
        "New recommendation 2",
        "New recommendation 3"
    };
}
```

## Error Handling

### User Not Logged In
```java
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser == null) {
    return "redirect:/auth/login";
}
```

### Missing Assessment Type
```java
String assessmentType = request.getParameter("assessmentType");
if (assessmentType == null || assessmentType.isEmpty()) {
    return "redirect:/student/assessment/";
}
```

### Invalid Answers
```java
if (answersStr == null || answersStr.length == 0) {
    // Handle with default values
    answers = new int[0];
}
```

## Testing Checklist

- [ ] Can access assessment list page
- [ ] All 4 assessment types load correctly
- [ ] Can navigate through questions with buttons
- [ ] Can navigate with keyboard arrows
- [ ] Submit button works and submits form
- [ ] Results page displays correctly
- [ ] Score calculation is accurate
- [ ] Feedback is personalized
- [ ] Recommendations are relevant
- [ ] Metrics display with animations
- [ ] Can take another assessment
- [ ] Can return to dashboard
- [ ] Mobile responsive design works
- [ ] No compilation errors
- [ ] Session management works

## Performance Considerations

- JSPs use JSTL for efficient templating
- No database queries (session-based)
- All calculations done in memory
- Minimal network overhead
- Client-side navigation animations
- CSS animations use GPU-accelerated transforms

## Security Considerations

- Session-based authentication
- User validation on each request
- Input validation for form submissions
- HTTPS recommended for production
- Session timeout handling
- CSRF token protection (Spring Security)

## Future Enhancements

1. **Database Persistence**
   - Store assessment history
   - Track trends over time
   - Generate reports

2. **Advanced Analytics**
   - Visualize assessment trends
   - Compare with previous assessments
   - Identify patterns

3. **Integration**
   - Email results to counselor
   - Share with accountability partner
   - Calendar reminders for assessments

4. **Personalization**
   - Adaptive questions based on responses
   - Custom assessment templates
   - Progress-based recommendations

## Deployment Notes

1. Ensure all model files are compiled
2. Verify JSP views are in correct directory
3. Check Spring configuration includes component scanning
4. Test on target application server
5. Verify session configuration
6. Test with multiple concurrent users

## Support & Troubleshooting

**Assessment page won't load:**
- Check if user is logged in
- Verify user role is "STUDENT"
- Check browser console for JS errors

**Results not displaying:**
- Verify form was submitted with assessmentType
- Check AssessmentService logic
- Verify model attributes are set

**Questions not appearing:**
- Check CSS display properties
- Verify JavaScript is enabled
- Check question-container divs in JSP

**Styling issues:**
- Check CSS variable definitions
- Verify responsive breakpoints
- Test on different screen sizes
