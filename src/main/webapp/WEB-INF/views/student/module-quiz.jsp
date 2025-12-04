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

        /* Tabs */
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

        /* Quiz Styles */
        .question-block {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #f0f0f0;
        }

        .question-block:last-child {
            border-bottom: none;
        }

        .question-text {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .options-list {
            list-style: none;
        }

        .option-item {
            margin-bottom: 10px;
        }

        .option-label {
            display: flex;
            align-items: center;
            cursor: pointer;
            padding: 10px 15px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            transition: background-color 0.2s;
        }

        .option-label:hover {
            background-color: #f9f9f9;
        }

        .option-label input[type="radio"] {
            margin-right: 15px;
            accent-color: #00d2d3;
            transform: scale(1.2);
        }

        /* Results Styling */
        #resultContainer {
            display: none; /* Hidden by default */
            margin-top: 20px;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
        }

        .success-score {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }
        
        .fail-score {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
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

        .btn-submit {
            background-color: #00d2d3; 
            color: white;
        }
        
        .btn-disabled {
            background-color: #bdc3c7;
            cursor: not-allowed;
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

        <!-- Tabs -->
        <div class="tabs-container">
            <div class="tab">Content</div>
            <div class="tab active">Quiz Assessment</div>
        </div>

        <!-- Quiz Form -->
        <form id="quizForm">
            <div class="content-card">
                
                <c:forEach var="q" items="${quizQuestions}" varStatus="status">
                    <div class="question-block" id="qblock-${status.index}">
                        <div class="question-text">${status.index + 1}. ${q.question}</div>
                        
                        <ul class="options-list">
                            <c:forEach var="opt" items="${q.options}" varStatus="optStatus">
                                <li class="option-item">
                                    <label class="option-label">
                                        <!-- Store correct status in data attribute -->
                                        <input type="radio" name="question_${q.id}" value="${optStatus.index}" data-is-correct="${optStatus.index == q.correctIndex}">
                                        ${opt}
                                    </label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>

                <!-- Results Display Area -->
                <div id="resultContainer"></div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/student/education" class="btn btn-save">
                    Cancel & Leave
                </a>

                <button type="button" class="btn btn-submit" onclick="submitQuiz()">
                    Submit Answers
                </button>
            </div>
        </form>
    </div>

    <script>
        function submitQuiz() {
            let totalQuestions = document.querySelectorAll('.question-block').length;
            let correctCount = 0;
            let allAnswered = true;

            // Loop through each question block
            for (let i = 0; i < totalQuestions; i++) {
                let block = document.getElementById('qblock-' + i);
                let selectedOption = block.querySelector('input[type="radio"]:checked');

                // Reset styles
                block.querySelectorAll('.option-label').forEach(lbl => {
                    lbl.style.backgroundColor = ''; 
                    lbl.style.borderColor = '#e0e0e0';
                });

                if (!selectedOption) {
                    allAnswered = false;
                    continue; // Skip grading this one if not answered
                }

                // Check if correct
                let isCorrect = selectedOption.getAttribute('data-is-correct') === 'true';
                
                if (isCorrect) {
                    correctCount++;
                    selectedOption.parentElement.style.backgroundColor = '#d1fae5'; // Green bg
                    selectedOption.parentElement.style.borderColor = '#34d399';
                } else {
                    selectedOption.parentElement.style.backgroundColor = '#fee2e2'; // Red bg
                    selectedOption.parentElement.style.borderColor = '#f87171';
                }
            }

            if (!allAnswered) {
                alert("Please answer all questions before submitting.");
                return;
            }

            // Show Result
            let resultDiv = document.getElementById("resultContainer");
            resultDiv.style.display = "block";
            
            let percentage = (correctCount / totalQuestions) * 100;
            
            if (percentage >= 70) {
                resultDiv.className = "success-score";
                resultDiv.innerHTML = "Great job! You scored " + correctCount + "/" + totalQuestions + " (" + percentage.toFixed(0) + "%). Module Complete!";
            } else {
                resultDiv.className = "fail-score";
                resultDiv.innerHTML = "You scored " + correctCount + "/" + totalQuestions + ". Review the content and try again.";
            }
            
            // Change button text
            document.querySelector('.btn-submit').innerText = "Retake Quiz";
            document.querySelector('.btn-submit').setAttribute("onclick", "location.reload()");
        }
    </script>

</body>
</html>