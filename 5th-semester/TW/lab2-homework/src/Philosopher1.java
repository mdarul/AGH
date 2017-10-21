import java.util.Random;

/**
 * Created by michal on 21/10/17.
 */
public class Philosopher1 extends Thread{
    private int n;
    private Waiter waiter;

    public Philosopher1(int n, Waiter waiter) {
        this.n = n;
        this.waiter = waiter;
    }

    @Override
    public void run() {
        for(int i=0; i < 5; i++) {
            try {
                waiter.distributeFroks(n);
            }
            catch (InterruptedException e) {
                e.printStackTrace();
            }

            System.out.println("Philosopher " + n + " is dining");
            Random rand = new Random();
            try {
                Thread.sleep(rand.nextInt(1000) + 1000);
            }
            catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println("Philosopher " + n + " ended eating");
            waiter.collectForks(n);

            System.out.println("Philosopher " + n + " is thinking...");
            try {
                Thread.sleep(rand.nextInt(1000) + 1000);
            }
            catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
