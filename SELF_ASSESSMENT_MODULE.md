# Self-Assessment Module Documentation

## Overview
The Self-Assessment Module is a comprehensive mental health assessment system for students. It provides four different types of assessments with personalized feedback and recommendations based on user responses.

## Features

### 1. Assessment Types
The module includes four assessment types:

- **Daily Mood Check** (2 minutes)
  - Tracks emotional state
  - Identifies mood patterns
  - Questions cover: current mood, energy level, social connection, sleep quality, overall satisfaction

- **Stress Assessment** (5 minutes)
  - Evaluates stress levels
  - Identifies stress triggers
  - Questions cover: current stress level, frequency of overwhelm, stress management, daily impact, support system

- **Anxiety Screening** (7 minutes)
  - Understands anxiety symptoms
  - Assesses severity
  - Questions cover: frequency of anxiety, physical symptoms, interference with activities, control over anxiety, severity rating

- **General Wellbeing** (10 minutes)
  - Comprehensive wellness assessment
  - Holistic mental health evaluation
  - Questions cover: physical health, mental health, life satisfaction, sense of purpose, relationships

### 2. User Interface Features
- Clean, intuitive design matching the MindWell brand
- Progress tracking with visual progress bars
- One question per screen to reduce cognitive load
- Radio button selections with hover effects
- Previous/Next navigation buttons
- Mobile-responsive design

### 3. Results Display
After completing an assessment, students see:
- Overall Score (0-25 scale, displayed as percentage)
- Score Category (Excellent, Good, Fair, Poor)
- Personalized Feedback (custom messages based on score and assessment type)
- Wellness Metrics (Engagement %, Consistency %, Progress %)
- Recommended Actions (3-4 personalized recommendations)
- Option to take another assessment or return to dashboard

## File Structure

### Models
```
src/main/java/com/secj3303/model/
├── Assessment.java           - Assessment data model
├── AssessmentResult.java     - Result data model
└── AssessmentService.java    - Business logic for scoring and recommendations
```

### Controllers
```
src/main/java/com/secj3303/controller/student/
└── AssessmentController.java - Handles all assessment routes
```

### Views (JSP)
```
src/main/webapp/WEB-INF/views/student/
├── assessment-list.jsp       - Shows available assessments
├── mood-assessment.jsp       - Daily Mood Check form
├── stress-assessment.jsp     - Stress Assessment form
├── anxiety-assessment.jsp    - Anxiety Screening form
├── wellbeing-assessment.jsp  - General Wellbeing form
└── assessment-result.jsp     - Results display page
```

## API Routes

### Assessment Selection
- `GET /student/assessment/` - Shows list of available assessments

### Individual Assessments
- `GET /student/assessment/mood` - Daily Mood Check form
- `GET /student/assessment/stress` - Stress Assessment form
- `GET /student/assessment/anxiety` - Anxiety Screening form
- `GET /student/assessment/wellbeing` - General Wellbeing form

### Submission & Results
- `POST /student/assessment/submit` - Submit assessment and get results
- `GET /student/assessment/results` - View last assessment results

## Assessment Scoring System

### Scoring Algorithm
1. Each question has 5 answer options (1-5 scale)
2. Total score = Sum of all answers
3. Average score = (Total Score × 100) / (Number of Questions × 5)
4. Final Score = 0-100 range

### Score Categories
- **Excellent** (70-100): Excellent well-being status
- **Good** (50-69): Good well-being status
- **Fair** (30-49): Fair well-being status
- **Poor** (0-29): Poor well-being status

## Personalized Feedback

### Feedback System
The system provides personalized feedback based on:
1. Assessment Type (mood, stress, anxiety, or wellbeing)
2. Score Category (Excellent, Good, Fair, Poor)

Examples:
- **Mood - Excellent**: "You're in an excellent emotional state. Keep up the positive momentum and continue your wellness practices."
- **Stress - Poor**: "Your stress levels are concerning. Please seek professional support and consider counseling sessions."
- **Anxiety - Fair**: "You're experiencing moderate anxiety. Exploring more coping strategies could be beneficial."
- **Wellbeing - Good**: "Your wellbeing is good overall. Small improvements in certain areas could enhance your experience."

## Recommendations System

### Recommendation Categories
Each assessment type generates specific recommendations:

**Mood Assessment:**
- For Excellent/Good: Continue practices, explore coping, share strategies
- For Fair/Poor: Track mood, practice meditation, connect with community

