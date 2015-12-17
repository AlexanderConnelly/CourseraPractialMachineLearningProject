
require(caret)
require(kernlab)

#Spam Examples:

data(spam)

## Example: Data Splitting

inTrain <- createDataPartition(y=spam$type, p = 0.75, list = FALSE)
## 75 % in training, 25% in test

training <- spam[inTrain,]
testing <- spam[-inTrain,]

dim(training)


## Data splitting k-fold splitting

folds <- createFolds(y = spam$type, k = 10, list = TRUE, returnTrain = TRUE)

sapply(folds,length)

## Data Splitting: Resampling # resampling with replacement of the values

#folds <- createResample(y = spam$type, k = 10, list = TRUE)

sapply(folds,length)

## Data Splitting: Time Slices

tme <- 1:1000

folds <- createTimeSlices(y=tme,initialWindow = 20, horizon = 10)

## Fit a Model

set.seed(32343)
modelFit<- train(type ~., data = training, method = "glm")

modelFit

## Final Model

modelFit$finalModel

## Prediction

predictions <- predict(modelFit, newdata = testing)

# Confusion Matrix

confusionMatrix(predictions, testing$type)

## Plotting Predictors:
##########################################################################
## Wage Data Example For Plotting Predictors

require(ISLR)
require(ggplot2)
require(caret)

data(Wage)
summary(Wage)


inTrain <- createDataPartition(y=Wage$wage, p = 0.75, list = FALSE)
## 75 % in training, 25% in test

training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

dim(training)


featurePlot(x = training[,c("age","education", "jobclass","race","maritl" )], y = training$wage, plot = "pairs")

