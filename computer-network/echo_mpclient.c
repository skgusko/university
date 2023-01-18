int main() {
    pid = fork();

    if (pid == 0) {
        write_routine(int sock, char* buf);
    }
    else {
        read_routine(int sock, char* buf);
    }
}

void write_routine(int sock, char* buf) { //키보드로 입력받아 소켓에 데이터 씀
    fgets(buf, BUF_SIZR, stdin);
    if (!strcmp ) {
        close(sock);
        return;
    }

    write(sock, buf, strlen(buf));
}

void read_routine(int sock, char* buf) {
    while(1) {
        int str_len = read(sock, buf, BUF_SIZE);
        buf[str_len] = 0;
        printf(buf);
    }
}