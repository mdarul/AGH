import java.util.Random;

/**
 * Created by michal on 20/10/17.
 */
class Problem1 {
    private static int[] tab;
    private static int N;
    private static Problem1 instance;
    private static int readers;
    private static int writers;

    public static Problem1 getInstance() {
        if(instance == null) instance = new Problem1(100);
        return instance;
    }

    private Problem1(int n) {
        N = n;
        tab = new int[N];
        writers = 0;
        readers = 0;
        Random rand = new Random();
        for(int i=0; i < N; i++) tab[i] = rand.nextInt(100);
    }

    public static int getReaders() {
        return readers;
    }

    public static void setReaders(int readers) {
        Problem1.readers = readers;
    }

    public static int getWriters() {
        return writers;
    }

    public static void setWriters(int writers) {
        Problem1.writers = writers;
    }

    public synchronized void startWriting(int i, int val) {
        try {
            while(readers > 0 || writers > 0) wait();
        }
        catch (InterruptedException e) {
            e.printStackTrace();
        }
        writers++;
        tab[i] = val;
    }

    public synchronized void endWriting() {
        System.out.println("End of a writing");
        writers--;
        notifyAll();
    }

    public synchronized int startReading(int i) {
        try {
            while(writers > 0) wait();
        }
        catch (InterruptedException e) {
            e.printStackTrace();
        }
        readers++;

        return tab[i];
    }

    public synchronized void endReading() {
        readers--;
        System.out.println("End of a reading");
        notifyAll();
    }
}
