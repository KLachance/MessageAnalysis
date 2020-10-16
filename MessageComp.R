#!/n/app/R/3.6.1/bin/Rscript

# Written by: K. Lachance
# Date: October 9, 2020

# Use: ./MessageComp.R

# Perform message composition analysis on cleaned message data

# Load libraries
library(ggplot2)
library(svglite)

# Load data
cat("Loading data...\n")
fbMessages = read.table("FacebookMessages_cleaned.txt", sep="\t",  stringsAsFactors = FALSE)
colnames(fbMessages) = c("Name", "Text", "Date")
fbMessages$Format = "Facebook"

groupMeMessages = read.table("GroupMeMessages_cleaned.txt", sep="\t",  stringsAsFactors = FALSE)
colnames(groupMeMessages) = c("Name", "Text", "Date")
groupMeMessages$Format = "GroupMe"

# Combine data
cat("Combining data...\n")
Messages = rbind(fbMessages, groupMeMessages)

# Set colors for all charts
Sender1_color = "steelblue"
Sender1_colorAlt = "steelblue4"
Sender2_color = "chocolate"
Sender2_colorAlt = "chocolate4"

# Calculate total number of messages and messages per person
cat("Calculating total numbers of messages...\n")
nTotal = nrow(Messages)
cat(paste("\tA total of ", nTotal, " messages were sent between Sender1 & Sender2!\n", sep=""))

n1 = nrow(Messages[Messages$Name == "Sender1",])
n2 = nrow(Messages[Messages$Name == "Sender2",])
cat(paste("\tSender1 sent ", n1, " (", round((n1/nTotal)*100, 1), "%) messages while Sender2 sent ", n2, " (", round((n2/nTotal)*100, 1), "%) messages!\n", sep=""))

# Make a pie chart of messages sent
tmp1 = data.frame(User = c("Sender1", "Sender2"), Count = c(n1, n2), stringsAsFactors = FALSE)
p1 = ggplot(tmp1, aes(x = "", y = Count, fill = User)) +
  geom_bar(stat = "identity") +
  coord_polar("y", start = 0) +
  scale_fill_manual(values=c("Sender1"= Sender1_color, "Sender2" = Sender2_color)) +
  theme_bw() +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        panel.grid  = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank()) +
  theme(legend.position = "none")

ggsave(plot = p1, filename = "PercentOfMessages.svg", width = 5, height = 5)

# Count words and characters
cat("Counting words and characters per message\n")
for (i in 1:nrow(Messages)) {
  Messages$nWords[i] = sapply(strsplit(Messages$Text[i], " "), length)
  Messages$nCharacters[i] = sapply(strsplit(Messages$Text[i], ""), length)
}
longestWords1 = max(Messages[Messages$Name == "Sender1", 'nWords'])
longestWords2 = max(Messages[Messages$Name == "Sender2", 'nWords'])
longestChar1 = max(Messages[Messages$Name == "Sender1", 'nCharacters'])
longestChar2 = max(Messages[Messages$Name == "Sender2", 'nCharacters'])
cat(paste("\tSender1's longest messages were ", longestWords1, " words and ", longestChar2, " characters.\n", sep=""))
cat(paste("\tSender2's longest messages were ", longestWords1, " words and ", longestChar2, " characters.\n", sep=""))

# Make boxplots for number of words and characters by person
p2 = ggplot(Messages, aes(x = Name, y = log10(nWords), fill = Name, color = Name)) +
  geom_violin() +
  theme_bw() +
  scale_fill_manual(values=c("Sender1"= Sender1_color, "Sender2" = Sender2_color)) +
  scale_color_manual(values=c("Sender1"= Sender1_colorAlt, "Sender2" = Sender2_colorAlt)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
#  theme(axis.text = element_blank(), axis.title = element_blank()) +
  theme(legend.position = "none")

ggsave(plot = p2, filename = "DistOfWords.svg", width = 4, height = 6)

p3 = ggplot(Messages, aes(x = Name, y = log10(nCharacters), fill = Name, color = Name)) +
  geom_violin() +
  theme_bw() +
  scale_fill_manual(values=c("Sender1"= Sender1_color, "Sender2" = Sender2_color)) +
  scale_color_manual(values=c("Sender1"= Sender1_colorAlt, "Sender2" = Sender2_colorAlt)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
#  theme(axis.text = element_blank(), axis.title = element_blank()) +
  theme(legend.position = "none")

ggsave(plot = p3, filename = "DistOfChars.svg", width = 4, height = 6)