package com.kramar42.LinkedList;

/**
 * Created by kramar on 2/19/17.
 *
 */
public class LinkedList<T> {
    private Node<T> head = null;

    public LinkedList() {}

    public LinkedList(T t) {
        head = new Node<>(t);
    }

    public Node<T> getHead() {
        return head;
    }

    public LinkedList add(T t) {
        Node n = head;
        while (n.hasNext())
            n = n.getNext();
        n.setNext(new Node<>(t));
        return this;
    }

    public void removeNext(Node<T> n) {
        if (n.hasNext()) {
            n.setNext(n.getNext().getNext());
        }
    }

    @Override
    public String toString() {
        Node<T> n = head;
        StringBuilder result = new StringBuilder("<" + n.getData());
        while (n.hasNext()) {
            n = n.getNext();
            result.append(", " + n.getData());
        }
        result.append(">");
        return result.toString();
    }

    public class Node<T> {
        private Node next = null;
        private T data;

        public Node(T t) {
            data = t;
        }

        public Node(T t, Node n) {
            this(t);
            next = n;
        }

        public boolean hasNext() {
            return next != null;
        }

        public Node<T> getNext() {
            return next;
        }

        public void setNext(Node n) {
            next = n;
        }

        public T getData() {
            return data;
        }

        public void setData(T t) {
            data = t;
        }
    }
}
