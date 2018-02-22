# Script to optimal number of trees to use in a random forest model in this case.
# Plotting for this is contained in main InvestigationFile.Rmd.

accList = c(1:30)
numTrials = c(1:length(accList))

# Finding average accuracy for each model
for (i in numTrials) {
    
    avAcc = c(1:10)
    
    for (j in 1:10) { 
        # Fitting model for 10*i trees and predicting
        drugForest = randomForest(drugTrain$heroin ~ ., data = drugTrain[ , -24], importance = TRUE, ntree = 10*i)
        drugPred = predict(drugForest, newdata = drugTest[ , -24], type = "class")
        
        # Assessing accuracy
        correctPred = sum(drugPred == drugTest[ , 24])
        avAcc[j] = (correctPred) / 385
    }
    
    accList[i] = sum(avAcc) / 10
    
}

# Fitting a Quartic curve to our data
fitCurve = lm(accList ~ poly(numTrials, 4, raw = TRUE))
