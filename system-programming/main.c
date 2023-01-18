#include <stdlib.h>
#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
#include "fillGeoInfo.h"


int main(int argc, char *argv[]) {
    void *handle;
    int* (*tool)(struct coordinate *, struct coordinate *, int);
    char *error;
    
    //입력값에 따라 라이브러리 선택
    if (strcmp(argv[2], "man") == 0) {
        handle = dlopen("./libman.so", RTLD_LAZY);
    }
    else if (strcmp(argv[2], "euc") == 0) {
        handle = dlopen("./libeuc.so", RTLD_LAZY);
    }

    if (!handle) {
        fprintf(stderr, "%s\n", dlerror());
        exit(1);
    }

    //입력값에 따라 라이브러리 내 함수 선택
    if (strcmp(argv[2], "man") == 0) {
        tool = dlsym(handle, "manDistance");
    }
    else if (strcmp(argv[2], "euc") == 0) {
        tool = dlsym(handle, "eucDistance");
    }

    if ((error = dlerror()) != NULL) {
        fprintf(stderr, "%s\n", error);
        exit(1);
    }

    //배열 생성
    struct coordinate firstCoor[32], secondCoor[32];

    //입력 텍스트 파일의 라인 수
    int totalLine = getGIS(argv[1], firstCoor, secondCoor);
    setGeoInfo(firstCoor, secondCoor, totalLine);

    int *distanceSecondsArr = tool(firstCoor, secondCoor, totalLine);

    for (int i = 0; i < totalLine; i++) {
    printf("(%03dd %02dm %02ds %c, %02dd %02dm %02ds %c) (%03dd %02dm %02ds %c, %02dd %02dm %02ds %c) %06d ", 
            firstCoor[i].longitude.degree, firstCoor[i].longitude.minute, firstCoor[i].longitude.second, firstCoor[i].longitude.direction,
            firstCoor[i].latitude.degree, firstCoor[i].latitude.minute, firstCoor[i].latitude.second, firstCoor[i].latitude.direction,
            secondCoor[i].longitude.degree, secondCoor[i].longitude.minute, secondCoor[i].longitude.second, secondCoor[i].longitude.direction,
            secondCoor[i].latitude.degree, secondCoor[i].latitude.minute, secondCoor[i].latitude.second, secondCoor[i].latitude.direction,
            distanceSecondsArr[i]);
    printDMS(distanceSecondsArr[i]);
    printf("\n");
    }

    if (dlclose(handle) < 0) {
        fprintf(stderr, "%s\n", dlerror());
        exit(1);
    }
    
    return 0;
}