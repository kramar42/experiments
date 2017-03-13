package com.kramar42.StringsArrays;

import com.sun.javafx.geom.AreaOp;

/**
 * Created by kramar on 2/19/17.
 *
 * Write a method to replace all spaces in a string with '%20'.
 * You may assume that the string has sufficient space at the end of the string
 * to hold the additional characters, and that you are given the "true" length of
 * the string. (Note: if implementing in Java, please use a character array so that
 * you can perform this operation in place.)
 */
public class SpaceInURL {
    public static String spaceInURL(String string) {
        char[] chars = string.toCharArray();

        int lastChar = getLastChar(chars);
        int nearestSpace;
        int end = chars.length - 1;
        while (lastChar > 0) {
            nearestSpace = getNearestSpace(chars, lastChar);
            copyBackwards(chars, nearestSpace + 1, end, lastChar - nearestSpace);
            end -= (lastChar - nearestSpace);
            lastChar = nearestSpace - 1;
        }

        return new String(chars);
    }

    private static int getLastChar(char[] chars) {
        for (int i = chars.length - 1; i > 0; i--) {
            if (chars[i] != ' ') {
                return i;
            }
        }
        return -1;
    }

    private static int getNearestSpace(char[] chars, int fromPosition) {
        for (int i = fromPosition; i > 0; i--) {
            if (chars[i] == ' ')
                return i;
        }
        return -1;
    }

    private static void copy(char[] chars, int from, int to, int amount) {
        if (to + amount > chars.length)
            return;

        for (int i = 0; i < amount; i++) {
            chars[to + i] = chars[from + i];
        }
    }

    /**
     * @param to at which position should be last copied char
     */
    private static void copyBackwards(char[] chars, int from, int to, int amount) {
        copy(chars, from, to - amount, amount);
    }
}
