## Volcano plot exercise:

library(ggplot2)
library(ggrepel)
genedata <- read.csv("geneexpression.csv")

# change gene name data type
genedata <- genedata %>% mutate(Gene = as.character(Gene))
genedata <- genedata %>% rename(FoldChange= log2FoldChange)

# start making the plot
myvolcano <- ggplot(data=genedata, mapping=aes(x=FoldChange, y=-log10(padj)))
myvolcano + geom_point()                    

# which genes are significant

genedata <- genedata %>% mutate(significant = padj <0.05 & abs(FoldChange) >= 0.5)


myvolcano + geom_point(aes(color=significant))




# which labels do we want
genedata <- genedata %>% mutate(genelabel=ifelse(significant,Gene,""))

myvolcano + geom_point(aes(color=significant)) + geom_text(aes(label = genelabel))

library(ggrepel)

myvolcano + geom_point(aes(color=significant)) + geom_text_repel(aes(label = genelabel))


# other customizations

myvolcano + geom_point(aes(color=significant)) + geom_text_repel(aes(label = genelabel)) +
  coord_cartesian(xlim=c(-2.5,0),ylim=c(1,3.5))

myvolcano + geom_point(aes(color=significant)) + geom_text_repel(aes(label = genelabel)) +
  theme_minimal()


