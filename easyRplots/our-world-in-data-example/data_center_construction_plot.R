## data_center_construction_plot.R
##########################################################################
## Replication: "Money spent on building data centers in the US
##              has grown 5-fold since late 2022"
## Source: Our World in Data / U.S. Census Bureau / BLS
## Data: monthly-spending-data-center-us.filtered/
##       monthly-spending-data-center-us.csv
##########################################################################

##########################################################################
## (1) Load and prepare data
##########################################################################

dat <- read.csv(
    "monthly-spending-data-center-us.filtered/monthly-spending-data-center-us.csv",
    stringsAsFactors = FALSE,
    check.names = FALSE
)

## parse month column to decimal year for plotting
parse_decimal_year <- function(ym){
    yr  <- as.integer(substr(ym, 1, 4))
    mo  <- as.integer(substr(ym, 6, 7))
    return(yr + (mo - 0.5) / 12)  # mid-month
}

dat$year_dec  <- parse_decimal_year(dat$Month)
dat$spending  <- dat[["Data center construction"]] / 1e9  # convert to billions

## key annotation points
idx_dec2022 <- which(dat$Month == "2022-12")
idx_jun2026 <- which(dat$Month == "2026-06")

chatgpt_x   <- parse_decimal_year("2022-11")  # ChatGPT released Nov 30, 2022

##########################################################################
## (2) Plot
##########################################################################

line_col   <- "#B94435"  # brick red matching original
grid_col   <- "#DDDDDD"
title_col  <- "#1a1a1a"
sub_col    <- "#444444"
note_col   <- "#666666"

## outer margins: bottom, left, top, right (in lines)
## extra top space for title block; bottom for footnote
par(
    mar    = c(5.5, 5.5, 7, 2),
    bg     = "white",
    family = "sans",
    font   = 1
)

x_range <- c(min(dat$year_dec) - 0.3, max(dat$year_dec) + 1.2)  # right padding for labels
y_range <- c(0, 5)

plot(
    NULL,
    xlim = x_range,
    ylim = y_range,
    xaxt = "n",
    yaxt = "n",
    xlab = "",
    ylab = "",
    bty  = "n"
)

## horizontal grid lines
grid_vals <- 0:5
abline(h = grid_vals, col = grid_col, lty = 1, lwd = 0.8)

## x-axis tick positions: every 5 years visible
x_ticks <- seq(2015, 2025, by = 5)
axis(
    side   = 1,
    at     = x_ticks,
    labels = as.character(x_ticks),
    tick   = FALSE,
    col.axis = sub_col,
    cex.axis = 0.95,
    line   = -0.5
)

## y-axis labels: $0, $1B, ... $5B
y_labels <- c("$0", "$1B", "$2B", "$3B", "$4B", "$5B")
axis(
    side   = 2,
    at     = 0:5,
    labels = y_labels,
    tick   = FALSE,
    las    = 1,
    col.axis = sub_col,
    cex.axis = 0.95,
    line   = 0
)

## ChatGPT vertical dashed reference line
abline(v = chatgpt_x, lty = 2, col = "#999999", lwd = 1.2)

## main data line
lines(dat$year_dec, dat$spending, col = line_col, lwd = 2.2)

## endpoint dot at Jun 2026
points(
    dat$year_dec[idx_jun2026],
    dat$spending[idx_jun2026],
    pch = 16, col = line_col, cex = 1.1
)

## dot at Dec 2022
points(
    dat$year_dec[idx_dec2022],
    dat$spending[idx_dec2022],
    pch = 16, col = line_col, cex = 1.1
)

## annotation: "Release of ChatGPT"
text(
    x      = chatgpt_x + 0.08,
    y      = 4.85,
    labels = "Release of ChatGPT",
    adj    = c(0, 0.5),
    cex    = 0.78,
    col    = "#666666"
)

## annotation: Dec 2022 value
text(
    x      = dat$year_dec[idx_dec2022] - 0.15,
    y      = dat$spending[idx_dec2022] - 0.38,
    labels = "$868 million\nin Dec 2022",
    adj    = c(1, 0.5),
    cex    = 0.80,
    col    = line_col,
    font   = 2
)

## annotation: Jun 2026 value
text(
    x      = dat$year_dec[idx_jun2026] - 0.15,
    y      = dat$spending[idx_jun2026] + 0.35,
    labels = "$4.36 billion\nin Jun 2026",
    adj    = c(1, 0.5),
    cex    = 0.80,
    col    = line_col,
    font   = 2
)

## title block (drawn in outer margin via mtext)
mtext(
    text  = "Money spent on building data centers in the",
    side  = 3,
    line  = 5.8,
    adj   = 0,
    cex   = 1.15,
    font  = 2,
    col   = title_col
)
mtext(
    text  = "US has grown 5-fold since late 2022",
    side  = 3,
    line  = 4.5,
    adj   = 0,
    cex   = 1.15,
    font  = 2,
    col   = title_col
)

## subtitle (two lines)
mtext(
    text = paste0(
        "Cost of privately-funded construction of data centers each month,\n",
        "including materials and labor. Excludes IT hardware (servers, storage).\n",
        "Expressed in constant 2021 US$, adjusted for inflation."
    ),
    side = 3,
    line = 1.6,
    adj  = 0,
    cex  = 0.72,
    col  = sub_col
)

## footnote: note and data source
mtext(
    text = "Note: Constant 2021 US$.   Data source: U.S. Census Bureau (2026); U.S. Bureau of Labor Statistics (2026)",
    side = 1,
    line = 4.5,
    adj  = 0,
    cex  = 0.68,
    col  = note_col
)
