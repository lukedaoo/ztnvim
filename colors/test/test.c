#include <stdio.h>
#include <stdlib.h>

#define MAX 10
#define SQUARE(x) ((x) * (x))

typedef struct {
    int id;
    const char *name;
} Item;

enum Color { RED, GREEN = 5, BLUE };

static int counter = 0;

/* add two numbers */
int add(int a, int b) {
    return a + b;
}

int main(void) {
    Item *item = malloc(sizeof(Item));
    if (item == NULL) {
        return 1;
    }

    item->id = 42;
    item->name = "item\n";

    for (int i = 0; i < MAX; i++) {
        counter += SQUARE(i);
    }

    // ternary and char
    char c = counter > 100 ? 'y' : 'n';
    printf("%s %d %c\n", item->name, add(1, 2), c);

    free(item);
    return 0;
}
