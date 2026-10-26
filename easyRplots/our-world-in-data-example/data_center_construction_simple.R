## data_center_construction_simple.R
##########################################################################
## Simple version: US data center construction spending over time
## Data: monthly-spending-data-center-us.filtered/
##       monthly-spending-data-center-us.csv
##########################################################################

dat <- read.csv(
    "monthly-spending-data-center-us.filtered/monthly-spending-data-center-us.csv",
    stringsAsFactors = FALSE,
    check.names = FALSE
)

dat$year_dec <- as.integer(substr(dat$Month, 1, 4)) +
                (as.integer(substr(dat$Month, 6, 7)) - 0.5) / 12
dat$spending <- dat[["Data center construction"]] / 1e9

chatgpt_x <- 2022 + (11 - 0.5) / 12

##########################################################################
## Plot
##########################################################################

plot(
    dat$year_dec,
    dat$spending,
    type  = "l",
    col   = "#B94435",
    lwd   = 2,
    xlab  = "Year",
    ylab  = "Spending (billions, constant 2021 USD)",
    main  = "US Data Center Construction Spending",
    ylim  = c(0, 5),
    las   = 1
)

abline(v = chatgpt_x, lty = 2, col = "gray50")
text(chatgpt_x + 0.1, 4.7, "ChatGPT\nrelease", adj = c(0, 0.5), cex = 0.75, col = "gray40")
