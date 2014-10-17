package com.kramar42.coursera.algs.percolation;

import com.kramar42.coursera.algs.unionfind.QuickFindUF;
import com.kramar42.coursera.algs.unionfind.UnionFind;
import com.kramar42.coursera.algs.unionfind.WeightedQuickUnionUF;

/**
 * Created by kramar.
 */
public class Percolation {
    private boolean[][] grid;

    public Percolation(int N) {
        grid = new boolean[N][];
        for (int i = 0; i < N; i++) {
            grid[i] = new boolean[N];
        }
    }

    public void open(int i, int j) {
        grid[i][j] = true;
    }

    public boolean isOpen(int i, int j) {
        return grid[i][j];
    }

    public boolean isFull(int i, int j) {
        return ! grid[i][j];
    }

    public int size() {
        return grid.length;
    }

    public boolean percolates() {
        UnionFind uf = new WeightedQuickUnionUF(grid.length);
        return false;
    }

    static String getString(String string) {
//        System.out.println("GetString returning " + string);
        return string;
    }

    public static void main(String[] args) {
        class Base {
            String s = getString("Base");

            void foo() {
//                System.out.println("FOO in Base");
                System.out.println(s);
            }

            Base() {
//                System.out.println("In Base constructor");
                foo();
            }
        }

        class Derived extends Base {
            String s = getString("Derived");

            void foo() {
//                System.out.println("FOO in Derived");
                System.out.println(s);
            }
        }

        //Percolation p = new Percolation(10);
        Derived d = new Derived();
        d.foo();
    }
}
