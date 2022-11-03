package CatchGame;

import java.util.Scanner;

public class Thief extends GameObject {
    //도둑 객체를 위한 클래스

    public Thief() {
        super(2, 2);
    }
    public Thief(int x, int y) {
        super(x, y);
    }

    private char cmd = '\0';
    public boolean checkRob(char cmd) {
        this.cmd = cmd;
        return move();
    }

    @Override
    protected boolean move() { //이동한 후의 새로운 위치로 x, y 변경, 도둑질을 했는지 리턴

        if(this.cmd == 'a') { //좌
            if(super.y != 0) {
                super.y--;
            }
        }
        else if(this.cmd == 's') { //하
            if(super.x != 2) {
                super.x++;
            }
        }
        else if(this.cmd == 'w') { //상
            if(super.x != 0) {
                super.x--;
            }
        }
        else if(this.cmd == 'd') { //우
            if(super.y != 2) {
                super.y++;
            }
        }
        else if(this.cmd == 'r') {
            return true; //도둑질 했으면 true
        }
        return false;
    }

    @Override
    protected char getShape() { //객체의 모양을 나타내는 문자 리턴
        return '&';
    }
}