**Stress Assessment:**
- For Excellent/Good: Maintain routine, learn techniques, help peers
- For Fair/Poor: Practice breathing, take breaks, consider counseling

**Anxiety Assessment:**
- For Excellent/Good: Continue strategies, explore mindfulness, share techniques
- For Fair/Poor: Practice grounding, exercise regularly, schedule counseling

**Wellbeing Assessment:**
- For Excellent/Good: Continue practices, explore techniques, share strategies
- For Fair/Poor: Prioritize sleep/exercise, maintain diet, seek support

## Wellness Metrics

The results display three dynamic metrics:
- **Engagement**: Percentage showing user's level of participation
- **Consistency**: Percentage showing consistency in wellness practices
- **Progress**: Percentage showing progress in wellness journey

These metrics are generated dynamically (60-90% range) and update on each assessment.

## Integration with Student Dashboard

The assessment module integrates with the student home page through:
1. Quick Action button: "Take Assessment" → `/student/assessment/`
2. Session storage of last assessment result
3. Dashboard widgets can display assessment data

## Data Flow

```
1. Student clicks "Take Assessment" on dashboard
2. Assessment list page loads (/student/assessment/)
3. Student selects an assessment type
4. Assessment form loads (mood, stress, anxiety, or wellbeing)
5. Student answers 5 questions (one per screen)
6. Student clicks Submit
7. AssessmentController processes responses
8. AssessmentService calculates score and generates feedback
9. Results page displays with personalized content
10. Student can take another assessment or return to dashboard
```

## User Experience Flow

```
Student Home
    ↓
Take Assessment Button
    ↓
Assessment Selection Page
    ├── Daily Mood Check (2 min)
    ├── Stress Assessment (5 min)
    ├── Anxiety Screening (7 min)
    └── General Wellbeing (10 min)
    ↓
Assessment Form (5 questions)
    ├── Question 1 → Next
    ├── Question 2 → Next
    ├── Question 3 → Next
    ├── Question 4 → Next
    ├── Question 5 → Submit
    ↓
Assessment Results
    ├── Overall Score
    ├── Score Category
    ├── Personalized Feedback
    ├── Wellness Metrics
    ├── Recommended Actions
    ├── Take Another Assessment
    └── Return to Dashboard
```

## Accessibility Features

- Keyboard navigation (Arrow keys for previous/next)
- Enter key to submit
- Proper label associations with form inputs
- Clear visual hierarchy
- High contrast colors for readability
- Mobile-responsive design
- Semantic HTML structure

## Future Enhancements

Potential features to add:
1. Database storage of assessment history
2. Trending visualization over time
3. Comparison between assessments
4. Export results as PDF
5. Share results with counselors
6. Integration with calendar for reminders
7. Progress tracking dashboard
8. Peer comparison (anonymous)
9. Integration with AI chatbot for immediate support
10. Automated alerts for concerning scores

## Session Management

Assessment results are stored in the HttpSession:
- `lastAssessmentResult`: The AssessmentResult object
- `lastAssessmentType`: The type of assessment (mood, stress, anxiety, wellbeing)

This allows users to view their results at any time during their session.

## Technical Stack

- **Backend**: Spring MVC, Java 17
- **Frontend**: HTML5, CSS3, JavaScript (vanilla)
- **Template Engine**: JSP with JSTL
- **Build**: Maven
- **Architecture**: MVC Pattern

## Security Considerations

- Session-based authentication required
- User data not persisted (demo version)
- HTTPS recommended for production
- Input validation on assessment answers
- CSRF protection (Spring Security)

## Testing the Module

### Test Scenarios

1. **Happy Path**: 
   - Navigate to assessments → Select Mood Check → Answer questions → Submit → View results

2. **Navigation**: 
   - Use Previous button to go back
   - Use keyboard arrows to navigate
   - Test on mobile device

3. **Edge Cases**:
   - Try submitting without selecting answers (should show alert)
   - Test on different browsers
   - Check responsive design

4. **Results Accuracy**:
   - Verify score calculation
   - Check feedback accuracy for different categories
   - Validate recommendations match assessment type

## How to Access

1. **From Student Home**: Click "Take Assessment" button
2. **Direct URL**: `http://localhost:8080/healthhubutm/student/assessment/`
3. **After Login**: Student role required

## Notes

- The module uses hardcoded feedback and recommendations (can be moved to database)
- Wellness metrics are randomly generated (can be based on actual user history)
- Results are session-based (not persisted to database in this version)
- Assessment history is not tracked (future enhancement)
