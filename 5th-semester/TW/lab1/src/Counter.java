/**
 * Created by michal on 13/10/17.
 */
public class Counter {
    public static int x = 0;
    public static int N = 100000;
    public static synchronized void increment_x() {
        x++;
    }

    public static synchronized void decrement_x() {
        x--;
    }

    public static void faulty_increment_x() {
        x++;
    }

    public static void faulty_decrement_x() {
        x--;
    }

    public static void fixed() {
        int n = 10;
        Thread1[] t1 = new Thread1[n];
        Thread2[] t2 = new Thread2[n];

        for (int i = 0; i < n; i++) {
            t1[i] = new Thread1();
            t2[i] = new Thread2();
        }

        for (int i = 0; i < n; i++) {
            t1[i].start();
            t2[i].start();
        }

        try {
            for (int i = 0; i < n; i++) t1[i].join();
            for (int i = 0; i < n; i++) t2[i].join();
        }
        catch (InterruptedException exc) {
            System.exit(1);
        }

        System.out.println(x);
    }

    public static void faulty() {
        int n = 10;
        Thread1_faulty[] t1 = new Thread1_faulty[n];
        Thread2_faulty[] t2 = new Thread2_faulty[n];

        for (int i = 0; i < n; i++) {
            t1[i] = new Thread1_faulty();
            t2[i] = new Thread2_faulty();
        }

        for (int i = 0; i < n; i++) {
            t1[i].start();
            t2[i].start();
        }

        try {
            for (int i = 0; i < n; i++) t1[i].join();
            for (int i = 0; i < n; i++) t2[i].join();
        } catch (InterruptedException exc) {
            System.exit(1);
        }

        System.out.println(x);
    }

    public static void max_threads()
    {
        int i = 0;
        while(true)
        {
            try {
                ThreadTest t = new ThreadTest();
                t.setPriority(Thread.MIN_PRIORITY);
                t.start();
                i++;
                System.out.println(i);
            } catch(Exception e)
            {
                System.out.println("Max threads - " + i);
            }
        }
    }

    public static void main(String[] args) {
        long startTime, endTime;

        startTime = System.currentTimeMillis();
        faulty();
        endTime = System.currentTimeMillis();
        System.out.println("Faulty's evaluation time - " + (endTime - startTime) + "ms");

        x = 0;

        startTime = System.currentTimeMillis();
        fixed();
        endTime = System.currentTimeMillis();
        System.out.println("Fixed's evaluation time - " + (endTime - startTime) + "ms");

        //max_threads();
    }
}
