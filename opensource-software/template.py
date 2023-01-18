# PLEASE WRITE THE GITHUB URL BELOW!
# https://github.com/Konahyeon/opensource-software.git

import sys
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import make_pipeline


def load_dataset(dataset_path):
	#To-Do: Implement this function
	dataset_df = pd.read_csv(dataset_path)

	return dataset_df

def dataset_stat(dataset_df):
	#To-Do: Implement this function
	n_feats = dataset_df.drop(columns="target", axis=1).shape[1]
	n_class0 = dataset_df.groupby('target').size()[0]
	n_class1 = dataset_df.groupby('target').size()[1]

	return n_feats, n_class0, n_class1

def split_dataset(dataset_df, testset_size):
	#To-Do: Implement this function
	x = dataset_df.drop(columns="target", axis=1) #feature
	y = dataset_df["target"] #feature 보고 내뿜는 값 = label(이름표=정답값)

	x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=testset_size, random_state=2)

	return x_train, x_test, y_train, y_test


def decision_tree_train_test(x_train, x_test, y_train, y_test):
	#To-Do: Implement this function
	dt_cls = DecisionTreeClassifier()
	dt_cls.fit(x_train, y_train)
	
	y_pred = dt_cls.predict(x_test)

	acc = accuracy_score(y_test, y_pred)
	prec = precision_score(y_test, y_pred)
	recall = recall_score(y_test, y_pred)

	return acc, prec, recall

def random_forest_train_test(x_train, x_test, y_train, y_test): #svm은 class를 항상 0으로
	#To-Do: Implement this function
	rf_cls = RandomForestClassifier()
	rf_cls.fit(x_train, y_train)
	
	y_pred = rf_cls.predict(x_test)

	acc = accuracy_score(y_test, y_pred)
	prec = precision_score(y_test, y_pred, zero_division='warn')
	recall = recall_score(y_test, y_pred, zero_division='warn')

	return acc, prec, recall

def svm_train_test(x_train, x_test, y_train, y_test):
	#To-Do: Implement this function
	svm_pip = make_pipeline(
		StandardScaler(),
		SVC()
	)
	svm_pip.fit(x_train, y_train)

	y_pred = svm_pip.predict(x_test)

	acc = accuracy_score(y_test, y_pred)
	prec = precision_score(y_test, y_pred, zero_division='warn')
	recall = recall_score(y_test, y_pred, zero_division='warn')

	return acc, prec, recall

def print_performances(acc, prec, recall):
	#Do not modify this function!
	print ("Accuracy: ", acc)
	print ("Precision: ", prec)
	print ("Recall: ", recall)

if __name__ == '__main__':
	#Do not modify the main script!
	data_path = sys.argv[1]
	data_df = load_dataset(data_path)

	n_feats, n_class0, n_class1 = dataset_stat(data_df)

	print ("Number of features: ", n_feats)
	print ("Number of class 0 data entries: ", n_class0)
	print ("Number of class 1 data entries: ", n_class1)

	print ("\nSplitting the dataset with the test size of ", float(sys.argv[2]))
	x_train, x_test, y_train, y_test = split_dataset(data_df, float(sys.argv[2]))

	acc, prec, recall = decision_tree_train_test(x_train, x_test, y_train, y_test)
	print ("\nDecision Tree Performances")
	print_performances(acc, prec, recall)

	acc, prec, recall = random_forest_train_test(x_train, x_test, y_train, y_test)
	print ("\nRandom Forest Performances")
	print_performances(acc, prec, recall)

	acc, prec, recall = svm_train_test(x_train, x_test, y_train, y_test)
	print ("\nSVM Performances")
	print_performances(acc, prec, recall)

	#==SVM에서 scale 하지 않을 경우 결과 확인==
	#print("\nSVM y_pred : ", sum(svm_train_test(x_train, x_test, y_train, y_test)==1)) 
		#결과 : class 1의 개수를 더한 값이 0으로 출력되기에 class는 다 0인 것을 알 수 있음!