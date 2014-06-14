---
title       : ShinyApp for calculating of cummulative grade point average (CGPA).
subtitle    : Predicition based on CGPA
author      : Satyendra Kumar
job         : Research
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---
## Slide 2

### About the ShinyApp: 

    1. A shiny app is degined which takes input in the form of marks from the users.
    2. The marks is converted into CGPA.
    3. Using formula CGPA = marks/9.5, CGPA is calculated.
    4. Based on the CGPA grades a prediction is made.  
    5. Prediction suggest three outcomes based on the marks entered.
    6. Try again if marks less than 70,
    7. If marks entered is between  70 to 90, suggest that you passed, good job
    8. If marks above 90, results in distinction and suggest you are genius.

--- 
## Slide 3
### How to use shinyAPP:

    1. Please use input box to input your number.
    2. Press submit button to see your actual CGPA grades and perdiction.


--- 
## Slide 3

### Demo
<div class="row-fluid">
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12" style="padding: 10px 0px;">
        <h1>CGPA calculator and predictor</h1>
      </div>
    </div>
    <div class="row-fluid">
      <div class="span4">
        <form class="well">
          <label for="marks">Please enter your marks</label>
          <input id="marks" type="number" value="70" min="50" max="100" step="1"/>
          <div>
            <button type="submit" class="btn btn-primary">Submit</button>
          </div>
        </form>
      </div>
      <div class="span8">
        <h3>Cumulative Grade Point Average (CGPA) value</h3>
        <h4>You entered </h4>
        <pre id="inputValue" class="shiny-text-output"></pre>
        <h4>Your CGPA grades and prediction </h4>
        <pre id="prediction" class="shiny-text-output"></pre>
      </div>
    </div>
  </div>
</div>





--- 
## Slide 4

### Limitations

    1. Very simple with very less sophistication.
    2. Not very much interactive.
    3. Have limited ability




--- 
## Slide 5

### Improvments

    1. The app can be improved by including several features.
    2. Could be make more interactive.
    3. Can be made more diverse.





