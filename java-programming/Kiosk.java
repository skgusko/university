import java.util.Scanner;
class Menu {
    private String name;
    private int price;
    private int inventory;
    Menu(String name, int price, int inventory) {
        this.name = name;
        this.price = price;
        this.inventory = inventory;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getName() {
        return this.name;
    }
    public void setPrice(int price) {
        this.price = price;
    }
    public int getPrice() {
        return this.price;
    }
    public void setInventory(int inventory) {
        this.inventory = inventory;
    }
    public int getInventory() {
        return this.inventory;
    }
    public int currentOrder = 0;
    public void setCurrentOrder() {
        this.currentOrder = 0;
    }
    public int getCurrentOrder() {
        return this.currentOrder;
    }
}
public class Kiosk {
    public static void main(String[] args) {
        //키오스크 초기화
        System.out.println("[키오스크 초기화]");
        System.out.print("판매하고자 하는 메뉴 종류 수를 입력하세요 >> ");
        Scanner scanner = new Scanner(System.in);
        int num = scanner.nextInt();
        Menu [] menuArr = new Menu[num];
        for (int i = 0; i < num; i++) {
            System.out.print("판매하고자 하는 " + i + "번째 메뉴 이름, 가격, 재고를 입력하세요(예: 아메리카노 2000 10) >> ");
            String name = scanner.next();
            int price = scanner.nextInt();
            int inventory = scanner.nextInt();
            menuArr[i] = new Menu(name, price, inventory);
        }
        System.out.println("[초기화 완료]");

        //사용자로부터 주문 입력 받음
        System.out.println("");
        String order = "";
        while(!order.equals("종료")) {
            System.out.println("메뉴판");
            for (int i = 0; i < menuArr.length; i++) {
                System.out.println(menuArr[i].getName() + ":" + menuArr[i].getPrice() + "원(재고:" + menuArr[i].getInventory() + ")");
                menuArr[i].setCurrentOrder();
            }
            System.out.println("원하는 메뉴를 입력하세요(띄어쓰기로 메뉴 구분, 마지막에는 '주문' 입력) >> ");
            order = scanner.next();

            //재고관리
            if (order.equals("재고관리")) {
                System.out.println("[관리자 모드]");
                String orderInManagement = "";
                while(!orderInManagement.equals("종료")) {
                    System.out.print("관리자 모드를 나가려면 '종료', 재고 변경을 원하면 메뉴 이름을 입력하세요 >>");
                    orderInManagement = scanner.next();
                    for (int i = 0; i < menuArr.length; i++) {
                        if (orderInManagement.equals(menuArr[i].getName())) {
                            System.out.println(menuArr[i].getName() + "의 재고는 현재 " + menuArr[i].getInventory() + "입니다. 변경을 원하시는 수량을 입력하세요 >>");
                            int newInventory = scanner.nextInt();
                            menuArr[i].setInventory(newInventory);
                            break;
                        }
                    }
                }
            }
            else if (order.equals("종료")) {
                continue;
            }
            //주문
            else {
                int sum = 0;
                int check = 0; //check가 0이 아니면 재고부족 발생한 경우
                while(!order.equals("주문")) {
                    //inventory가 0이면 다시 주문하기 출력. 아니면 합계 출력
                    for (int i = 0; i < menuArr.length; i++) {
                        if (order.equals(menuArr[i].getName())) {
                            if (menuArr[i].getInventory() - menuArr[i].currentOrder != 0) {
                                menuArr[i].currentOrder++;
                                sum += menuArr[i].getPrice();
                                break;
                            }
                            else {
                                check++;
                            }
                        }
                    }
                    order = scanner.next();
                }
                if (check == 0) {
                    //재고 한 번에 빼주기
                    for (int i = 0; i < menuArr.length; i++) {
                        menuArr[i].setInventory(menuArr[i].getInventory()-menuArr[i].getCurrentOrder());
                    }
                    System.out.println("전체 금액은 " + sum + "원입니다.");
                }
                else {
                    System.out.println("재고가 부족한 상품이 있습니다. 다시 주문해주세요.");
                }
            }
        }
        System.out.println("종료되었습니다");
        scanner.close();
    }
}