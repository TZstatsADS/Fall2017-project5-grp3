# ADS Project 5: 

Term: Fall 2017

+ Team 3
+ Projec title: Model Selection for Predicting Red Hat Business Value using Machine Learning Algorithm
+ Team members
	+ Lin Han(lh2810)
	+ Yajie Guo(yg2477)
	+ Vassily Carantino(vc2434)
	+ Enrique Olivo(eco2121)
+ Project summary: In this project, we conducted a couple of machine learning algorithms on Red Hat Business data set, which is pretty large(almost two millions*56). We mainly compared Linear SVM, logistic Regression, Random Forest, GBM, Light GBM, Xgboost, Neural Network. And it proved Xgoost has the highest accuracy around 98%. Since the accuracy is pretty high, we used feature selection, such as Feature Importance, PCA, to exclude the possibility of overfitting or dummy variable traps. After all these tests, we concluded that Xgoost should be regarded as the optimal model.
+ Contribution

Lin Han(lh2810): data processing, xgboost model, neural network model, PCA, main file

Yajie Guo(yg2477): svm model, main file

Vassily Carantino(vc2434): Light GBM model

Enrique Olivo(eco2121): Logistic Model, GBM model

	
**Contribution statement**: ([default](doc/a_note_on_contributions.md)) All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
