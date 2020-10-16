# Message Analysis
After nearly 7 years of messaging on Facebook and GroupMe with my boyfriend (now fiance), I wanted to analyze our messaging behavior. I compiled these data and analyses for a present for his 27th birthday

# Obtain and clean the data
We typically message using Facebook messenger, but also switched to GroupMe breifly. So I wanted to download both of those data.

Facebook messages can be downloaded as JSON files quite easily; I followed these directions here
https://www.facebook.com/help/212802592074644/?ref=u2u

GroupMe messages can similarly be downloaded here following these directions here
https://support.microsoft.com/en-us/office/how-do-i-export-my-groupme-data-1f6875bf-7871-4ade-8608-4c606cd5f518

Once the JSON files have been downloaded, I used the scripts `parseJSON_Facebook.sh` and `parseJSON_GroupMe.sh` to extract data as 3 columns:
  - Name of sender
  - Text of message
  - Timestamp of message
  
Unfortunately, this process is imperfect, so I also had to do some clean-up by hand. I made sure to:
  1) Keep names consistent if names changed over time (also, remove lines where the sender is "GroupMe", as in when you changed the conversation name
  2) Ensure there are exactly 3 columns per line (the script just gets confused sometimes and it was faster to correct the few errors by hand than continue to fiddle with the script)
  3) Put quotations around each of the three columns for easy and accurate import into R
  
In the end, my data looked something like this:
  - "Sender1"	"Sleep tight!"	"1417459379432"
  - "Sender1"	"Good night!"	"1417459369869"
  - "Sender2"	"I miss you <3"	"1417459352899"
  - "Sender1"	"I hope you had a good day!"	"1417459351151"
  - "Sender2"	"23 days until I see you!!!!!"	"1417459334090"
  - ...
  
At this point, I had two files `FacebookMessages_cleaned.txt` and `GroupMeMessages_cleaned.txt` and I was ready to import into R.

# Total number of messages, words per message, and characters per message
With the script `./MessageComp.R`, I created the following graphs:
  - Pie chart of % messages sent by each person
  - Violin chart of # words / message
  - Violin chart of # characters / message

Note: For this and all scripts, names have been replaced with "Sender1" and "Sender2". Replace these with your names before using the script!

