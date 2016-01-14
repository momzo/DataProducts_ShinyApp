ShinyApp Pitch
========================================================
author: Bill Delaney
date: January 14, 2016

Demonstration of using smoothing with best fits on scatterplots

Purpose of this interactive demo
========================================================

We often want to see a 'best fit' in our scatterplot of data to see a trend or pattern. This Shiny app demo allows the user to experiment with a couple of options. Hopefully the user will learn more about using the options, but also will glean that some datasets may benefit from experimenting with different types of statistical smoothing.

The interactive options in the demo are:
- Ability to select from five datasets
- Selection of a smoothing algorithm
- Choosing whether or not to use a third variable for separate plot fittings

Slide With Code
========================================================


```r
summary(cars)
```

```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

Slide With Plot
========================================================

![plot of chunk unnamed-chunk-2](ShinyApp_Pitch-figure/unnamed-chunk-2-1.png)
