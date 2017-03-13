package com.kramar42.StringsArrays;

import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * Created by kramar on 2/19/17.
 *
 * Implement an algorithm to determine if a string has all unique characters.
 * What if you cannot use additional data structures?
 */
public class UniqueChars {

    public static boolean hasUniqueChars1(String string) {
        char[] charArray = string.toCharArray();
        // first attempt
        Set<Character> chars = new HashSet<>(charArray.length * 4 / 3);
        for (char c : charArray) {
            chars.add(c);
        }
        return chars.size() == string.length();
    }

    public static boolean hasUniqueChars2(String string) {
        // using frequency map
        Map<Character, Integer> freqMap = Util.frequencyMap(string);
        for (Integer freq : freqMap.values()) {
            if (freq > 1) {
                return false;
            }
        }
        return true;
    }

    public static boolean hasUniqueChars3(String string) {
        char[] charArray = string.toCharArray();
        // without data structures
        // brute-force
        for (int i = 0; i < charArray.length - 1; i++) {
            for (int j = i + 1; j < charArray.length; j++) {
                if (charArray[i] == charArray[j])
                    return false;
            }
        }
        return true;
    }

    public static boolean hasUniqueChars4(String string) {
        char[] charArray = string.toCharArray();
        // if array is sorted only one pass is needed
        Arrays.sort(charArray);
        for (int i = 0; i < charArray.length - 1; i++) {
            if (charArray[i] == charArray[i + 1])
                return false;
        }
        return true;
    }
}
