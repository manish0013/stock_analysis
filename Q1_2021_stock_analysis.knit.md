---
title: "Q1 2021 Results & Share Value Analysis"
output:
  pdf_document: default
  html_notebook: default
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*. 


```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 3.6.2
```

```r
library(reshape2)
```

```
## Warning: package 'reshape2' was built under R version 3.6.2
```

```r
library(scales)
```

```
## Warning: package 'scales' was built under R version 3.6.2
```

```r
df = read.csv("C:/Users/mm13690/Documents/codes/misc/stock/data/q1_revenue_profit_21082021.csv")
```




```r
colnames(df) <- c("stock", "name","total_shares","current_share_value", "quarter",
                  "revenue", "profit")
df[,c("margin")] <- df$profit/df$revenue
df[,c("total_share_value")] <- df$total_shares * df$current_share_value
df[,c("sv_revenue_ratio")] <- df$total_share_value/df$revenue
df[,c("sv_profit_ratio")] <- df$total_share_value/df$profit
head(df)
```

```
##        stock           name total_shares current_share_value quarter    revenue
## 1 BAJAJ-AUTO          BAJAJ    289367020             3740.00  Q12021 7.3860e+10
## 2       INFY        INFOSYS   4361733444             1732.95  Q12021 2.7896e+11
## 3        M&M       Mahindra   1243192544              785.65  Q12021 1.1763e+11
## 4   TATACHEM Tata Chemicals    254756278              839.35  Q12021 2.9770e+10
## 5  TATASTEEL     Tata Steel   1204126385             1375.60  Q12021 5.3372e+11
## 6      WIPRO          Wipro   6033935388              620.05  Q12021 1.8250e+11
##      profit     margin total_share_value sv_revenue_ratio sv_profit_ratio
## 1 1.061e+10 0.14365015      1.082233e+12        14.652487       102.00119
## 2 5.195e+10 0.18622742      7.558666e+12        27.095877       145.49886
## 3 9.340e+09 0.07940151      9.767142e+11         8.303275       104.57326
## 4 2.880e+09 0.09674169      2.138297e+11         7.182724        74.24642
## 5 9.768e+10 0.18301731      1.656396e+12         3.103493        16.95737
## 6 3.230e+10 0.17698630      3.741342e+12        20.500502       115.83101
```



```r
help(melt)
```

```
## starting httpd help server ... done
```

```r
df_m = melt(df, id.vars = c("stock","name","total_shares","current_share_value","quarter"))
head(df_m)
```

```
##        stock           name total_shares current_share_value quarter variable
## 1 BAJAJ-AUTO          BAJAJ    289367020             3740.00  Q12021  revenue
## 2       INFY        INFOSYS   4361733444             1732.95  Q12021  revenue
## 3        M&M       Mahindra   1243192544              785.65  Q12021  revenue
## 4   TATACHEM Tata Chemicals    254756278              839.35  Q12021  revenue
## 5  TATASTEEL     Tata Steel   1204126385             1375.60  Q12021  revenue
## 6      WIPRO          Wipro   6033935388              620.05  Q12021  revenue
##        value
## 1 7.3860e+10
## 2 2.7896e+11
## 3 1.1763e+11
## 4 2.9770e+10
## 5 5.3372e+11
## 6 1.8250e+11
```



```r
# plot revenue & profit
p <- ggplot(df_m[df_m$variable %in% c("profit","revenue"),], aes(stock,value)) + 
        geom_bar(aes(fill = variable), position = "dodge",stat = "identity") +
        scale_y_continuous(labels = unit_format(unit = "Cr", scale = 1e-7))
p + ggtitle("Q1 Revenue & Profit of Portfolio Companies")
```

![](Q1_2021_stock_analysis_files/figure-latex/unnamed-chunk-4-1.pdf)<!-- --> 
Tata Steel posted highest revenue, followed by Infosys & Wipor in Q12021. In terms of profit, Tata Steel also posted the highest profits followed by Infosys

```r
# plot total share value
p <- ggplot(df_m[df_m$variable %in% c("total_share_value"),], aes(stock,value)) + 
        geom_bar(aes(fill = variable), position = "dodge",stat = "identity") +
        scale_y_continuous(labels = unit_format(unit = "Cr", scale = 1e-7))

p + ggtitle("Total Share Value 21 August 2021")
```

![](Q1_2021_stock_analysis_files/figure-latex/unnamed-chunk-5-1.pdf)<!-- --> 
IT Giants Infosys & WIPRO have the highest Total Share Value ( Stock Price * Total Number of Shares)
Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Ctrl+Alt+I*.

```r
# plot margin 
p <- ggplot(df_m[df_m$variable %in% c("margin"),], aes(stock,value)) + 
        geom_bar(aes(fill = variable), position = "dodge",stat = "identity")

p + ggtitle("Q1 Margin of Portfolio Companies")
```

![](Q1_2021_stock_analysis_files/figure-latex/unnamed-chunk-6-1.pdf)<!-- --> 
Margin is an indicator of the profitability of the company, In terms of Q1 margin, INFY has the highest margin, closely followed by Tata Steels & WIPRO 
When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Ctrl+Shift+K* to preview the HTML file).

```r
# plot share value to Profit ratio
p <- ggplot(df_m[df_m$variable %in% c("sv_profit_ratio"),], aes(stock,value)) + 
        geom_bar(aes(fill = variable), position = "dodge",stat = "identity")

p + ggtitle("Q1 Profit to Total Share Value of Portfolio Companies")
```

![](Q1_2021_stock_analysis_files/figure-latex/unnamed-chunk-7-1.pdf)<!-- --> 
If we compare the Total Share Value, some surprises come in, Tata Steel despite having similar margin as INFY, higher Absolute profit & Revenue - is the last amongst these companies(does this suggest it's undervalued). Additionally looking at these numbers WIPRO also appears to be slightly undervalued compared to INFY. 

Next I'll try running by averaging on numbers from previus few quarters to check if these trends hold or are they just outliers

