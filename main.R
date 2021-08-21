library(ggplot2)
library(reshape2)
library(scales)
 
df = read.csv("C:/Users/mm13690/Documents/codes/misc/stock/data/q1_revenue_profit_21082021.csv")

colnames(df) <- c("stock", "name","total_shares","current_share_value", "quarter",
                  "revenue", "profit")
df[,c("margin")] <- df$profit/df$revenue
df[,c("total_share_value")] <- df$total_shares * df$current_share_value
df[,c("sv_revenue_ratio")] <- df$total_share_value/df$revenue
df[,c("sv_profit_ratio")] <- df$total_share_value/df$profit
head(df)

help(melt)
df_m = melt(df, id.vars = c("stock","name","total_shares","current_share_value","quarter"))
head(df_m)

# plot revenue & profit
p <- ggplot(df_m[df_m$variable %in% c("profit","revenue"),], aes(stock,value)) + 
        geom_bar(aes(fill = variable), position = "dodge",stat = "identity") +
        scale_y_continuous(labels = unit_format(unit = "Cr", scale = 1e-7))

p + ggtitle("Q1 Revenue & Profit of Portfolio Companies")

# plot total share value
p <- ggplot(df_m[df_m$variable %in% c("total_share_value"),], aes(stock,value)) + 
        geom_bar(aes(fill = variable), position = "dodge",stat = "identity") +
        scale_y_continuous(labels = unit_format(unit = "Cr", scale = 1e-7))

p + ggtitle("Total Share Value 21 August 2021")


# plot margin 
p <- ggplot(df_m[df_m$variable %in% c("margin"),], aes(stock,value)) + 
        geom_bar(aes(fill = variable), position = "dodge",stat = "identity")

p + ggtitle("Q1 Margin of Portfolio Companies")

# plot share value to Profit ratio
p <- ggplot(df_m[df_m$variable %in% c("sv_profit_ratio"),], aes(stock,value)) + 
        geom_bar(aes(fill = variable), position = "dodge",stat = "identity")

p + ggtitle("Q1 Profit to Total Share Value of Portfolio Companies")

