#include <iostream>

using namespace std;

class A
{
public:
    A(){}
    ~A(){}
    void Print()
    {
        cout << "A" << endl;
    }
};
class B : public A
{
public:
    B(){}
    ~B(){}
    void Print()
    {
        cout << "B" << endl;
    }
};
int main()
{
    B b;
    A& a = b; //down
    B& b2 = static_cast<B&>(a);

    a.Print();
    b.Print();
    b2.Print();

    cin.get();
    return 0;
}

输出为：A B B
