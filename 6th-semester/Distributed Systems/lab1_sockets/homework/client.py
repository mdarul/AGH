import socket as sc
import _thread
from argparse import ArgumentParser

import termios
import sys
import tty
import struct


def parser():
    parser = ArgumentParser()
    parser.add_argument("nick", type=str, help="nick of a sender")
    parser.add_argument("msg", type=str, help="message content")
    args = parser.parse_args()
    nick = args.nick
    msg = args.msg
    return nick, msg


def _getch():
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        ch = sys.stdin.read(1)  # This number represents the length
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
    return ch


def tcp_connection(server_ip, server_port, final_msg):
    s = sc.socket(sc.AF_INET, sc.SOCK_STREAM)
    s.connect((server_ip, server_port))
    s.sendall(bytes(final_msg, 'utf-8'))
    while True:
        msg = s.recv(1024)
        print("received form server: " + str(msg, 'utf-8'))


# following two functions are taken from stackoverflow
def send_multicast(final_msg):
    MCAST_GRP = '224.1.1.1'
    MCAST_PORT = 5007

    sock = sc.socket(sc.AF_INET, sc.SOCK_DGRAM, sc.IPPROTO_UDP)
    sock.setsockopt(sc.IPPROTO_IP, sc.IP_MULTICAST_TTL, 2)
    sock.sendto(bytes(final_msg, 'utf-8'), (MCAST_GRP, MCAST_PORT))


def receive_multicast():
    MCAST_GRP = '224.1.1.1'
    MCAST_PORT = 5007

    sock = sc.socket(sc.AF_INET, sc.SOCK_DGRAM, sc.IPPROTO_UDP)
    sock.setsockopt(sc.SOL_SOCKET, sc.SO_REUSEADDR, 1)
    sock.bind(('', MCAST_PORT))
    mreq = struct.pack("4sl", sc.inet_aton(MCAST_GRP), sc.INADDR_ANY)

    sock.setsockopt(sc.IPPROTO_IP, sc.IP_ADD_MEMBERSHIP, mreq)

    while True:
        print(sock.recv(1024))


def udp_connection(server_ip, server_port, final_msg):
    udp_server_socket = sc.socket(sc.AF_INET, sc.SOCK_DGRAM)
    udp_server_socket.connect((server_ip, server_port))
    # _thread.start_new_thread(receive_multicast, (server_ip, server_port))
    while True:
        key = _getch()
        if key == 'u' or key == 'U':
            udp_server_socket.sendall(bytes(final_msg, 'utf-8'))
        if key == 'm' or key == 'M':
            send_multicast(final_msg)
        if key == 'q' or key == 'Q':
            break


nick, msg = parser()
server_ip = "127.0.0.1"
server_port = 1260
final_msg = nick + ":" + msg


_thread.start_new_thread(tcp_connection, (server_ip, server_port, final_msg))
_thread.start_new_thread(receive_multicast, (server_ip, server_port))
_thread.start_new_thread(udp_connection, (server_ip, server_port, final_msg))

while True:
    pass
