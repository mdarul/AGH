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
        int m = 4*n;
        CountingSemaphore countingSemaphore = new CountingSemaphore(n);
        CountingSemaphoreThread[] threads = new CountingSemaphoreThread[m];

        for(int i=0; i < m; i++) {
            threads[i] = new CountingSemaphoreThread(countingSemaphore, i);
        }

        for(int i=0; i < m; i++) {
            threads[i].start();
        }
        try {
            for(int i=0; i < m; i++) threads[i].join();
        }
        catch (InterruptedException e) {e.printStackTrace();}
    }

    private static void testCountingSemaphoreWithMutexes() {
        int n = 10;
        int m = 4*n;
        CountingSemaphoreWithMutexes semaphore = new CountingSemaphoreWithMutexes(n);
        CountingSemaphoreWithMutexesThread[] threads = new CountingSemaphoreWithMutexesThread[m];

        for(int i=0; i < m; i++) {
            threads[i] = new CountingSemaphoreWithMutexesThread(semaphore, i);
        }

        for(int i=0; i < m; i++) {
            threads[i].start();
        }
        try {
            for(int i=0; i < m; i++) threads[i].join();
        }
        catch (InterruptedException e) {e.printStackTrace();}
    }

    private static void diningPhilosophers1() {
        Waiter waiter = new Waiter();
        Philosopher1[] philosophers = new Philosopher1[5];
        for(int i=0; i < 5; i++) philosophers[i] = new Philosopher1(i, waiter);

        for(int i=0; i < 5; i++) philosophers[i].start();
        try {for(int i=0; i < 5; i++) philosophers[i].join();}
        catch (InterruptedException e) {e.printStackTrace();}
    }

    private static void diningPhilosophers2() {
        BinarySemaphore[] forks = new BinarySemaphore[5];
        for(int i=0; i < 5; i++) forks[i] = new BinarySemaphore();

        Philosopher2[] philosophers = new Philosopher2[5];
        for(int i=0; i < 5; i++) philosophers[i] = new Philosopher2(forks, i);

        for(int i=0; i < 5; i++) philosophers[i].start();
        try {for(int i=0; i < 5; i++) philosophers[i].join();}
        catch (InterruptedException e) {e.printStackTrace();}
    }

    private static void diningPhilosophers3() {
        BinarySemaphore[] philosophersSemaphore = new BinarySemaphore[5];
        for(int i=0; i < 5; i++) philosophersSemaphore[i] = new BinarySemaphore();

        Philosopher3[] philosophers = new Philosopher3[5];
        for(int i=0; i < 5; i++) philosophers[i] = new Philosopher3(philosophersSemaphore, i);

        for(int i=0; i < 5; i++) philosophers[i].start();
        try {for(int i=0; i < 5; i++) philosophers[i].join();}
        catch (InterruptedException e) {e.printStackTrace();}
    }

    public static void main(String[] args) {
//        zad1();
//        testCountingSemaphore();
//        testCountingSemaphoreWithMutexes();
//        diningPhilosophers1();
//        diningPhilosophers2();
        diningPhilosophers3();

    }
}
