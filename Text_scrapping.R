# Installing 'htmltab' package to scrap text data from web
#install.packages('htmltab')


require(htmltab)


# Defining the web path (target scrap site)
url <- "http://karnatakajudiciary.kar.nic.in/ConsolidatedCauselist/consolidation.htm"
BlrB <- htmltab(doc = url, which = "//th[text() = '935*140907']/ancestor::table")
View(BlrB)



library(rvest)
library(httr)

y <- read_html("http://karnatakajudiciary.kar.nic.in/entire_cause_list.asp")


y <- y %>%
  html_nodes("table") %>%
  html_table(header=TRUE)

View(y)


library(rvest)


# Reading the subsection of the website
url<-read_html("http://karnatakajudiciary.kar.nic.in/ConsolidatedCauselist/consolidation.htm")
cases<-html_nodes(x = url,xpath = "//pre") %>% html_text()


#install.packages("pander")

library(pander)



sink("cases.txt")
pander(cases)
sink()
View(cases)
summary(cases)
dim(cases)


