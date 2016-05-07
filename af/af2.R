
s
afhtml <- read_html("http://www.af.mil/AboutUs/Biographies/Display/tabid/225/Article/108479/lieutenant-general-john-w-jay-raymond.aspx")
af1 <- afhtml %>% html_node(".da_black") %>%html_text()
at <- strsplit(af1, "EDUCATION|ASSIGNMENTS|SUMMARY OF JOINT ASSIGNMENTS|FLIGHT INFORMATION|AMAJOR AWARDS AND DECORATIONS|EFFECTIVE DATES OF PROMOTION")

af2 <- strsplit(af1, "\r\n\r\n")

af3 <- sapply(af2, function(x) strsplit(x, "\r\n"), simplify=T)

write.table(af3, 'af3.txt')

