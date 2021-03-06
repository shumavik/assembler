#include "stdafx.h"
#include <iostream>
#include <cstring>
#include <conio.h>
#include <cstdio>
#include <string>
#include <cstdlib>
#include <regex>

using namespace std;

int main()
{	
	setlocale(LC_CTYPE,"Russian");
	string s;
	while (s != "end")
	{
		cout << "Введите строку для распознавания" << endl;
		getline(cin, s);
		cout << "Изначальная строка:" << s << endl;
		if (s == "end") {}
		else {
			//regex_match
			cmatch result;
			regex regular_expression("((int)||(float)||(char)||(unsigned char))"
				"( )"
				"(([A-Za-z]+)||([A-Za-z]+[\\digit]+))"
				"(\\[)"
				"([\\digit]+)"
				"(\\];)"
			);

			regex regular_struct(
				"(struct )"
				"([A-Za-z]+)"
				"(( +\\{)||( +\\{ +)||(\\{)||(\\{ +))"
				"(((int)||(float)||(char)||(unsigned char))( )([A-Za-z]+)(;||(\\[([\\digit]+)\\];))){1,}"
				"(( +\\})||( +\\} +)||(\\})||(\\} +))"
				"((([A-Za-z]+)||([A-Za-z]+[0-9]+))||((([A-Za-z]+)||([A-Za-z]+[0-9]+))(,[A-Za-z]+)||(,[A-Za-z]+[0-9]+))){1,}"
				"(\\;)"
			);


			if (regex_match(s.c_str(), regular_expression))
				cout << "True" << endl;
			else
			{
				if (regex_match(s.c_str(), regular_struct))
					cout << "True" << endl;
				else
					cout << "False" << endl;
			}
			//	for (int i = 0; i < result.size(); i++)
			//		cout << result[i] << endl;
		}

		
		
	}
	

	cout << "Завершение работы программы" << endl;
	system("pause");
    return 0;
}