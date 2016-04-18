#journal图

datebreaks <-seq(2007,2015,by=1);
ybreaks <- seq(60, 160, 20)
# 黑白折线图
p.serialb <- ggplot(lusepi, aes(x=date, y=value, linetype=variable));
p.serialb <- p.serialb + theme_bw();
p.serialb <- p.serialb + theme(panel.grid.major.y=element_line(colour="grey",linetype="dashed",size=0.2))
p.serialb <- p.serialb + theme(panel.grid.major.x=element_blank())
p.serialb <- p.serialb + theme(legend.position=c(0.85,0.77));
p.serialb <- p.serialb + theme(legend.key=element_rect(colour=NA, fill=NA));
p.serialb <- p.serialb + ylim(70, 160) +scale_y_continuous(breaks=ybreaks)
p.serialb <- p.serialb + geom_line(size = 0.6);
p.serialb <- p.serialb + scale_linetype(labels = labels);
p.serialb <- p.serialb + labs(x='年度', y='指数',  linetype='');
p.serialb
ggsave(file='.\\journal\\m-4个总指数序列图黑白.png', plot=p.serialb, width=5, height=4, dpi=100);
ggsave(file='.\\journal\\l-4个总指数序列图黑白.png', plot=p.serialb, width=9, height=7.5, dpi=100);

# 箱线图
p.box <- ggplot(lusepi, aes(x = variable, y=value));
p.box <- p.box + theme_bw();
p.box <- p.box + theme(panel.grid.major.y=element_line(colour="grey",linetype="dashed",size=0.2))
p.box <- p.box + theme(panel.grid.major.x=element_blank())
p.box <- p.box + geom_boxplot(notch = TRUE);
p.box <- p.box+labs(x='', y='指数');
p.box <- p.box + scale_x_discrete(labels = labels);
p.box <- p.box + ylim(70, 160) +scale_y_continuous(breaks=ybreaks)
p.box
ggsave(file='.\\journal\\m-4个总指数箱图.png', plot=p.box, width=5, height=4, dpi=100);
ggsave(file='.\\journal\\l-4个总指数箱图.png', plot=p.box, width=9, height=7.5, dpi=100);


# 提琴图
p.voilinbox <- ggplot(lusepi, aes(x = variable, y=value));
p.voilinbox <- p.voilinbox + theme_bw();
p.voilinbox <- p.voilinbox + theme(panel.grid.major.y=element_line(colour="grey",linetype="dashed",size=0.2))
p.voilinbox <- p.voilinbox + theme(panel.grid.major.x=element_blank())
p.voilinbox <- p.voilinbox + geom_violin();
p.voilinbox <- p.voilinbox + geom_boxplot(width=.1, position=position_dodge(width=0));
p.voilinbox <- p.voilinbox+labs(x='', y='指数');
p.voilinbox <- p.voilinbox + scale_x_discrete(labels = labels);
p.voilinbox <- p.voilinbox + ylim(70, 160) +scale_y_continuous(breaks=ybreaks)
ggsave(file='.\\journal\\m-4个总指数提琴箱图.png', plot=p.voilinbox, width=5, height=4, dpi=100);
ggsave(file='.\\journal\\l-4个总指数提琴箱图.png', plot=p.voilinbox, width=9, height=7.5, dpi=100);
p.voilinbox

# voilin jitter
p.voilinjitter <- ggplot(lusepi, aes(variable,value));
p.voilinjitter <- p.voilinjitter + theme_bw();
p.voilinjitter <- p.voilinjitter + theme(panel.grid.major.y=element_line(colour="grey",linetype="dashed",size=0.2))
p.voilinjitter <- p.voilinjitter + theme(panel.grid.major.x=element_blank())
p.voilinjitter <- p.voilinjitter + geom_point(position='jitter', shape = 20) + geom_violin(size =0.5)
p.voilinjitter <- p.voilinjitter + labs(x='', y='指数');
p.voilinjitter <- p.voilinjitter + scale_x_discrete(labels = labels);
p.voilinjitter <- p.voilinjitter + ylim(70, 160) +scale_y_continuous(breaks=ybreaks)
ggsave(file='.\\journal\\m-4个总指数提琴点图.png', plot=p.voilinjitter, width=5, height=4, dpi=100);
ggsave(file='.\\journal\\l-4个总指数提琴点图.png', plot=p.voilinjitter, width=9, height=7.5, dpi=100);
p.voilinjitter;

# 密度图
p.density <- ggplot(lusepi, aes(value, linetype=variable));
p.density <- p.density + theme_bw();
p.density <- p.density + theme(panel.grid.major.y=element_line(colour="grey",linetype="dashed",size=0.2))
p.density <- p.density + theme(panel.grid.major.x=element_blank())
p.density <- p.density + theme(legend.position=c(0.85,0.77));
p.density <- p.density + theme(legend.key=element_rect(colour=NA, fill=NA));
p.density <- p.density + xlim(70, 160) +scale_x_continuous(breaks=ybreaks)
p.density <- p.density + scale_linetype(labels = labels);
p.density <- p.density + geom_density(alpha = 0.3);
p.density <- p.density+labs(x='指数', y='密度', linetype='');
p.density;
ggsave(file='.\\journal\\m-4个总指数密度图.png', plot=p.density, width=5, height=4, dpi=100);
ggsave(file='.\\journal\\l-4个总指数密度图.png', plot=p.density, width=9, height=7.5, dpi=100);


rs <- read.csv(file = 'result.csv', header = TRUE, stringsAsFactors = FALSE);
rs$date <- as.Date(rs$date);
ybreaks <- seq(98, 108, 2)
# 黑白折线图
p.rs <- ggplot(rs, aes(x=date, y=value, linetype=type));
p.rs <- p.rs + theme_bw();
p.rs <- p.rs + theme(panel.grid.major.y=element_line(colour="grey",linetype="dashed",size=0.2))
p.rs <- p.rs + theme(panel.grid.major.x=element_blank())
p.rs <- p.rs + theme(legend.position=c(0.85,0.84));
p.rs <- p.rs + theme(legend.key=element_rect(colour=NA, fill=NA));
p.rs <- p.rs + scale_y_continuous(breaks=ybreaks)
p.rs <- p.rs + geom_line(size = 0.6);
p.rs <- p.rs + labs(x='年度', y='指数',  linetype='');
p.rs
ggsave(file='.\\journal\\m-结果对比2.png', plot=p.rs, width=5, height=4, dpi=100);
ggsave(file='.\\journal\\l-结果对比2.png', plot=p.rs, width=9, height=7.5, dpi=100);
