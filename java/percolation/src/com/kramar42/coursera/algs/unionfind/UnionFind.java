package com.kramar42.coursera.algs.unionfind;

/**
 * Created by kramar on 9/9/14.
 */
public interface UnionFind {
    public void union(int p, int q);
    public int find(int p);
    public boolean connected(int p, int q);

    public int count();
}
