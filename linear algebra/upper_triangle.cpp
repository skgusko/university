//Reduced Row Echelon Form

#include <iostream>
using namespace std;
class Matrix
{
private:
public:
	double** arr;
	int N;
	void get_input() //matrix의 각 요소 입력
	{
		cout << "============ Making N x N matrix ============" << endl;
		cout << "Please enter the number of N : ";
		cin >> this->N;
		this->arr = new double* [this->N+1];
		for (int i = 1; i <= this->N; i++)
			this->arr[i] = new double[this->N+1];
		for (int i = 1; i <= this->N; i++)
		{
			for (int j = 1; j <= this->N; j++)
			{
				cout << "Please enter the element of " << i << "row, " << j << "column" << endl;
				double element;
				cin >> element;
				this->arr[i][j] = element;
			}
		}
	} 

	void op3(int one, double mul, int add, int result) //operation 적용
	{
		for (int i = 1; i <= this->N; i++)
		{
			this->arr[result][i] = this->arr[one][i] * mul - this->arr[add][i];
		}
	}

	void upper_triangle() //upper triangle 만들기
	{
		for (int i = 1; i <= this->N; i++)
		{
			if (this->arr[i][i] == 0)
			{
				for (int j = i + 1; j <= this->N; j++)
				{
					if (this->arr[j][i] != 0)
					{
						swap(this->arr[i], this->arr[j]);
						break;
					}
				}
			}
			for (int j = i + 1; j <= N; j++)
			{
				double one = i;
				double mul = arr[j][i] / arr[i][i];
				double add = j;
				double result = j;
				op3(one, mul, add, result);
			}
		}
	}

	void print() //matrix 출력
	{
		for (int i = 1; i <= this->N; i++) 
		{
			for (int j = 1; j <= this->N; j++)
			{
				cout << this->arr[i][j] << " ";
			}
			cout << endl;
		}
	}
};
int main()
{
	Matrix mat;
	mat.get_input();
	mat.upper_triangle();
	mat.print();
}
