plot_hist <- function(df,i,file_name_suffix) {
plot<- ggplot(df, aes_string(x=i)) + 
    geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                   binwidth=1,
                   colour="black", fill="white") +
    geom_density(alpha=.2, fill="#FF6666") 
    ggtitle(paste0(i))
    plot
 ggsave(filename=paste0(i,file_name_suffix,".pdf"),path="../figures/")
} 