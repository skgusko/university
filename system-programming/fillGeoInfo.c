#include <stdio.h>

struct geoinfo {
    int degree;
    int minute;
    int second;
    int totalSec;
    int dms;
    char direction;
};

struct coordinate {
    struct geoinfo longitude;
    struct geoinfo latitude;
};

int getGIS(char *filename, struct coordinate *a, struct coordinate *b) {
    printf("%s\n", filename);
    FILE *fp = fopen(filename, "r");
    int cur = 0;
    while (!feof(fp)) {
        fscanf(fp, "(%d%c, %d%c) (%d%c, %d%c) \n",
            &a[cur].longitude.dms, &a[cur].longitude.direction,
            &a[cur].latitude.dms, &a[cur].latitude.direction,
            &b[cur].longitude.dms, &b[cur].longitude.direction,
            &b[cur].latitude.dms, &b[cur].latitude.direction);
            cur++;
    }
    fclose(fp);
    return cur;
}

void parseDMS(struct coordinate *arr, int totalLine) {
    for (int cur = 0; cur < totalLine; cur++) {
        int longDMS = arr[cur].longitude.dms;
        int latiDMS = arr[cur].latitude.dms;

        //degree
        arr[cur].longitude.degree = longDMS/10000;
        longDMS = longDMS%10000;
        arr[cur].latitude.degree = latiDMS/10000;
        latiDMS = latiDMS%10000;

        //minute
        arr[cur].longitude.minute = longDMS/100;
        longDMS = longDMS%100;
        arr[cur].latitude.minute = latiDMS/100;
        latiDMS = latiDMS%100;

        //second
        arr[cur].longitude.second = longDMS;
        arr[cur].latitude.second = latiDMS;
    }
}

void calTotalSec(struct coordinate *arr, int totalLine) {
    for (int cur = 0; cur < totalLine; cur++) {
        //longitude
        int longSec = 0;
        longSec += (arr[cur].longitude.degree * 3600 + arr[cur].longitude.minute * 60 + arr[cur].longitude.second);
        if (arr[cur].longitude.direction == 'W') {
            longSec = -longSec;
        }
        arr[cur].longitude.totalSec = longSec;

        //latitude
        int latiSec = 0;
        latiSec += (arr[cur].latitude.degree * 3600 + arr[cur].latitude.minute * 60 + arr[cur].latitude.second);
        if (arr[cur].latitude.direction == 'S') {
            latiSec = -latiSec;
        }
        arr[cur].latitude.totalSec = latiSec;
    }
}

void setGeoInfo(struct coordinate *firstCoor, struct coordinate *secondCoor, int totalLine) {
    parseDMS(firstCoor, totalLine);
    parseDMS(secondCoor, totalLine);
    calTotalSec(firstCoor, totalLine);
    calTotalSec(secondCoor, totalLine);
}

void printDMS(int distanceSeconds) {
    int temp = distanceSeconds;
    int degree = temp/3600;
    temp %= 3600;
    int minute = temp/60;
    temp %= 60;
    int second = temp;

    printf("%03dd %02dm %02ds", degree, minute, second);
}