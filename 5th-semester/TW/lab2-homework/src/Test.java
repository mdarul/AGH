/**
 * Created by michal on 20/10/17.
 */
public class Test {
    private static void zad1() {
        Race race = new Race();
        race.startRace();
    }

    private static void testCountingSemaphore() {
        int n = 10;
        CountingSemaphore countingSemaphore = new CountingSemaphore(n);
        CountingSemaphoreThread[] threads = new CountingSemaphoreThread[3*n];

        for(int i=0; i < 3*n; i++) {
            threads[i] = new CountingSemaphoreThread(countingSemaphore, i);
        }

        for(int i=0; i < 3*n; i++) {
            threads[i].start();
        }
        try {
            for(int i=0; i < 3*n; i++) threads[i].join();
        }
        catch (InterruptedException e) {e.printStackTrace();}
    }

    public static void main(String[] args) {
        testCountingSemaphore();
    }
}
