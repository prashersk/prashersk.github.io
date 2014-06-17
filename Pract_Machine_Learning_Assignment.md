Practicle machine learning Assignment
===

Background:
===
Recently, lot of interest has emerge as how well a person does a perticular activity. The idea is to help improve individual health based on quantity and quality of the activity. The aim of current analysis is to predict the quality of the exercise. This is the "classe" variable in the training set. This "classe" variable is used for prediction. This analysis include a report describing building the model, cross validation and out of sample error. I have also use below described prediction model to predict 20 different test cases. I found all predictions to be true i.e. 20/20 (Part 2). 

Data: 
===
The training data: 
https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

The test data: 
https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

(source: http://groupware.les.inf.puc-rio.br/har)

Analysis:
===

Step 1: Download the data
===

```r
# Download the training data
if(!file.exists("pml-training.csv")) {
    URL <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
    PATH <- "/Users/satyendrakumar/"
    FILE <- "./pml-training.csv"
    down <- download.file(paste(URL, PATH, FILE, sep = ""), FILE, method = "curl")   
}

# Download the testing data
if(!file.exists("pml-testing.csv")) {
    URL <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
    PATH <- "/Users/satyendrakumar/"
    FILE <- "./pml-testing.csv"
    down <- download.file(paste(URL, PATH, FILE, sep = ""), FILE, method = "curl")   
}
```

Step 2: Load or read the data and clean it for further analysis
===

```r
# Read the training data
train_Data <- read.csv("pml-training.csv", na.strings = c("NA",""), header = TRUE)
dim(train_Data)
```

```
## [1] 19622   160
```

```r
# Cleanup the training data for NAs
RemoveNA <- apply(train_Data, 2, function(na) {sum(is.na(na))})
Data <- train_Data[, which(RemoveNA == 0)]

# discards unuseful predictors
removeIndex <- grep("timestamp|X|user_name|new_window|num_window",names(Data))
myData <- Data[,-removeIndex]
```


Step 3: Subset the original training dataset.
===

```r
# I have divided the actual training data in training(70%) and vaidation (30%)
# The subset of training (actual 70%) was further subset into training (75%) and test (25%).
library(caret)
```

```
## Loading required package: lattice
## Loading required package: ggplot2
```

```r
set.seed(1000)
trainI <- createDataPartition(y = myData$classe, p = .70, list= FALSE) 
trainingData <-  myData[trainI, ]
ValidatinData <- myData[-trainI, ]
training <- createDataPartition(y = trainingData$classe, p = .75, list= FALSE)
trainS <-  trainingData[training, ]
testingS <- trainingData[-training, ]
dim(trainS)
```

```
## [1] 10304    53
```

Step 4: Use Random Forest method for the model
===

```r
library(randomForest)
```

```
## randomForest 4.6-7
## Type rfNews() to see new features/changes/bug fixes.
```

```r
modFit <- train(trainS$classe ~., data = trainS, 
                method="rf", 
                prox = TRUE, 
                trControl = trainControl(method = "cv", number = 4))

# Plot the model.
plot(modFit, log="y")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

```r
modFit
```

```
## Random Forest 
## 
## 10304 samples
##    52 predictors
##     5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Cross-Validated (4 fold) 
## 
## Summary of sample sizes: 7729, 7726, 7729, 7728 
## 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy  Kappa  Accuracy SD  Kappa SD
##   2     1         1      0.004        0.005   
##   30    1         1      0.002        0.003   
##   50    1         1      0.004        0.005   
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 2.
```

Step 5: Use the small testing (subset training) data for prediction.
===

```r
myPredictionS <- predict(modFit, newdata= testingS)

# Use confusionMatrix method for calculating accuracy and out of sample error
cm <- confusionMatrix(myPredictionS, testingS$classe)
cm$overall[1]
```

```
## Accuracy 
##   0.9869
```

```r
cm
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction   A   B   C   D   E
##          A 975   6   0   0   0
##          B   1 654  13   0   0
##          C   0   4 585  14   3
##          D   0   0   1 548   2
##          E   0   0   0   1 626
## 
## Overall Statistics
##                                        
##                Accuracy : 0.987        
##                  95% CI : (0.982, 0.99)
##     No Information Rate : 0.284        
##     P-Value [Acc > NIR] : <2e-16       
##                                        
##                   Kappa : 0.983        
##  Mcnemar's Test P-Value : NA           
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity             0.999    0.985    0.977    0.973    0.992
## Specificity             0.998    0.995    0.993    0.999    1.000
## Pos Pred Value          0.994    0.979    0.965    0.995    0.998
## Neg Pred Value          1.000    0.996    0.995    0.995    0.998
## Prevalence              0.284    0.193    0.174    0.164    0.184
## Detection Rate          0.284    0.191    0.170    0.160    0.182
## Detection Prevalence    0.286    0.195    0.177    0.161    0.183
## Balanced Accuracy       0.998    0.990    0.985    0.986    0.996
```

Step 6: Use the validation (subset training) data for cross validation.
===

```r
predictionVal <- predict(modFit, newdata = ValidatinData)
cm1 <- confusionMatrix(predictionVal, ValidatinData$classe)
cm1
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 1670    9    0    0    0
##          B    4 1127   14    0    0
##          C    0    3 1010   21    1
##          D    0    0    2  942    3
##          E    0    0    0    1 1078
## 
## Overall Statistics
##                                         
##                Accuracy : 0.99          
##                  95% CI : (0.987, 0.993)
##     No Information Rate : 0.284         
##     P-Value [Acc > NIR] : <2e-16        
##                                         
##                   Kappa : 0.988         
##  Mcnemar's Test P-Value : NA            
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity             0.998    0.989    0.984    0.977    0.996
## Specificity             0.998    0.996    0.995    0.999    1.000
## Pos Pred Value          0.995    0.984    0.976    0.995    0.999
## Neg Pred Value          0.999    0.997    0.997    0.996    0.999
## Prevalence              0.284    0.194    0.174    0.164    0.184
## Detection Rate          0.284    0.192    0.172    0.160    0.183
## Detection Prevalence    0.285    0.195    0.176    0.161    0.183
## Balanced Accuracy       0.998    0.993    0.990    0.988    0.998
```


Step 7: Read the testing data.
===

```r
test_Data <- read.csv("pml-testing.csv", na.strings = c("NA",""), header = TRUE)
```

Step 8: Preprocess/Cleanup the testing data similar to training data.
===

```r
RemoveNATest <- apply(test_Data, 2, function(na) {sum(is.na(na))})
Test_Data <- test_Data[, which(RemoveNATest == 0)]
removeTest_Index <- grep("timestamp|X|user_name|new_window|num_window",names(Data))
myTestData <- Test_Data[,-removeTest_Index]
```

Step 9: Final prediction of test data based on random forest model.
===


```r
predictionTest <- predict(modFit, newdata = myTestData)
predictionTest
```

```
##  [1] B A B A A E D B A A B C B A E E A B B B
## Levels: A B C D E
```

```r
# These results have been submitted as second part of assignment.
# I got 20/20 correct.
```

