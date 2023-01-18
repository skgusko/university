while(1) {
    adr_sz = sizeof(clnt_adr);
    clnt_sock = accpent(serv_sock, (struct sockaddr*)&clnt_adr, &adr_sz);
    if (clnt_sock == -1) {
        continue;
    }
    else
        puts("new client connected...");
    
    pid = fork();
    if (pid == -1)
        close(clnt_sock);
    if (pid == 0) {
        close(serv_sock);
        while(str_len=read(clnt_sock, buf, BUF_SIZE))
            write(clnt_sock, buf, str_len);
        close(clnt_sock);
        puts("client disconnected...");
        return 0;
    }
    else {
        close(clnt_sock);
    }
}