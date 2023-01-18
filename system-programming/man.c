#include <stdio.h>
#include <stdlib.h>
#include "fillGeoInfo.h"

int* manDistance(struct coordinate *firstCoor, struct coordinate *secondCoor, int totalLine) {
    int *distanceSeconds = (int *)malloc(sizeof(int) * 32);

    for (int cur = 0; cur < totalLine; cur++) {
        int distance = 0;

        int x1 = firstCoor[cur].longitude.totalSec;
        int y1 = firstCoor[cur].latitude.totalSec;
        int x2 = secondCoor[cur].longitude.totalSec;
        int y2 = secondCoor[cur].latitude.totalSec;

        int x_distance = abs(x1-x2);
        int y_distance = abs(y1-y2);
        
        distance = x_distance + y_distance;
        distanceSeconds[cur] = distance;
    }

    return distanceSeconds;
}