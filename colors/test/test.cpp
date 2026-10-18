#include <iostream>
#include <vector>
#include <string>

namespace demo {

template <class T>
class A {
private:
    int a;

public:
    const int get_a() const { return a; }
    virtual ~A() = default;
};

struct Point {
    double x, y;
};

enum class Color { Red, Green };

}  // namespace demo

template <typename T>
T maxOf(const T &a, const T &b) {
    return a > b ? a : b;
}

int main() {
    std::vector<int> v = {1, 2, 3};
    auto lambda = [&](int n) { return n * 2; };
    std::string s = "hello";

    for (const auto &n : v) {
        std::cout << lambda(n) << '\n';
    }

    try {
        throw std::runtime_error("oops");
    } catch (const std::exception &e) {
        std::cerr << e.what() << std::endl;
    }

    demo::A<int> *p = new demo::A<int>();
    delete p;
    return nullptr == p ? 0 : 1;
}
