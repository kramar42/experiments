package com.kramar42.coursera.algs.unionfind;

/**
 * Created by kramar.
 */
public class WeightedQuickUnionUF implements UnionFind {
    private int[] id;
    private int[] sz;
    private int count;

    public WeightedQuickUnionUF(int N) {
        id = new int[N];
        sz = new int[N];
        for (int i = 0; i < N; i++) {
            id[i] = i;
            sz[i] = 1;
        }
        count = N;
    }

    @Override
    public void union(int p, int q) {
        int rp = find(p);
        int rq = find(q);

        if (rp == rq) return;

        if (sz[rp] < sz[rq]) {
            id[rp] = id[rq];
            sz[rq] += sz[rp];
        } else {
            id[rq] = id[rp];
            sz[rp] += sz[rq];
        }

        count--;
    }

    @Override
    public int find(int p) {
        while (p != id[p]) {
            p = id[p];
        }
        return p;
    }

    @Override
    public boolean connected(int p, int q) {
        return find(p) == find(q);
    }

    @Override
    public int count() {
        return count;
    }
}
