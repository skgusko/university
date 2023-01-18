import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import java.security.Key;

import javax.swing.event.*;
import java.util.ArrayList;
import java.util.Stack;
import java.math.*;

public class CalculatorFrame extends JFrame {
    private String command = ""; // processText에 setText될 String
    private JLabel processText;
    private JLabel resultText;

    // 사칙연산, 결과값 출력 부분
    class ArithmeticPanel extends JPanel {
        public ArithmeticPanel() {
            setLayout(new BorderLayout());
            processText = new JLabel(" "); // 사칙연산 과정
            resultText = new JLabel("0"); // 결과값
            processText.setFont(new Font("맑은 고딕", Font.PLAIN, 20));
            processText.setForeground(Color.GRAY);
            resultText.setFont(new Font("맑은 고딕", Font.BOLD, 40));
            processText.setHorizontalAlignment(SwingConstants.RIGHT);
            resultText.setHorizontalAlignment(SwingConstants.RIGHT);
            add(processText, BorderLayout.NORTH);
            add(resultText, BorderLayout.SOUTH);
        }
    }

    // 버튼
    class ButtonPanel extends JPanel {
        String[] button_text = { "^", "DEL", "CE", "/", "7", "8", "9", "x", "4", "5", "6", "-", "1", "2", "3", "+", "√",
                "0", ".", "=" };

        public ButtonPanel() {
            setLayout(new GridLayout(5, 4, 4, 4));

            JButton[] btn = new JButton[button_text.length];
            for (int i = 0; i < button_text.length; i++) {
                btn[i] = new JButton(button_text[i]);
                if (button_text[i] == "=") {
                    btn[i].setBackground(Color.LIGHT_GRAY);
                    btn[i].setForeground(Color.WHITE);
                } else
                    btn[i].setBackground(Color.WHITE);

                btn[i].setBorderPainted(false);
                btn[i].setFont(new Font("맑은 고딕", Font.PLAIN, 15));
                btn[i].addActionListener(new MyActionListener());
                btn[i].addKeyListener(new MyKeyListener());
                btn[i].setFocusable(true);
                btn[i].requestFocus();
                add(btn[i]);
            }
        }
    }

    class MyActionListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            // 눌린 버튼에 써있는 값
            String pressedText = e.getActionCommand();

            if (pressedText.equals("DEL")) {
                command = command.substring(0, command.length() - 1);
            } else if (pressedText.equals("CE")) {
                command = " ";
                resultText.setText(" ");
            } else if (pressedText.equals("=")) {
                String result = calculate(command);
                resultText.setText(result);
                command = result;
            } else {
                command = command + pressedText;
            }
            processText.setText(command);
        }
    }

    class MyKeyListener extends KeyAdapter {
        public void keyPressed(KeyEvent e) {
            char c = e.getKeyChar();

            if (c == '+' || c == '-' || c == 'x' || c == '/' || c == '.' || c == '^') {
                command = command + c;
            } else if (c == 'r') {
                command = command + '√';
            } else if (e.getKeyCode() == KeyEvent.VK_DELETE) {
                command = command.substring(0, command.length() - 1);
            } else if (e.getKeyCode() == KeyEvent.VK_BACK_SPACE) {
                command = " ";
                resultText.setText(" ");
            } else if (e.getKeyCode() == KeyEvent.VK_EQUALS || e.getKeyCode() == KeyEvent.VK_ENTER) {
                String result = calculate(command);
                resultText.setText(result);
                command = result;
            } else {
                for (int i = 0; i < 10; i++) {
                    if (c == '0' + i) {
                        command = command + c;
                    }
                }
            }
            processText.setText(command);
        }
    }

    // 연산자 우선순위 부여
    public int priority(char operation) {
        switch (operation) {
            case '+':
                return 1;
            case '-':
                return 1;
            case 'x':
                return 2;
            case '/':
                return 2;
            case '^':
                return 3;
            case '√':
                return 3;
            default:
                return -1;
        }
    }

    public String calculate(String command) {

        /* 후위표기법 처리 */
        String num = "";
        ArrayList<String> postfix = new ArrayList<String>(); // 후위표기법으로 저장
        Stack<Character> operation_stack = new Stack<Character>(); // 연산자 저장

        char[] operation = { '+', '-', 'x', '/', '^', '√' };

        for (int i = 0; i < command.length(); i++) {
            boolean check = false;
            // command.charAt(i)가 연산자일 경우
            for (int j = 0; j < operation.length; j++) {
                if (command.charAt(i) == operation[j]) {
                    check = true;
                    // 숫자 저장해두기
                    if (!num.equals("")) {
                        postfix.add(num);
                        num = "";
                    }
                    // stack 비어있으면 stack에 그냥 넣기
                    if (operation_stack.isEmpty()) {
                        operation_stack.push(command.charAt(i));
                    }
                    // stack 비어있지 않으면 우선순위에 따라 넣기
                    else {
                        if (priority(operation_stack.peek()) < priority(command.charAt(i))) {
                            operation_stack.push(command.charAt(i));
                        } else {
                            postfix.add(operation_stack.pop().toString());
                            operation_stack.push(command.charAt(i));
                        }
                    }
                }

            }
            // command.charAt(i)가 숫자일 경우
            if (!check)
                num += command.charAt(i);
        }
        // 숫자 남아있는 경우 postfix에 넣기
        if (!num.equals("")) {
            postfix.add(num);
        }
        // 스택에 연산자 남아있는 경우 postfix에 넣기
        while (!operation_stack.isEmpty()) {
            postfix.add(operation_stack.pop().toString());
        }

        Stack<String> toCalculate = new Stack<String>();
        /* 후위표기법에 따른 결과값 계산 */
        for (int i = 0; i < postfix.size(); i++) {
            toCalculate.push(postfix.get(i));
            for (int j = 0; j < operation.length; j++) {
                if (postfix.get(i).charAt(0) == operation[j]) {
                    toCalculate.pop();
                    String result_double = "";
                    double num2 = Double.parseDouble(toCalculate.pop());

                    if (postfix.get(i).charAt(0) == '^') {
                        result_double = Double.toString(num2 * num2);
                    } else if (postfix.get(i).charAt(0) == '√') {
                        result_double = Double.toString(Math.sqrt(num2));
                    } else {
                        double num1 = Double.parseDouble(toCalculate.pop());
                        if (postfix.get(i).charAt(0) == '+') {
                            result_double = Double.toString(num1 + num2);
                        } else if (postfix.get(i).charAt(0) == '-') {
                            result_double = Double.toString(num1 - num2);
                        } else if (postfix.get(i).charAt(0) == 'x') {
                            result_double = Double.toString(num1 * num2);
                        } else if (postfix.get(i).charAt(0) == '/') {
                            result_double = Double.toString(num1 / num2);
                        }
                    }

                    toCalculate.push(result_double);
                }

            }
        }
        String result = toCalculate.pop();

        return result;
    }

    public CalculatorFrame() {
        setTitle("계산기");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        Container c = getContentPane();

        setLayout(new BorderLayout());
        c.add(new ArithmeticPanel(), BorderLayout.NORTH);
        c.add(new ButtonPanel(), BorderLayout.CENTER);

        //
        setSize(400, 400);
        setVisible(true);
    }

    public static void main(String[] args) {
        new CalculatorFrame();
    }
}
