/**
 * Created by Michał on 16.11.2017.
 */
public class P6 extends Thread {
    Node node1, node2;

    public P6(Node node1, Node node2) {
        this.node1 = node1;
        this.node2 = node2;
    }

    @Override
    public void start() {
        node1.setDown(node2);
        node2.setUp(node1);
    }
}
