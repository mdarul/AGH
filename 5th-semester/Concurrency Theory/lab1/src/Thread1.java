/**
 * Created by michal on 13/10/17.
 */
public class Thread1 extends Thread {
    @Override
    public void run() {
        Counter c1 = new Counter();
        for(int i=0; i<c1.N; i++) {
            c1.increment_x();
        }
    }
}
