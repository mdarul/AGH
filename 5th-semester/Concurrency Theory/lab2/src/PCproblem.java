import java.io.Reader;

/**
 * Created by michal on 20/10/17.
 */
public class PCproblem {

    public static void problem1A() {
        Consumer consumer = new Consumer(0);
        Producer producer = new Producer(0);
        consumer.start();
        producer.start();

        try {
            consumer.join();
            producer.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    static void problem1B(int consumersAmount, int producersAmount) {
        Consumer consumer[] = new Consumer[consumersAmount];
        Producer producer[] = new Producer[producersAmount];
        for(int i=0; i < consumersAmount; i++) consumer[i] = new Consumer(i);
        for(int i=0; i < producersAmount; i++) producer[i] = new Producer(i);

        for(int i=0; i < consumersAmount; i++) consumer[i].start();
        for(int i=0; i < producersAmount; i++) producer[i].start();

        try {
            for(int i=0; i < consumersAmount; i++) consumer[i].join();
            for(int i=0; i < producersAmount; i++) producer[i].join();
        }
        catch (InterruptedException e) {e.printStackTrace();}
    }

    public static void main(String[] args) {
        problem1B(20, 10);
    }
}
