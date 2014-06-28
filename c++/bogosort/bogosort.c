#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int correct(int* arr, int size) {
    while (--size > 0) {
        if (arr[size - 1] > arr[size]) {
            return 0;
        }
    }
    return 1;
}

void swap(int* first, int* second) {
    int tmp;
    tmp = *first;
    *first = *second;
    *second = tmp;
}

int* shuffle(int* arr, int size) {
    int i;
    for (i = 0; i < size; i++) {
        swap(arr + i, arr + (rand() % size)); 
    }
    return arr;
}

int* bogosort(int* arr, int size) {
    int* res = malloc(size * sizeof(int));
    memcpy(res, arr, size * sizeof(int));
    while (!correct(arr, size)) {
        arr = shuffle(arr, size);
    }
    return arr;
}

int main(int argc, char* argv[]) {
    int i, size;
    int* arr;
    int* res;
    srand(time(0));

    size = argc - 1;
    arr = malloc(size * sizeof(int));
    for (i = 1; i < argc; i++) {
        arr[i - 1] = atoi(argv[i]);
    }

    res = bogosort(arr, size);
    for (i = 0; i < size; i++) {
        printf("%d ", res[i]);
    }
    printf("\n");
    return 0;
}
