package pl.edu.agh.macwozni.dmeshparallel.parallelism;

import java.util.logging.Level;
import java.util.logging.Logger;

import pl.edu.agh.macwozni.dmeshparallel.production.*;
import pl.edu.agh.macwozni.dmeshparallel.mesh.Vertex;
import pl.edu.agh.macwozni.dmeshparallel.mesh.GraphDrawer;

public class Executor extends Thread {
    @Override
    public synchronized void run() {
        zad1();
    }

    void zad1() {
        Counter counter = new Counter(this);
        //axiom
        Vertex s = new Vertex(null, null, "S");

        // p1
        P1 p1 = new P1(s, counter);
        p1.start();

        //start threads
        counter.release();

        //wait for threads to finish
        try {
            p1.join();
        } catch (InterruptedException ex) {
            Logger.getLogger(Executor.class.getName()).log(Level.SEVERE, null, ex);
        }

        //p2, p3
        P2 p2 = new P2(p1.getVertex(), counter);
        P3 p3 = new P3(p1.getVertex().getRight(), counter);

        p2.start();
        p3.start();
        counter.release();

        try {
            p2.join();
            p3.join();
        } catch (InterruptedException ex) {
            Logger.getLogger(Executor.class.getName()).log(Level.SEVERE, null, ex);
        }

        //p2', p3', p4, p4'
        P2 p2_1 = new P2(p1.getVertex(), counter);
        P3 p3_1 = new P3(p1.getVertex().getRight(), counter);
        P4 p4 = new P4(p2.getVertex(), counter);
        P4 p4_1 = new P4(p3.getVertex(), counter);

        p2_1.start();
        p3_1.start();
        p4.start();
        p4_1.start();
        counter.release();

        try {
            p2_1.join();
            p3_1.join();
            p4.join();
            p4_1.join();
        } catch (InterruptedException ex) {
            Logger.getLogger(Executor.class.getName()).log(Level.SEVERE, null, ex);
        }

        // p5a, p5b, p6, p6', ... p6'''''
        P5 p5a = new P5(p1.getVertex(), counter);
        P5 p5b = new P5(p4_1.getVertex().getRight().getRight(), counter);
        P6 p6 = new P6(p1.getVertex().getRight().getRight().getRight(), counter);
        P6 p6_1 = new P6(p1.getVertex().getRight().getRight().getRight().getRight(), counter);
        P6 p6_2 = new P6(p4.getVertex().getRight(), counter);
        P6 p6_3 = new P6(p4.getVertex().getRight().getRight(), counter);
        P6 p6_4 = new P6(p4_1.getVertex(), counter);
        P6 p6_5 = new P6(p4_1.getVertex().getRight(), counter);

        p5a.start();
        p5b.start();
        p6.start();
        p6_1.start();
        p6_2.start();
        p6_3.start();
        p6_4.start();
        p6_5.start();
        counter.release();

        try {
            p5a.join();
            p5b.join();
            p6.join();
            p6_1.join();
            p6_2.join();
            p6_3.join();
            p6_4.join();
            p6_5.join();
        } catch (InterruptedException ex) {
            Logger.getLogger(Executor.class.getName()).log(Level.SEVERE, null, ex);
        }

        //done
        System.out.println("done");
        GraphDrawer drawer = new GraphDrawer();
        drawer.draw(p1.getVertex());
    }

    void zad2() {
        Counter counter = new Counter(this);
        //axiom
        Vertex s = new Vertex(null, null, "S");

        //p1
        P1 p1 = new P1(s, counter);
        p1.start();

        //start threads
        counter.release();

        //wait for threads to finish
        try {
            p1.join();
        } catch (InterruptedException ex) {
            Logger.getLogger(Executor.class.getName()).log(Level.SEVERE, null, ex);
        }

        //p3
        P3 p3 = new P3(p1.getVertex().getRight(), counter);
        p3.start();

        //start threads
        counter.release();

        //wait for threads to finish
        try {
            p3.join();
        } catch (InterruptedException ex) {
            Logger.getLogger(Executor.class.getName()).log(Level.SEVERE, null, ex);
        }

        //P3', P4, P4', P5a
        P5 p5a = new P5(p3.getVertex().getLeft(), counter);
        P3 p3_1 = new P3(p3.getVertex(), counter);
        P4 p4 = new P4(p3.getVertex().getLeft(), counter);
        P4 p4_1 = new P4(p4.getVertex().getRight(), counter);

        p5a.start();
        p3_1.start();
        p4.start();
        p4_1.start();

        counter.release();
        try {
            p5a.join();
            p3_1.join();
            p4.join();
            p4_1.join();
        } catch (InterruptedException ex) {
            Logger.getLogger(Executor.class.getName()).log(Level.SEVERE, null, ex);
        }

        //P5b, P6, P6', P6'', P6'''
        P5 p5b = new P5(p4_1.getVertex().getRight().getRight(), counter);
        P6 p6 = new P6(p4.getVertex().getRight(), counter);
        P6 p6_1 = new P6(p4.getVertex().getRight().getRight(), counter);
        P6 p6_2 = new P6(p4_1.getVertex(), counter);
        P6 p6_3 = new P6(p4_1.getVertex().getRight(), counter);

        p5b.start();
        p6.start();
        p6_1.start();
        p6_2.start();
        p6_3.start();

        counter.release();

        try {
            p5b.join();
            p6.join();
            p6_1.join();
            p6_2.join();
            p6_3.join();
        } catch (InterruptedException ex) {
            Logger.getLogger(Executor.class.getName()).log(Level.SEVERE, null, ex);
        }

        //done
        System.out.println("done");
        GraphDrawer drawer = new GraphDrawer();
        drawer.draw(p1.getVertex());
    }
}
