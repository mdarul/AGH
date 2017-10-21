import java.util.Random;

/**
 * Created by michal on 21/10/17.
 */
public class Philosopher2 extends Thread {
    BinarySemaphore[] forks;
    private int n;

    public Philosopher2(BinarySemaphore[] forks, int n) {
        this.forks = forks;
        this.n = n;
    }

    @Override
    public void run() {
        for(int i=0; i < 5; i++) {

            try {forks[i].binarySemaPhoreWait();}
            catch (InterruptedException e) {e.printStackTrace();}
            try {forks[(i+1)%5].binarySemaPhoreWait();}
            catch (InterruptedException e) {e.printStackTrace();}

            System.out.println("Philosopher " + n + " is dining");
            Random rand = new Random();
            try {Thread.sleep(rand.nextInt(1000) + 1000);}
            catch (InterruptedException e) {e.printStackTrace();}

            forks[(i+1)%5].binarySemaPhoreSignal();
            forks[i].binarySemaPhoreSignal();
            System.out.println("Philosopher " + n + " finished eating");

            System.out.println("Philosopher " + n + " is thinking...");
            try {Thread.sleep(rand.nextInt(1000) + 1000);}
            catch (InterruptedException e) {e.printStackTrace();}
        }
    }
}
