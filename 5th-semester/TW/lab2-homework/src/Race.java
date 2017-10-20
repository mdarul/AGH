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

    public void startRace() throws InterruptedException {
        BinarySemaphore binarySemaphore = new BinarySemaphore();
        ThreadIncrement t1 = new ThreadIncrement(binarySemaphore);
        ThreadDecrement t2 = new ThreadDecrement(binarySemaphore);

        t1.start();
        t2.start();

        t1.join();
        t2.join();

        System.out.println(counter);
    }
}
