import java.io.*;
import java.util.*;

public class WordCount {
    public static TreeMap<String, Integer> wordCnt = new TreeMap<>();

    public static void main(String[] args) {
        System.out.println("Word Count");

        // input, output 파일명 입력받기
        Scanner sc = new Scanner(System.in);
        System.out.print("Input file name: ");
        String input_file = sc.next();
        System.out.print("Output file name: ");
        String output_file = sc.next();

        int c;
        byte[] buf = new byte[9999];

        try {
            FileInputStream fi = new FileInputStream(input_file);
            FileOutputStream fo = new FileOutputStream(output_file);
            c = fi.read(buf);
            // buf 배열을 String으로 변환
            String strBuff = new String(buf, 0, c);

            // 구분자 기준으로 자르고 MAP에 단어&개수 넣기
            StringTokenizer st = new StringTokenizer(strBuff, ",.:;?![]()\s\r\n");
            while (st.hasMoreTokens()) {
                String word = st.nextToken().toLowerCase();
                if (wordCnt.containsKey(word)) {
                    int cnt = wordCnt.get(word);
                    wordCnt.put(word, cnt + 1);
                } else {
                    wordCnt.put(word, 1);
                }
            }

            // MAP의 key, value 출력
            for (Map.Entry<String, Integer> entry : wordCnt.entrySet()) {
                String key = entry.getKey();
                int value = entry.getValue();
                fo.write((key + "\t\t" + value + "\n").getBytes());
            }
        } catch (IOException e) {
            System.out.println("IOException");
        }
    }
}
