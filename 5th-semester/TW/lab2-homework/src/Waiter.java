/**
 * Created by michal on 21/10/17.
 */
public class Waiter {
    private boolean[] forks = new boolean[5];

    public Waiter() {
        for(int i=0; i<5; i++) forks[i] = true;
    }

    public synchronized void collectForks(int i) {
        forks[i] = forks[(i+1)%5] = true;
        this.notify();
    }

    public synchronized void distributeFroks(int i) throws InterruptedException {
        while(!forks[i] || !forks[(i+1)%5]) this.wait();
        forks[i] = forks[(i+1)%5] = false;
    }
}
