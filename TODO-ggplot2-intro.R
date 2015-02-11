# http://www.sharpsightlabs.com/r-line-chart-and-datavis-process/
# How to build an R line chart, step by step

library("ggplot2")

# Read in data
year <- c("1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", 
          "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", 
          "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", 
          "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", 
          "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", 
          "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", 
          "2009", "2010")
co2_emission_per_cap_qt <- as.numeric(
  c("0.836046900792028", "0.661428164381093", "0.640001899360285", 
    "0.625646053941047", "0.665524211218076", "0.710891381561055", 
    "0.574162146975018", "0.60545199674633", "0.725149509123457", 
    "0.942934534989582", "1.04223969658961", "1.08067663654397", 
    "1.09819569131687", "1.09736711056811", "1.25012409495905", 
    "1.28528313553995", "1.38884289658754", "1.52920110964112", 
    "1.5426750986837", "1.49525074931082", "1.46043181655825", 
    "1.56673968353113", "1.62905590778943", "1.75044806018373", 
    "1.87105479144466", "1.93943425697654", "2.03841068876927", 
    "2.1509052249848", "2.15307791087471", "2.16770307659104", 
    "2.24590127565651", "2.31420729031649", "2.44280065934625", 
    "2.56599389177193", "2.75575496636525", "2.84430958153669", 
    "2.82056789057578", "2.67674598026467", "2.64864924664833", 
    "2.69686243322549", "2.74212081298895", "2.88522504139331", 
    "3.51224542766222", "4.08013890554173", "4.4411506949345", 
    "4.89272709798477", "5.15356401658718", "5.31115185538876", 
    "5.77814318390097", "6.19485757472686"))

# Combine data into dataframe
df.china_co2 <- data.frame(year, co2_emission_per_cap_qt)

# The iterative Data Visualization Process

# Step 1: Simple R line chart
ggplot(data = df.china_co2, 
       aes(x = year, y = co2_emission_per_cap_qt, group = 1)) + 
  geom_line()

# Step 2: Add points (new layer)
ggplot(data = df.china_co2, 
       aes(x = year, y = co2_emission_per_cap_qt, group = 1)) + 
  geom_line() +
  geom_point()

# Step 3: Add color
ggplot(data = df.china_co2, 
       aes(x = year, y = co2_emission_per_cap_qt, group = 1)) + 
  geom_line(color = "#aa0022", size = 1.75) +
  geom_point(color = "#aa0022", size = 3.5)

# Step 4: Edit gridlines
ggplot(data = df.china_co2, 
       aes(x = year, y = co2_emission_per_cap_qt, group = 1)) + 
  geom_line(color = "#aa0022", size = 1.75) + 
  geom_point(color = "#aa0022", size = 3.5) + 
  scale_x_discrete(breaks = c("1961", "1965", "1970", "1975", "1980", "1985", 
                              "1990", "1995", "2000", "2005", "2010"))

# Step 5: Add title, edit exis labels
ggplot(data = df.china_co2, 
       aes(x = year, y = co2_emission_per_cap_qt, group = 1)) + 
  geom_line(color = "#aa0022", size = 1.75) + 
  geom_point(color = "#aa0022", size = 3.5) + 
  scale_x_discrete(breaks = c("1961", "1965", "1970", "1975", "1980", "1985", 
                              "1990", "1995", "2000", "2005", "2010")) + 
  ggtitle("China CO2 Emissions, Yearly") + 
  labs(x = "", y = "CO2 Emissions\n(metric tonnes per capita)")

# Step 6: Format title and axes
ggplot(data = df.china_co2, 
       aes(x = year, y = co2_emission_per_cap_qt, group = 1)) + 
  geom_line(color = "#aa0022", size = 1.75) + 
  geom_point(color = "#aa0022", size = 3.5) + 
  scale_x_discrete(breaks = c("1961", "1965", "1970", "1975", "1980", "1985", 
                              "1990", "1995", "2000", "2005", "2010")) + 
  ggtitle("China CO2 Emissions, Yearly") + 
  labs(x = "", y = "CO2 Emissions\n(metric tonnes per capita)") +
  theme(axis.title.y = element_text(size = 14, family = "Trebuchet MS", 
                                    color="#666666")) +
  theme(plot.title = element_text(size = 26, family = "Trebuchet MS", 
                                  face = "bold", hjust = 0, 
                                  color = "#666666")) + 
  theme(axis.text = element_text(size = 16, family = "Trebuchet MS"))







