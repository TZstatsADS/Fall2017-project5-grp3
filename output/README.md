# Project: 
### Output folder

A. DATASET file:

convert all values to numeric values, there are two kinds of datasets:

Firstly, just convert all logical values to numeric values, and convert all character values to numeric values, and data files are in following links:

Train_num :  https://drive.google.com/a/columbia.edu/file/d/1Tp6Bwf7nQT-HC3xk7Q3Gfd7q6FV-W870/view?usp=sharing

Test_num :  https://drive.google.com/a/columbia.edu/file/d/16vQKQAYuyozL261TQZX7_-3hPoMeZRyp/view?usp=sharing

Secondly, besides converting all values to numeric values, also make two changes:

1. If people$group_1 is unique, we make the values of  all unique people$group_1 to be the same.

2. For activities dataset, if there are situations as the activity$char_10 is a certain type and only one special people have this type of char_10, we make all this kind of situation to be the same.

The purpose of this kind of converting is to avoid dummy variable traps.

The files are as followings: 

Train_runique: https://drive.google.com/a/columbia.edu/file/d/1BNEs-IlhJdF2Lya-XEsZiJUlqYotgf-q/view?usp=sharing

Test_runique: https://drive.google.com/a/columbia.edu/file/d/1f6Z0NytOKhPdPO41CXDRoP3W2wn2g5jU/view?usp=sharing



