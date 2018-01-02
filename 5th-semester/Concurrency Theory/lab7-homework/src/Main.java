/**
 * Created by michal on 01/01/18.
 */
public class Main {
    public static void zad1_1() {
//        List list = new List();
//        for(int i = 0; i < 30; i++)list.addAtEnd(Integer.valueOf(i%5));
//        list.printList();
//        int N = 3;
//        ListThread[] listThreads = new ListThread[N];
//        for (int i = 0; i < N; i++) listThreads[i] = new ListThread(list);
//        for (int i = 0; i < N; i++) listThreads[i].start();
//        try {for (int i = 0; i < N; i++) listThreads[i].join();}
//        catch (Exception e) {}
//        list.printList();

//        zad1_1_addTime();
//        zad1_1_containsTime();
        zad1_1_deleteTime();
    }

    public static void zad1_1_addTime() {
        long startTime, stopTime;

        startTime = System.currentTimeMillis();
        ClassicList classicList = new ClassicList();
        for(int i = 0; i < 100; i++)classicList.addAtEnd(Integer.valueOf(i%4));
        stopTime = System.currentTimeMillis();
        System.out.println("Non-parallel list add time: " + (stopTime - startTime) + "ms");

        startTime = System.currentTimeMillis();
        List list = new List();
        int N = 4;
        ListThread[] listThreads = new ListThread[N];
        for (int i = 0; i < N; i++) listThreads[i] = new ListThread(list, i);
        for (int i = 0; i < N; i++) listThreads[i].start();
        try {for (int i = 0; i < N; i++) listThreads[i].join();}
        catch (Exception e) {}
        stopTime = System.currentTimeMillis();
        System.out.println("Parallel list add time: " + (stopTime - startTime) + "ms");
    }

    public static void zad1_1_containsTime() {
        long startTime, stopTime;

        ClassicList classicList = new ClassicList();
        for(int i = 0; i < 100; i++)classicList.addAtEnd(Integer.valueOf(i));

        startTime = System.currentTimeMillis();
        classicList.contains(Integer.valueOf(0));
        classicList.contains(Integer.valueOf(33));
        classicList.contains(Integer.valueOf(66));
        classicList.contains(Integer.valueOf(99));
        stopTime = System.currentTimeMillis();
        System.out.println("Non-parallel list contains time: " + (stopTime - startTime) + "ms");

        List list = new List();
        for(int i = 0; i < 100; i++)list.addAtEnd(Integer.valueOf(i));
        int N = 4;
        ListThread[] listThreads = new ListThread[N];
        for (int i = 0; i < N; i++) listThreads[i] = new ListThread(list, i * 33);
        startTime = System.currentTimeMillis();
        for (int i = 0; i < N; i++) listThreads[i].start();
        try {for (int i = 0; i < N; i++) listThreads[i].join();}
        catch (Exception e) {}

        stopTime = System.currentTimeMillis();
        System.out.println("Parallel list contains time: " + (stopTime - startTime) + "ms");
    }

    public static void zad1_1_deleteTime() {
        long startTime, stopTime;

        ClassicList classicList = new ClassicList();
        for(int i = 0; i < 100; i++)classicList.addAtEnd(Integer.valueOf(i));
        startTime = System.currentTimeMillis();
        classicList.delete(Integer.valueOf(0));
        classicList.delete(Integer.valueOf(33));
        classicList.delete(Integer.valueOf(66));
        classicList.delete(Integer.valueOf(99));
        stopTime = System.currentTimeMillis();
        System.out.println("Non-parallel list delete time: " + (stopTime - startTime) + "ms");

        List list = new List();
        for(int i = 0; i < 100; i++)list.addAtEnd(Integer.valueOf(i));
        int N = 4;
        ListThread[] listThreads = new ListThread[N];
        for (int i = 0; i < N; i++) listThreads[i] = new ListThread(list, i * 33);
        startTime = System.currentTimeMillis();
        for (int i = 0; i < N; i++) listThreads[i].start();
        try {for (int i = 0; i < N; i++) listThreads[i].join();}
        catch (Exception e) {}
        stopTime = System.currentTimeMillis();
        System.out.println("Parallel list delete time: " + (stopTime - startTime) + "ms");
    }

    public static void zad1_2(int readersAmount, int writersAmount) throws InterruptedException {
        Library library = new Library();
        Reader[] readers = new Reader[readersAmount];
        Writer[] writers = new Writer[writersAmount];

        for (int i = 0; i < writersAmount; i++) writers[i] = new Writer(i, library);
        for (int i = 0; i < readersAmount; i++) readers[i] = new Reader(i, library);

        for (int i = 0; i < writersAmount; i++) writers[i].start();
        for (int i = 0; i < readersAmount; i++) readers[i].start();

        for (int i = 0; i < writersAmount; i++) writers[i].join();
        for (int i = 0; i < readersAmount; i++) readers[i].join();
    }

    public static void main(String[] args) {
        //task 1
//        zad1_1();

        //task 2
        try {
            int readersAmount = 0, writersAmount = 1;
            System.out.println("starting...");
            long startTime = System.currentTimeMillis();
            zad1_2(readersAmount, writersAmount);
            long stopTime = System.currentTimeMillis();
            System.out.println(readersAmount + " " + writersAmount + " " + (stopTime - startTime));
        }
        catch (InterruptedException e) {e.printStackTrace();}
    }
}
