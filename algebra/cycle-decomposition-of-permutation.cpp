#include <iostream>
#include <cassert>

typedef unsigned char Number;

void cycleDecomposition(const Number* const permutation, const Number length) {
    assert(length);
    bool* visit = new bool[length];
    for(Number i = 0; i < length; ++i) {
        visit[i] = false;
    }
    bool found = true;
    while(found) {
        found = false;
        Number i = 0;
        for(Number j = 0; j < length; ++j) {
            if(!visit[j]) {
                found = true;
                visit[j] = true;
                i = j;
                break;
            }
        }
        if(found && (permutation[i] != i + 1)) {
            const Number x = i + 1;
            Number current = x;
            std::cout << '(' << static_cast<unsigned short>(x);
            while(permutation[current - 1] != x) {
                current = permutation[current - 1];
                visit[current - 1] = true;
                std::cout << ' ' << static_cast<unsigned short>(current);
            }
            std::cout << ')';
        }
    }
    delete[] visit;
}

int main() {
    const Number length = 10;
    const Number permutation[length] = {3, 2, 4, 1, 6, 7, 8, 5, 10, 9};
    cycleDecomposition(permutation, length);
    std::cout << std::endl;
    return 0;
}
