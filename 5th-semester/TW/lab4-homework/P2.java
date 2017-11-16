/**
 * Created by Michał on 16.11.2017.
 */
public class P2 extends Thread {
    Node currentNode, newNode;

    public P2(Node currentNode, Node newNode) {
        this.currentNode = currentNode;
        this.newNode = newNode;
    }

    @Override
    public void start() {
        newNode.setRight(currentNode);
        currentNode.setLeft(newNode);
    }
}
