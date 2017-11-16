/**
 * Created by Michał on 16.11.2017.
 */
public class Executor {
    public static void main(String[] args){
        int N=5, M=6;
        Node[][] nodes = new Node[N][M];

        for(int i=0; i<N; i++)
            for(int j=0; j<M; j++)
                nodes[i][j] = new Node();


        //P0
        P0 p0 = new P0();
        p0.start();
        try {p0.join();}
        catch (InterruptedException ex) {}

        //P1
        P1[] p1 = new P1[M-1];
        for(int i=1; i<M; i++) p1[i-1] = new P1(nodes[0][i-1], nodes[0][i]);
        for(int i=0; i<M-1; i++) p1[i].start();
        try {
            for(int i=0; i<M-1; i++) p1[i].join();
        }
        catch (InterruptedException ex) {}

        // P3
        P3[] p3 = new P3[M];
        for(int i=0; i < N-1; i++) {
            for(int j=0; j<M; j++) p3[j] = new P3(nodes[i][j], nodes[i+1][j]);
            for(int j=0; j<M; j++) p3[j].start();
            try {
                for(int j=0; j < M; j++) p3[j].join();
            }
            catch (InterruptedException ex) {}
        }

        // P5
        P5[] p5 = new P5[M-1];
        for(int i=1; i < N; i++) {
            for(int j=0; j<M-1; j++) p5[j] = new P5(nodes[i][j], nodes[i][j+1]);
            for(int j=0; j<M-1; j++) p5[j].start();
            try {
                for(int j=0; j < M-1; j++) p5[j].join();
            }
            catch (InterruptedException ex) {}
        }

        for(int i = 0; i < N; i++) {
            for(int j=0; j<M; j++){
                System.out.println("Node [" + i + "][" + j + "]");
                System.out.println(nodes[i][j].getLeft() == null ? "left == null" : "left != null");
                System.out.println(nodes[i][j].getRight() == null ? "right == null" : "right != null");
                System.out.println(nodes[i][j].getUp() == null ? "up == null" : "up != null");
                System.out.println(nodes[i][j].getDown() == null ? "down == null" : "down != null");
                System.out.println();
            }
        }
    }
}
