import java.util.Random;

/**
 * Created by michal on 21/10/17.
 */
public class Philosopher3 extends Thread {
    static BinarySemaphore[] philosophers;
    int n;

    public Philosopher3(BinarySemaphore[] philosophers1, int n) {
        philosophers = philosophers1;
        this.n = n;
    }

    synchronized void takeForks() throws InterruptedException {
        philosophers[((this.n-1)%5 + 5)%5].binarySemaPhoreWait();
        philosophers[this.n].binarySemaPhoreWait();
    }

    synchronized void putForks() {
        philosophers[((this.n-1)%5 + 5)%5].binarySemaPhoreSignal();
        philosophers[this.n].binarySemaPhoreSignal();
    }

    @Override
    public void run() {
        for(int i=0; i < 5; i++) {
            try {takeForks();}
            catch (InterruptedException e) {e.printStackTrace();}
            System.out.println("Philosopher " + n + " is dining");
            Random rand = new Random();
            try {Thread.sleep(rand.nextInt(1000) + 1000);}
            catch (InterruptedException e) {e.printStackTrace();}

            System.out.println("Philosopher " + n + " ended eating and started thinking");
            putForks();
            try {Thread.sleep(rand.nextInt(1000) + 1000);}
            catch (InterruptedException e) {e.printStackTrace();}
        }
    }
}
