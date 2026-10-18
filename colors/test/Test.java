package demo;

import java.util.List;
import java.util.ArrayList;

// Shape contract.
interface Shape {
    double area();
}

public class Test<T extends Comparable<T>> implements Shape {
    private static final int MAX = 10;
    private final List<T> items = new ArrayList<>();
    private String name = "circle\tradius";

    @Override
    public double area() {
        return Math.PI * MAX * MAX;
    }

    public void add(T item) throws IllegalStateException {
        if (items.size() >= MAX) {
            throw new IllegalStateException("full");
        }
        items.add(item);
        return;
    }

    public static void main(String[] args) {
        Test<Integer> t = new Test<>();
        for (int i = 0; i < 5; i++) {
            t.add(i);
        }
        boolean ok = t.items.isEmpty() || args.length > 0;
        // print result
        System.out.println(ok ? "yes" : "no");
    }
}
