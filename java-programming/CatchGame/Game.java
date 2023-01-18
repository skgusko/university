package CatchGame;

import java.util.Scanner;

public class Game {
    public static void main(String[] args) {
        System.out.println("**도둑 잡기 게임을 시작합니다**");

        int count = 0;
        //기본 격자판 (^로 채워져 있음)
        char arr[][] = new char[3][3];
        for(int i = 0; i < 3; i++) {
            for(int j = 0; j < 3; j++) {
                arr[i][j] = '^';
            }
        }

        Police police = new Police();
        Thief thief = new Thief();

        while(true) {
            int policeX = police.getX();
            int policeY = police.getY();
            int thiefX = thief.getX();
            int thiefY = thief.getY();

            for(int i = 0; i < 3; i++) {
                for(int j = 0; j < 3; j++) {
                    if(policeX == i && policeY == j) {
                        System.out.print(police.getShape());
                    }
                    else if(thiefX == i && thiefY == j) {
                        System.out.print(thief.getShape());
                    }
                    else {
                        System.out.print(arr[i][j]);
                    }
                }
                System.out.print("\n");
            }

            police.move(); //police 좌표 이동함

            System.out.print("왼쪽(a), 아래(s), 위(w), 오른쪽(d), 도둑질(r) >> ");
            Scanner scanner = new Scanner(System.in);
            char cmd = scanner.next().charAt(0);
            if(thief.checkRob(cmd)) {
                arr[thiefX][thiefY] = '-';
                count++;
            }

            if(count == 9) {
                System.out.println("당신이 이겼습니다!");
                break;
            }
            if(thief.collide(police)) {
                System.out.println("경찰에게 잡혔습니다. 당신은 패배하였습니다.");
                break;
            }
        }
    }
}
