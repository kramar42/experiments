package com.kramar42.StringsArrays;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by kramar on 2/19/17.
 *
 */
public class Util {

    public static Map<Character, Integer> frequencyMap(String string) {
        char[] charArray = string.toCharArray();
        Map<Character, Integer> freqMap = new HashMap<>(charArray.length * 4 / 3);
        for (char c : charArray) {
            freqMap.put(c, freqMap.getOrDefault(c, 0) + 1);
        }
        return freqMap;
    }
}
