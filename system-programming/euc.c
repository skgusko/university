#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "fillGeoInfo.h"

int* eucDistance(struct coordinate *firstCoor, struct coordinate *secondCoor, int totalLine) {
    int *distanceSeconds = (int *)malloc(sizeof(int) * 32);

    for (int cur = 0; cur < totalLine; cur++) {
        int distance;

        int x1 = firstCoor[cur].longitude.totalSec;
        int y1 = firstCoor[cur].latitude.totalSec;
        int x2 = secondCoor[cur].longitude.totalSec;
        int y2 = secondCoor[cur].latitude.totalSec;

        distance = sqrt(pow(x1 - x2, 2)+ pow(y1 - y2, 2));

        distanceSeconds[cur] = distance;
    }

    return distanceSeconds;
}