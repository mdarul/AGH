/**
 * Created by michal on 21/10/17.
 */
public class CountingSemaphore {
    private int signals = 0;
    private int max_signals;

    public CountingSemaphore(int max_signals) {
        this.max_signals = max_signals;
    }

    public synchronized void countingSemaphoreSignal() throws InterruptedException {
        this.signals--;
        this.notify();
    }

    public synchronized void countingSemaphoreWait() throws InterruptedException {
        while(this.signals == this.max_signals) wait();
        this.signals++;
        this.notify();
    }
}
