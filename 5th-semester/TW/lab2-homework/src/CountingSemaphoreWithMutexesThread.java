import java.util.Random;

/**
 * Created by michal on 21/10/17.
 */
public class CountingSemaphoreWithMutexesThread extends Thread {
    private CountingSemaphoreWithMutexes s;
    private int n;

    public CountingSemaphoreWithMutexesThread(CountingSemaphoreWithMutexes s, int n) {
        this.s = s;
        this.n = n;
    }

    @Override
    public void run() {
        try {
            s.countingSemaphoreWihMutexesWait();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Running thread " + this.n + "...");
        Random rand = new Random();
        try {
            Thread.sleep(rand.nextInt(1000) + 1000);
        }
        catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Ending thread " + this.n);
        try {
            s.countingSemaphoreWihMutexesSignal();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
