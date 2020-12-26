#install.packages("rvest")


library(rvest)

Court <- read_html("https://en.wikipedia.org/wiki/List_of_high_courts_in_India")

Court1 <- Court%>% html_nodes("#content
                              #bodyContent
                              #mw-content-text
                              .mw-parser-output
                              .wikitable.sortable.jquery-tablesorter") %>% html_text() %>% trimws()

#install.packages('htmltab')

require(htmltab)

url <- "https://en.wikipedia.org/wiki/List_of_high_courts_in_India"

courts <- htmltab(doc = url, which = "//th[text() = 'Court']/ancestor::table")
View(courts)
write.xlsx(courts,"Courts.xlsx")


url <- "https://en.wikipedia.org/wiki/List_of_high_courts_in_India"
courts <- htmltab(doc = url, which = "//th[text() = 'Court name']/ancestor::table")
View(courts)
write.csv(courts,"courts.csv")




























