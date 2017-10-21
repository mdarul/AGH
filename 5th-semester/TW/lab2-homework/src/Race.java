/**
 * Created by michal on 20/10/17.
 */
public class Race {
    public static int counter = 0;

    public void incrementCounter() {
        counter++;
    }

    public void decrementCounter() {
        counter--;
    }

    public void startRace() {
        BinarySemaphore binarySemaphore = new BinarySemaphore();
        int n = (int)1e6;
        ThreadIncrement t1 = new ThreadIncrement(binarySemaphore, n);
        ThreadDecrement t2 = new ThreadDecrement(binarySemaphore, n);

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println(counter);
    }
}
