#install.packages("RSelenium")

## Setup the RSelenium
require(RSelenium)
selCommand<- 
  wdman::selenium(jvmargs = c("-Dwebdriver.chrome.verboseLogging=true"), 
                  retcommand = TRUE)


## Start the selenium server
cat(selCommand)
# Copy this output
# Open command line
# cd C:\Program Files\Java\jdk1.8.0_161\bin
# Now copy the output of cat(selCommand) and paste in command line after writing "java"
# java output_of_cat(selCommand)
# This will say that server is up and running

## Open a browser
remDr <- remoteDriver(port = 4567L, browserName = "chrome")
remDr$open()

## Open a website
remDr$navigate("http://njdg.ecourts.gov.in/njdg_public/index.php")
# Go to the chrome and Enter the captcha manually

## Select the State drop down
state_code <- remDr$findElement(using = 'css selector', "#states_code")

# Send a sample value
state_code$sendKeysToElement(list("Andhra Pradesh"))

## Select the district drop down
district_code <- remDr$findElement(using = 'css selector', "#district_code")

# Send a sample district value
district_code$sendKeysToElement(list("chittoor"))

## Select the Court drop down
court_code <- remDr$findElement(using = 'css selector', "#est_code")

# Send a sample court value
court_code$sendKeysToElement(list("Districts Courts, Anathapur"))
#court_code$clickElement()

## Now switch the frame where data is
webElems <- remDr$findElements(using = "tag name", "iframe")
sapply(webElems, function(x){x$getElementAttribute("src")})

remDr$switchToFrame(webElems[[1]])

webElems1 <- remDr$findElements(using = "tag name", "iframe")
sapply(webElems1, function(x){x$getElementAttribute("src")})
remDr$switchToFrame(webElems1[[1]])

# get the resulting data
library(XML)
html_source=htmlParse(remDr$getPageSource()[[1]])
appData= readHTMLTable(html_source,which = 2)
View(appData)

## Note : This data contains all the tables on the page, we need to Arrange them after exporting

library(xlsx)
# Writing data in excel file format
write.xlsx(appData,"Ap_Ananthapur.xlsx", row.names=F)

summary(appData)