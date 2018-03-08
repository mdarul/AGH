import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.nio.ByteBuffer;

public class ServerUDP {
    public static void main(String[] args) {
        DatagramSocket socket = null;
        try {
            socket = new DatagramSocket(2345);
            byte[] receiveBuffer = new byte[1024];
            while(true) {
                DatagramPacket receivePacket = new DatagramPacket(receiveBuffer, receiveBuffer.length);
                socket.receive(receivePacket);
                int nb = ByteBuffer.wrap(receiveBuffer).getInt();
                nb = Integer.reverseBytes(nb);
                System.out.println(nb);
                nb++;

                InetAddress address = receivePacket.getAddress();
                int port = receivePacket.getPort();
                byte[] sendBuffer = ByteBuffer.allocate(4).putInt(nb).array();
                DatagramPacket sendPacket = new DatagramPacket(sendBuffer, sendBuffer.length, address, port);
                socket.send(sendPacket);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (socket != null) socket.close();
        }
    }
}

