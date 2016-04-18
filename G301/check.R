need <- seq(12, 21, 1);
need <- c(12, 13,14,15,16,17,18, 20, 21)
need <- paste('C', need, sep='');
need <- c('county', need)

gn <- g32[, need]
gn$erA <- gn$C13-(gn$C14+ gn$C15+ gn$C16+ gn$C17+ gn$C21)
gn$erall <- gn$C12-(gn$C13+gn$C18+gn$C20)

print(gn[, c(1, 11, 12)])
print(sum(abs(gn$erA)))
print(sum(abs(gn$erall)))
