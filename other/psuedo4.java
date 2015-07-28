package playground2;

import java.util.*;
public class Playground2 {
      
    public static void main(String[] args) {
        
        int array[];
        int prefix[];

        String prompt1 = "Enter starting element: ";
        String prompt2 = "Enter array size: "; 

        String prompt3 = "\nInput array:\n";
        String prompt4 = "<address of A[%d]>: %d\n";

        String prompt5 = "\nPrefix Sum:\n";
        String prompt6 = "<address of PrefixSum[%d]>: %d\n";


        Scanner in = new Scanner(System.in);
        
        System.out.print(prompt1);
        String input = in.next();
        int arrayStart = Integer.parseInt(input);
        
        System.out.print(prompt2);
        input = in.next();
        int arraySize = Integer.parseInt(input);
        
        array = new int[arraySize];
        prefix = new int[arraySize];
        
        for (int i = 0; i < arraySize; i++) {
            array[i] = arrayStart;
            if (i == 0) {
                prefix[i] = arrayStart;
            } else {
                prefix[i] = prefix[i - 1] + array[i];
            }
            arrayStart++;
        }
        System.out.println(prompt3);
        
        for (int j = 0; j < array.length; j++) {
            System.out.printf(prompt4, j, array[j]);
        }
        
        System.out.println(prompt5);
        
        for (int k = 0; k < array.length; k++) {
            System.out.printf(prompt4, k, prefix[k]);
        }
    }
}
