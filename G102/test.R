gdata1 <- rep(0, 28);
gdata2 <- rep(0, 29);

files <- c('G102.100', 
			'G102.200', 
			'G102.300', 
			'G102.500', 
			'G102.600', 
			'G102.700', 
			'G102.900', 
			'G102.L00',
			'G102.402', 
			'G102.411', 
			'G102.421',
			'G102.481', 
			'G102.483');
files <- paste('e:/gitR/G102/', files, sep='');

for(f in files){
	temp <- read.csv(file = f, header = FALSE, stringsAsFactors = FALSE);
	gdata1 <- rbind(gdata1, temp);
}

files <- c('G102.800', 
			'G102.D00', 
			'G102.482');
files <- paste('e:/gitR/G102/', files, sep='');

for(f in files){
	temp <- read.csv(file = f, header = FALSE, stringsAsFactors = FALSE);
	gdata2 <- rbind(gdata2, temp);
}

	temp <- read.csv(file = 'e:/gitR/G102/G102.424', header = FALSE, stringsAsFactors = FALSE);
