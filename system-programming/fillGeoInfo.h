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

int getGIS(char *filename, struct coordinate *a, struct coordinate *b);

void parseDMS(struct coordinate *arr, int totalLine) ;

void calTotalSec(struct coordinate *arr, int totalLine) ;

void setGeoInfo(struct coordinate *firstCoor, struct coordinate *secondCoor, int totalLine);

void printDMS(int distanceSeconds);