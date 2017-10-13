/**
 * Created by michal on 13/10/17.
 */
public class ThreadTest extends Thread {
    @Override
    public void run() {
        try {
            Thread.sleep(1000000000);
        } catch(Exception e) {

        }
    }
}
