setwd("/Users/cascade/Github/NTL/data/raw/ipums/ghana-00-10")

library(ipumsr)
library(reshape2)

ddi <- read_ipums_ddi("ipumsi_00004.xml")
ghana <- read_ipums_micro(ddi)

ghana_df <- data.frame(ghana)
ghana_df$YEAR <- factor(as.character(ghana_df$YEAR))
ghana_df$GEO2_GH <- factor(as.character(ghana_df$GEO2_GH))

# split by year
ghana_split <- split(ghana_df, ghana_df$YEAR)
ghana_2000 <- ghana_split$`2000`
ghana_2010 <- ghana_split$`2010`

# split by urban vs rural
ghana_2000_split <- split(ghana_2000, ghana_2000$URBAN)
ghana_2000_urban <- ghana_2000_split$`2`
ghana_2000_rural <- ghana_2000_split$`1`

ghana_2010_split <- split(ghana_2010, ghana_2010$URBAN)
ghana_2010_urban <- ghana_2010_split$`2`
ghana_2010_rural <- ghana_2010_split$`1`

#tabulate data
ghana_2000_rural_tot <- data.frame(table(ghana_2000_rural$GEO2_GH))
colnames(ghana_2000_rural_tot) <- c("dist","rural00")

ghana_2010_rural_tot <- data.frame(table(ghana_2010_rural$GEO2_GH))
colnames(ghana_2010_rural_tot) <- c("dist","rural10")

ghana_2000_urban_tot <- data.frame(table(ghana_2000_urban$GEO2_GH))
colnames(ghana_2000_urban_tot) <- c("dist","urban00")

ghana_2010_urban_tot <- data.frame(table(ghana_2010_urban$GEO2_GH))
colnames(ghana_2010_urban_tot) <- c("dist","urban10")

ghana_final <- data.frame(ghana_2000_rural_tot$dist, ghana_2000_rural_tot$rural00,
                          ghana_2010_rural_tot$rural10, ghana_2000_urban_tot$urban00,
                          ghana_2010_urban_tot$urban10)

colnames(ghana_final) <- c("dist", "rural00", "rural10", "urban00", "urban10")

ghana_final[,2:5] = ghana_final[,2:5] * 10

ghana_final$ruralchg <- ghana_final$rural10 - ghana_final$rural00
ghana_final$urbanchg <- ghana_final$urban10 - ghana_final$urban00
ghana_final$ruralpct <- ghana_final$ruralchg / ghana_final$rural00 * 100
ghana_final$urbanpct <- ghana_final$urbanchg / ghana_final$urban10 * 100
head(ghana_final)

plot(ghana_final$ruralpct ~ ghana_final$rural00)
plot(ghana_final$urbanpct ~ ghana_final$urban00, log ="x",
     ylim=c(0, 100))
plot(ghana_final$urbanchg ~ ghana_final$urban00)

plot()














