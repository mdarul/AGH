import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class ServerUDP {
    public static void main(String[] args) {
        DatagramSocket socket = null;
        try {
            socket = new DatagramSocket(3456);
            byte[] receiveBuffer = new byte[1024];
            while(true) {
                DatagramPacket receivePacket = new DatagramPacket(receiveBuffer, receiveBuffer.length);
                socket.receive(receivePacket);
                String msg = new String(receivePacket.getData());
                System.out.println(msg);

                byte[] sendBuffer = "pong".getBytes();
                if(msg.contains("java")) {
                    System.out.println("java loop");
                    sendBuffer = "java pong".getBytes();
                }
                else if (msg.contains("python")) {
                    System.out.println("python loop");
                    sendBuffer = "python pong".getBytes();
                }

                InetAddress address = receivePacket.getAddress();
                int port = receivePacket.getPort();
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

