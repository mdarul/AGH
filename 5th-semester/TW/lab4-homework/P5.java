/**
 * Created by Michał on 16.11.2017.
 */
public class P5 extends Thread {
    Node node1, node2;

    public P5(Node node1, Node node2) {
        this.node1 = node1;
        this.node2 = node2;
    }

    @Override
    public void start() {
        node1.setRight(node2);
        node2.setLeft(node1);
    }
}
