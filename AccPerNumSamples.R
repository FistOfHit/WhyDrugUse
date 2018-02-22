# Script to perform calculations for accuracy comparisons between NNets and GLM
# according to number of samples used. Plotting capability in main 
# InvestigationFile.Rmd

numTests = 50

mseGLM = rep(0, numTests)
mseNN = rep(0, numTests)

for (i in 1:numTests) {
    
    
    # Training data
    drugTrain = data.frame(druguse[1:300 + (1200/numTests)*i, 13:30], druguse[1:300 + (1200/numTests)*i, 1])
    drugTrain[ , 19] = ifelse(drugTrain[ , 19] == "18-24", 1, 0)
    colnames(drugTrain)[19] = "agegroup"
    
    # Testing Data
    drugTest = data.frame(druguse[1501:1885, 13:30], druguse[1501:1885, 1])
    drugTest[ , 19] = ifelse(drugTest[ , 19] == "18-24", 1, 0)
    colnames(drugTest)[19] = "agegroup"
    
    for (j in 1:10) {
        # Fitting model GLM and predicting
        drugGLM = glm(drugTrain$agegroup ~ ., family = binomial(link = "logit"), data = drugTrain)
        drugPred = predict(drugGLM, newdata = drugTest[ , -19], type = "response")
        drugPred = ifelse(drugPred > 0.5, 1, 0)
        
        # Calculating number of correct predictions and MSE
        correctPred = sum(drugPred == drugTest[19])
        mseGLM[i] = mseGLM[i] + (1 - (correctPred / 385))
        
        # Fitting model NNET and predicting
        drugNeural = nnet(drugTrain$agegroup ~ ., data = drugTrain, size = 5, maxit = 1000, trace = FALSE)
        drugPred = predict(drugNeural, drugTest[ , -19], type = "raw")
        drugPred = ifelse(drugPred > 0.5, 1, 0)
        
        # Calculating number of correct predictions
        correctPred = sum(drugPred == drugTest[19])
        mseNN[i] = mseNN[i] + (1 - (correctPred / 385))
    }
    
}

mseGLM = mseGLM / 10
mseNN = mseNN / 10
mseData = data.frame(mseGLM, mseNN)
numTestVec = seq(300 + 1200/(numTests), 1500, 1200/(numTests))