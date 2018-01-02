/**
 * Created by michal on 13/10/17.
 */
public class Thread2 extends Thread {
    @Override
    public void run() {
        Counter c2 = new Counter();
        for(int i=0; i<c2.N; i++) {
            c2.decrement_x();
        }
    }
}
