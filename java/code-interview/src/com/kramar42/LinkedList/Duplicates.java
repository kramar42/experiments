package com.kramar42.LinkedList;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by kramar on 2/19/17.
 *
 * Write code to remove duplicates from an unsorted linked list.
 * How would you solve this problem if a temporary buffer is not allowed?
 */
public class Duplicates {

    public static LinkedList<Integer> removeDuplicates1(LinkedList<Integer> list) {
        LinkedList<Integer>.Node<Integer> n = list.getHead();
        Set<Integer> elements = new HashSet<>();

        elements.add(n.getData());
        while (n != null && n.hasNext()) {
            Integer data = n.getNext().getData();
            if (elements.contains(data)) {
                list.removeNext(n);
            } else {
                elements.add(data);
            }
            n = n.getNext();
        }

        return list;
    }

    public static LinkedList<Integer> removeDuplicates2(LinkedList<Integer> list) {
        LinkedList<Integer>.Node<Integer> n = list.getHead();
    }
}
