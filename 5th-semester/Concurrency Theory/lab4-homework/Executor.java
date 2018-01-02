/**
 * Created by Michał on 16.11.2017.
 */
public class Executor {
    public static void main(String[] args){
        int N=6, M=6;
        Node[][] nodes = new Node[N][M];

        for(int i=0; i<N; i++)
            for(int j=0; j<M; j++)
                nodes[i][j] = new Node();


        //P0
        P0 p0 = new P0();
        p0.start();
        try {p0.join();}
        catch (InterruptedException ex) {}

        //P1, P2
        P1 p1;
        P2 p2;
        int middle_M = (M-1) / 2;
        int middle_N = (N-1) / 2;
        for(int i=0; i < middle_M; i++) {
            p1 = new P1(nodes[middle_N][middle_M + i], nodes[middle_N][middle_M + i+1]);
            p2 = new P2(nodes[middle_N][middle_M - i], nodes[middle_N][middle_M - (i+1)]);
            p1.start();
            p2.start();
            try {
                p1.join();
                p2.join();
            }
            catch (InterruptedException ex) {}
        }
        //P1 last
        if(M%2 == 0) {
            p1 = new P1(nodes[middle_N][M-2], nodes[middle_N][M-1]);
            p1.start();
            try {p1.join();}
            catch (InterruptedException ex) {}
        }

        // P3, P4
        P3[] p3 = new P3[M];
        P4[] p4 = new P4[M];
        for(int i=0; i < middle_N; i++) {
            for(int j=0; j<M; j++) p3[j] = new P3(nodes[middle_N + i][j], nodes[middle_N + i+1][j]);
            for(int j=0; j<M; j++) p4[j] = new P4(nodes[middle_N - i][j], nodes[middle_N - (i+1)][j]);
            for(int j=0; j<M; j++) p3[j].start();
            for(int j=0; j<M; j++) p4[j].start();
            try {
                for(int j=0; j < M; j++) p3[j].join();
                for(int j=0; j < M; j++) p4[j].join();
            }
            catch (InterruptedException ex) {}
        }
        //P3 last
        if(N%2 == 0) {
            for(int j=0; j<M; j++) p3[j] = new P3(nodes[N-2][j], nodes[N-1][j]);
            for(int j=0; j<M; j++) p3[j].start();
            try {for(int j=0; j < M; j++) p3[j].join();}
            catch (InterruptedException ex) {}
        }

        // P5
        P5[] p5 = new P5[M-1];
        for(int i=0; i < N; i++) {
            if(i == middle_N) continue; // we have already set row connection for cells in middle_N (operations P1 and P2)
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
