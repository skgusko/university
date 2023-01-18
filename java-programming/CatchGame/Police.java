package CatchGame;

public class Police extends GameObject {
    //경찰 객체를 위한 클래스
    public Police() {
        super(0, 0);
    }
    public Police(int x, int y) {
        super(x, y);
    }

    @Override
    protected boolean move() {
        int n = (int)(Math.random()*100 + 1);
        if(n>=1 && n<=20) { //상
            if(super.x != 0) {
                super.x--;
            }
        }
        else if(n>=21 && n<=40) { //하
            if(super.x != 2) {
                super.x++;
            }
        }
        else if(n>=41 && n<=60) { //좌
            if(super.y != 0) {
                super.y--;
            }
        }
        else if(n>=61 && n<=80) { //우
            if(super.y != 2) {
                super.y++;
            }
        }
        else {}; //정지

        return true;
    }

    @Override
    protected char getShape() { //객체의 모양을 나타내는 문자 리턴\
        return 'p';
    }
}
