package CatchGame;

public abstract class GameObject { //추상 클래스
    protected int x, y; //현재 위치(화면 맵 상의 위치)

    public GameObject(int x, int y) { //초기 위치 설정 생성자 (3x3에서 내가 어디에 있는지)
        this.x = x; this.y = y;
    }

    public int getX() {   return x; }
    public int getY() {   return y; }
    public boolean collide(GameObject p) { //이 객체가 객체 p와 충돌했으면 true 리턴
        if(this.x == p.getX() && this.y == p.getY())
            return true;
        else
            return false;
    }
    protected abstract boolean move(); //이동한 후의 새로운 위치로 x, y 변경, 도둑질을 했는지 리턴
    protected abstract char getShape(); //객체의 모양을 나타내는 문자 리턴
}