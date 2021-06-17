#include <bits/stdc++.h>
#define endl "\n"
using namespace std;
class SymbolTable; //prototyped the class to make it friend of symbolinfo
class SymbolInfo
{
    string name;
    string type;

public:
    SymbolInfo(string n, string t)
    {
        name = n;
        type = t;
    }
    friend SymbolTable; //to access the private member variables of SymbolInfo from SymbolTable
};
class SymbolTable
{
    vector<SymbolInfo> symTbl[101]; //we used sth mod 101 at last of hashing technique so hash_index would be always less than 101

public:
    //hash index determiner
    int h_index(string n)
    {
        //technique 1
        int mid = n[n.length() / 2];
        int mult = mid * 32; //my roll is 32
        return (mult % 101);
    }

    // insert
    void insert(string n, string t)
    {

        //pair<<type_of_symbol, pair<hash_index,index_in_the_vector>>
        pair<string, pair<int, int>> ans = lookUp(n);

        //first we will search whether the string we want to insert into the hash table is already in the hash table or not
        //if both the symbol and the type of symbol is already present (index != -1 && ans.first == t), then we would say it already exists
        //if there is a symbol which is the similar to the inputted name/symbol but the type of it differs from the inputted type then we will insert that name and type to the hash table
        int index = ans.second.second;
        if (index != -1 && ans.first == t)
        {
            cout << "<" << n << " , " << t << ">"
                 << " already exists " << endl;
        }
        else
        {
            int hash_index = h_index(n);
            SymbolInfo sinfo = SymbolInfo(n, t);
            symTbl[hash_index].push_back(sinfo);   //pushing as an object
            index = symTbl[hash_index].size() - 1; //index at which the symbol is inserted
            cout << "<" << n << "," << t << ">"
                 << " inserted at position "
                 << "(" << hash_index << "," << index << ")" << endl;
        }
    }
    //look up
    //pair<<type_of_symbol, pair<hash_index,index_in_the_vector>>
    pair<string, pair<int, int>> lookUp(string n)
    {
        int hash_index = h_index(n);
        int index = -1; //if the  symbol is not found , then index would be -1
        string t;       //for storing the type of the looked up string
        int j = 0;

        for (auto it : symTbl[hash_index])
        {
            if (it.name == n)
            {
                index = j; //if the symbol is present, index will be updated
                t = it.type;
                break;
            }
            j++;
        }

        return {t, {hash_index, index}};
    }
    //delete symbol
    void Delete(string n)
    {
        int hash_index = h_index(n);
        int index = 0;
        int flag = 0; //needed to use to check if the vector is empty or the symbol is present or not
        vector<SymbolInfo>::iterator it;
        for (it = symTbl[hash_index].begin(); it != symTbl[hash_index].end(); it++)
        {
            if (it->name == n)
            {
                symTbl[hash_index].erase(it); //erasing the symbol
                cout << "Deleted From "
                     << "(" << hash_index << "," << index << ")" << endl;
                flag = 1; //if the symbol is found and deleted then flag=1
                break;
            }
            index++;
        }
        //if the symbol is not present then it cannot be Deleted
        //or if the vector is empty itself, nothing can be Deleted
        //so in both cases flag will remain 0
        if (flag == 0)
        {
            cout << n << " not found\n";
        }
    }

    //print table
    void print()
    {

        for (int i = 0; i < 101; i++)
        {
            cout << i << " ------> ";
            for (auto it : symTbl[i])
            {
                cout << "<" << it.name << "," << it.type << ">"
                     << " , ";
            }
            cout << endl;
        }
    }
};

int main()
{
    //fast i/o
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);

    char s;
    SymbolTable symTbl;
    string name, type;
    while (cin >> s)
    {
        if (s == 'I')
        {
            cin >> name >> type;
            symTbl.insert(name, type);
        }
        else if (s == 'P')
            symTbl.print();
        else if (s == 'L')
        {
            cin >> name;
            pair<string, pair<int, int>> ans = symTbl.lookUp(name);
            if (ans.second.second == -1)
            {
                cout << name << " not Found\n";
            }
            else
            {
                cout << "<" << name << "," << ans.first << ">"
                     << " found at position "
                     << "(" << ans.second.first << "," << ans.second.second << ")" << endl;
            }
        }
        else if (s == 'D')
        {
            cin >> name;
            symTbl.Delete(name);
        }
    }

    return 0;
}