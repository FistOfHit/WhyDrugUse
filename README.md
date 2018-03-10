# WhyDrugUse
Using biological and lifestyle data to predict the type and severity of drug use in individuals.

This project attempts to predict drug use in indivudals using biological data such as their age or sex etc. and numerical conversions of the "big 5" psychological markers as well as lifestyle data such as how often they eat or drink certain things. The predictions are in the form of how often they might take a certain substance, or the severity of use of substances. Poster I created is included, please check it out!

<a href="https://imgur.com/NZIk2Qp"><img src="https://i.imgur.com/NZIk2Qp.png" title="source: imgur.com" /></a>

## Summary of abilities

- Conducts EDA (exploratory data analysis) on medium-sized data-set (~1500 individuals) and shows how to get a feel for a data-set
- Uses multiple machine learning models (neural networks, random forests, gradient boosting trees, GLM's etc.) to come to conclusions on drug use
- Shows the ability of the powerful <a href="http://ggplot2.org/">ggplot2</a> r library 
- Works backwards and attempts to predict lifestyle and behaviour from types/severity of drug use!

## Requirements and Installation

The entire project is done in R, can be found <a href="https://www.r-project.org/about.html">here.</a>

Its best to use RStudio in my opinion as an IDE for R, it simply makes most tasks pretty easy and is the most popular IDE for R to the best of my knowledge. Available <a href="https://www.rstudio.com/">here.</a>

Additionally, you'll want the XGBoost library for some of the investigation, although the code has been edited to avoid those parts altogether incase it dosent work out well. Documentation and how to get it in inlcuded in instructions but for clarity, here are the commands to run in R console:
```r
- install.packages("drat", repos="https://cran.rstudio.com")
- drat:::addRepo("dmlc")
- install.packages("xgboost", repos="http://dmlc.ml/drat/", type = "source")
```
Strangely, on my system, <strong>XGBoost works in Linux but not in Windows</strong>, perhaps there is something I am not seeing or missing, but do let me know if you know why this is the case.

And to generate the HTML files from the RMD, you'll need the Knitr library, documentation available <a href="https://cran.r-project.org/web/packages/knitr/index.html">here.</a> 
Now the method I used to make use of the external R files relies on the ```source()``` function. If you really dont want to use this, then you can achieve the same thing via the ```read_chunk()``` function. If you want to knit the files this way, you may have to make small changes to the two .R files included. Simply add:
- ```@knitr OptionalNumTrees ```
- ```@knitr AccPerNumSamples ``` 

to the top of each file respectively. It should be fine to work then, and if not, refer to <a href="http://zevross.com/blog/2014/07/09/making-use-of-external-r-code-in-knitr-and-r-markdown/">this</a> site for information on how to use external .R files with knitr. 

## Usage

### EDA - Exploratory Data Analysis

Running the .Rmd is very simple (atleast in RStudio), simply run whichever parts you want and edit individual chunks of code on the fly, adapting it to your needs. Probably the only thing you shoud be careful with is the dataset, dont touch it...

<a href="https://imgur.com/LglWmEm"><img src="https://i.imgur.com/LglWmEm.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/ZuONHBo"><img src="https://i.imgur.com/ZuONHBo.png" title="source: imgur.com" /></a>

First off you have basic EDA. Plotting some graphs and exploring the data is pretty important to discovering basic relationships or finding hints towards the best paths to follow later in the investigation. Here, simply edit the x and y data on the ggplots to whatever variables of fields you think might show something interesting. Perhaps automate this process?

### GLM's testing and cross-validation

Here, you can test the predictive capabilities of a General Linear Model, and the code assess the accruacy of your predictions, as well as test how your model might react to new data via 10-fold cross-validation. The parameters and specifics of the model are somewhat variable, so try out different ways of using the model. Documentation can be found <a href="https://stat.ethz.ch/R-manual/R-devel/library/stats/html/glm.html">here.</a>

As for the cross-validation, there are built-in functions to handle some of the work the loop does, but here you have more control over how you split the data and use it, so use that to your advantage perhaps to come up with the best test.

### GBT testing

Same as above, except now we use gradient boosting trees for a similar type of prediction. The theory behind GBT's is quite interesting, for more info perhaps try <a href="https://en.wikipedia.org/wiki/Gradient_boosting">here</a> or <a href="http://blog.kaggle.com/2017/01/23/a-kaggle-master-explains-gradient-boosting/">here</a>. The library we use for this is XGBoost, installation instructions and possible issues with this are explained above, but even if you can't get it to work, its not an issue as the Rmd file will simply work around it.

### Random forests of heroin

Here we make our first proper prediction using another model, random forests. At a high-level, it's a collection of decision trees that comes to a conclusion by outputting the mode class or mean prediction of the decision trees that make it up. Here, we use this model (again bulit into r quite conveniently) to predict the level of heroin usage in individuals using all of our available predictiors. This makes for a slow model, but it does give us scope for more testing and we can certainly find the best predictors later. 

Another fun detour we take is to finding the optimum number of trees for accuracy of the model. The process is quite simple really, just simulating the process of training and predicting with forests of increasing size and finding the accuracy at each step. The results are quite interesting!

<a href="https://imgur.com/BXRR7cq"><img src="https://i.imgur.com/BXRR7cq.png" title="source: imgur.com" /></a>

### Predicting age based on drug use

Finally, we have some fun and work backwards to make a prediciton of an individuals age based on the types and severity of drug use, results are quite interesting again! We use and test a range of models, everything is provided.

## Contributing

Feel free to use the results or code for your own investigations, and if you want to make improvements or corrections then don't hesitate to let me know! I'm sure a lot of the Neural networks I used could be used better...

## Credits

XGBoost library - A significant portion of this investigation uses the XGBoost library, a very effcient implementation of gradient boosting trees in R. Documentation available <a href="https://cran.r-project.org/web/packages/xgboost/index.html">here.</a>

Dr. C. Colijn - Data-set and coursework idea itself was given to us as part of the M34A50 module at Imperial College London, lectured by Dr. Colijn. 

## License
MIT license, feel free to use and develop for your own investigations!
