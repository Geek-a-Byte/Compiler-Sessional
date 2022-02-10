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
    void insert(string t, string n)
    {

        //pair<<type_of_symbol, pair<hash_index,index_in_the_vector>>
        pair<string, pair<int, int>> ans = lookUp(n);
        int index = ans.second.second;
        if (index != -1)
        {
            cout << "<" << t << "," << n << ">"
                 << " already exists " << endl;
        }
        else
        {
            int hash_index = h_index(n);
            SymbolInfo sinfo = SymbolInfo(n, t);
            symTbl[hash_index].push_back(sinfo);   //pushing as an object
            index = symTbl[hash_index].size() - 1; //index at which the symbol is inserted
            cout << "<" << t << "," << n << ">"
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

    //print table
    void print()
    {

        for (int i = 0; i < 101; i++)
        {
            cout << i << " ------> ";
            for (auto it : symTbl[i])
            {
                cout << "<" << it.type << "," << it.name << ">"
                     << ",";
            }
            cout << endl;
        }
    }
};
//check if a char is number or not
int isNUM(char c)
{
    if ((c >= '0' && c <= '9'))
        return 1;
    else
        return 0;
}

//check if a char is an uppercase or lowercase letter or not
int isChar(char c)
{
    if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z'))
        return 1;
    else
        return 0;
}

//check all the operators
int isOperator(char c, char c1)
{
    /*
    Arithmetic operators : +, -, *, /, %
    Logical operators: &&, ||, ==, !=, !
    Assignment operators: =, +=, -=, *=, /=, %
    */

    if ((c == '&' && c1 == '&') or (c == '|' && c1 == '|') or (c == '=' && c1 == '=') or (c == '!' && c1 == '=') or (c == '+' && c1 == '=') or (c == '-' && c1 == '=') or (c == '*' && c1 == '=') or (c == '/' && c1 == '=') or (c == '%' && c1 == '='))
    {
        //for a 2 length operator return 2
        return 2;
    }
    if ((c == '+' or c == '-' or c == '*' or c == '/' or c == '%' or c == '!' or c == '='))
    {
        //for a one length operator return 1
        return 1;
    }
    return 0;
}

//an identifier cannot start with a number or anything else but a letter or underscore
//so except for the first letter we have to check other letters of the word as well to determine that word is a identifier or not
int isNotIDENTIFIER(char c)
{
    int flag1 = 0;
    int flag2 = 0;
    int flag3 = 0;
    if (!isChar(c))
    {
        flag1 = 1;
    }
    if (!isNUM(c))
    {
        flag2 = 1;
    }
    if (c != '_')
    {
        flag3 = 1;
    }
    return (flag1 and flag2 and flag3);
}

int main()
{
    //fast i/o
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    freopen("sample input.txt", "r", stdin);
    // freopen("output.txt", "w", stdout);
    ofstream op("output_operator.txt");
    ofstream fn("output_function.txt");
    ofstream key("output_keyword.txt");
    ofstream id("output_identifier.txt");

    //single line counter
    int line_count = 0;

    SymbolTable symTbl;
    // vector<string> macros;

    //read until the end of file
    while (!cin.eof())
    {
        string line;

        //read a single line of that file every time
        getline(cin, line);

        //if get an empty line then just increase the line counter and do nothing else
        if (line == "")
        {
            line_count++;
            continue;
        }

        line_count++;
        for (int i = 0; i < line.length(); i++)
        {
            //ignore the preprocessor directives
            if (line[i] == '#')
            {
                break;
                // stringstream ss(line);
                // string word;
                // ss >> word;
                // if (word == "#define")
                // {
                //     ss >> word;
                //     macros.push_back(word);
                // }
            }
            //ignore the statement inside the inverted comma of printf and scanf
            if (line[i] == '"')
            {
                i++;
                while (line[i] != '"')
                {
                    i++;
                }
            }
            //ignore the comments
            if (line[i] == '/' && line[i + 1] == '/')
            {
                break;
            }
            //check for operators
            if (isOperator(line[i], line[i + 1]))
            {
                string word = "";
                if (isOperator(line[i], line[i + 1]) == 2)
                {
                    //if the operator is of 2 length
                    word += line[i];
                    word += line[i + 1];
                }
                else if (isOperator(line[i], line[i + 1]) == 1)
                {
                    //if the operator is of 1 length
                    word = line[i];
                }
                i += word.length();

                op << word << "  " << line_count << endl;
                symTbl.insert("OPERATOR", word); //insert as operator token
            }
            //check for a keyword named if , for , while
            if ((line[i] == 'i' && line[i + 1] == 'f' && line[i + 2] == '(') or
                (line[i] == 'f' && line[i + 1] == 'o' && line[i + 2] == 'r' && line[i + 3] == '(') or
                (line[i] == 'w' && line[i + 1] == 'h' && line[i + 2] == 'i' && line[i + 3] == 'l' && line[i + 4] == 'e' && line[i + 5] == '('))
            {
                string word = "";
                int j = 0;
                while (line[i + j] != '(')
                {
                    word = word + line[i + j];
                    j++;
                }
                //check whether the keyword starts with a number or not
                //if yes then print a lexical error
                if (isNUM(line[i - 1]))
                {
                    cout << "lexical error  " << line_count << endl;
                    i += word.length();
                }
                //else insert into the symbol table as a keyword
                else if (word == "if" || word == "for" || word == "while")
                {
                    i += word.length();
                    key << word << "  " << line_count << endl;
                    symTbl.insert("KEYWORD", word);
                }
            }
            if ((line[i] == 'e' && line[i + 1] == 'l' && line[i + 2] == 's' && line[i + 3] == 'e'))
            {
                string word = "";
                int j = 0;
                while (line[i + j] != '\0')
                {
                    //as else keyword can end with a '{' or it can leave a blank space
                    if (line[i + j] == '{')
                        break;
                    word = word + line[i + j];
                    j++;
                }
                //check whether the keyword starts with a number or not
                //if yes then print a lexical error
                if (isNUM(line[i - 1]))
                {
                    cout << "lexical error  " << line_count << endl;
                    i += word.length();
                }
                else if (word == "else")
                {
                    i += word.length();
                    key << word << "  " << line_count << endl;
                    symTbl.insert("KEYWORD", word);
                }
            }
            if ((line[i] == 'i' and line[i + 1] == 'n' and line[i + 2] == 't') or
                (line[i] == 'b' and line[i + 1] == 'r' and line[i + 2] == 'e' and line[i + 3] == 'a' and line[i + 4] == 'k') or
                (line[i] == 'c' and line[i + 1] == 'h' and line[i + 2] == 'a' and line[i + 3] == 'r') or
                (line[i] == 'f' and line[i + 1] == 'l' and line[i + 2] == 'o' and line[i + 3] == 'a' and line[i + 4] == 't') or
                (line[i] == 'd' and line[i + 1] == 'o' and line[i + 2] == 'u' and line[i + 3] == 'b' and line[i + 4] == 'l' and line[i + 5] == 'e') or
                (line[i] == 'r' and line[i + 1] == 'e' and line[i + 2] == 't' and line[i + 3] == 'u' and line[i + 4] == 'r' and line[i + 5] == 'n'))
            {
                string word = "";
                int j = 0;

                //int or float or char or double ends with a space
                while (line[i + j] != ' ')
                {
                    //return and break ends with ;
                    //the ')' checking is for the condition if the keyword is a substring of a function name
                    if (line[i + j] == ';' or (line[i + j] == ')'))
                        break;
                    word = word + line[i + j];
                    j++;
                }
                //not a function not a keyword not an identifier
                if (isNUM(line[i - 1]))
                {
                    cout << "lexical error  " << line_count << endl;
                    i += word.length();
                }
                //if the word matches with expected keywords then insert into symbol table
                else if (word == "int" || word == "float" || word == "char" || word == "double" || word == "return" || word == "break")
                {
                    i += word.length();
                    key << word << "  " << line_count << endl;
                    symTbl.insert("KEYWORD", word);
                }
                //if the keyword ends with a space, not a first brackett pair then insert as identifier
                else if (word[word.length() - 1] != '(')
                {
                    id << word << "  " << line_count << endl;
                    i += word.length();
                    symTbl.insert("IDENTIFIER", word);
                }
            }
            //identifier checking
            //identifier must start with a letter or underscore
            if ((isChar(line[i]) or line[i] == '_'))
            {
                //subline for checking function declare or function CALL
                //if function_name(keyword pattern is found then it would be function declare
                //so we would store the rest of the line into subline after ( to check whether there is a keyword or not
                string subline;
                string word = "";
                int j = 0;
                int flag = 0; // for identfying the word as a function, whenever there will be a ( char it would break the loop of word making
                              //otherwise it would be an identifier
                while (1)
                {
                    if (line[i + j] == '(')
                    {
                        //storing the subline
                        subline = line.substr(line.find("(") + 1);
                        flag = 1;
                        break;
                    }
                    //we have to check whether there is any other character other than numbers or letters in the identifier
                    if (j > 0 && (isNotIDENTIFIER(line[i + j])))
                    {
                        break;
                    }
                    word = word + line[i + j];
                    j++;
                }

                stringstream ss(subline);
                string wordeach;
                ss >> wordeach;
                if (flag == 1)
                {
                    //if we get a keyword after a ( , then it would be funciton declare
                    if (wordeach == "int" or wordeach == "float" or wordeach == "double" or wordeach == "char")
                    {
                        fn << word << "  " << line_count << endl;
                        i += word.length() - 1;
                        symTbl.insert("FUNCTION DECLARE", word);
                    }
                    //otherwise it would be function call
                    else
                    {
                        fn << word << "  " << line_count << endl;
                        i += word.length() - 1;
                        symTbl.insert("FUNCTION CALL", word);
                    }
                }
                else
                {
                    //if an identifier starts with a number or any other special char then it would show lexical error
                    if (!isChar(line[i - 1]) and line[i - 1] != '_' and line[i - 1] != ' ' and line[i - 2] == ' ' and line[i - 1] != '(' and line[i - 1] != ')' and line[i - 1] != '{' and line[i - 1] != '}' and line[i - 1] != '[' and line[i - 1] != ']')
                    {
                        cout << "lexical error  " << line_count << endl;
                        i += word.length();
                    }
                    //else it would be inserted as an identifier
                    else
                    {
                        id << word << "  " << line_count << endl;
                        i += word.length() - 1;
                        symTbl.insert("IDENTIFIER", word);
                    }
                }
            }

            symTbl.print(); //print after inserting
        }
    }
    // symTbl.print();

    return 0;
}
