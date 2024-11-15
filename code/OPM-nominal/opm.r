library('extraDistr')
library('foreach')

source('tplotfunctions.R')
source('guessmetadata.R')
source('buildagent.R')
source('infer.R')
source('decide.R')
source('mutualinfo.R')
source('rF.R')
source('plotFsamples1D.R')

options(repr.plot.width = 6*sqrt(2), repr.plot.height = 6)

opmall <- buildagent(metadata = 'meta_income_data_example.csv',
                     data = 'train-income_data_example.csv')

adutilities <- matrix(
    c(-1, 3,
        2, 2,
        3,-1),
    nrow = 3, byrow = TRUE,
    dimnames = list(ad_type = c('A','B','C'), income = c('<=50K', '>50K')))

userpredictors <- list(workclass = 'Private', education = 'Bachelors',
                       marital_status = 'Never-married',
                       occupation = 'Prof-specialty',
                       relationship = 'Not-in-family', race = 'White',
                       sex = 'Female', native_country = 'United-States')

probs <- infer(agent = opmall, predictand = 'income',
               predictor = userpredictors)

adutilities %*% probs

print(probs)

optimalad <- decide(utils = adutilities, probs = probs)

print(optimalad)