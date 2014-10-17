package com.kramar42.coursera.algs.unionfind;

/**
 * Created by kramar.
 */
public class QuickFindUF implements UnionFind {
    private int[] id;
    private int count;

    public QuickFindUF(int N) {
        id = new int[N];
        for (int i = 0; i < N; i++) {
            id[i] = i;
        }
        count = N;
    }

    @Override
    public int count() {
        return count;
    }

    @Override
    public int find(int p) {
        return id[p];
    }

    @Override
    public boolean connected(int p, int q) {
        return id[p] == id[q];
    }

    @Override
    public void union(int p, int q) {
        if (connected(p, q)) return;

        int id_p = id[p];
        int id_q = id[q];

        for (int i = 0; i < id.length; i++) {
            if (id[i] == id_p) {
                id[i] = id_q;
            }
        }

        count--;
    }
}
