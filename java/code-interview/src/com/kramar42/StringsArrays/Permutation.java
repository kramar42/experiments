package com.kramar42.StringsArrays;

import java.util.Arrays;
import java.util.Map;
import java.util.Objects;

/**
 * Created by kramar on 2/19/17.
 *
 * Given two strings, write a method to decide if one is a permutation of the other.
 */
public class Permutation {

    public static boolean arePermutated1(String first, String second) {
        char[] firstChars = first.toCharArray();
        char[] secondChars = second.toCharArray();

        Arrays.sort(firstChars);
        Arrays.sort(secondChars);

        return Arrays.equals(firstChars, secondChars);
    }

    public static boolean arePermutated2(String first, String second) {
        Map<Character, Integer> firstMap = Util.frequencyMap(first);
        Map<Character, Integer> secondMap = Util.frequencyMap(second);

        for (Character key : firstMap.keySet()) {
            // frequency map can't have 0 as a value
            if (! firstMap.get(key).equals(secondMap.getOrDefault(key, 0)))
                return false;
        }
        return true;
    }
}
