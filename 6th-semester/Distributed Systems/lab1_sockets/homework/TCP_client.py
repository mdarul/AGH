import socket
from argparse import ArgumentParser


def parser():
    parser = ArgumentParser()
    parser.add_argument("nick", type=str, help="nick of a sender")
    parser.add_argument("msg", type=str, help="message content")
    args = parser.parse_args()
    nick = args.nick
    msg = args.msg
    return nick, msg


nick, msg = parser()
server_ip = "127.0.0.1"
server_port = 1241

final_msg = nick + ":" + msg
socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
socket.connect((server_ip, server_port))
socket.sendall(bytes(final_msg, 'utf-8'))

while True:
    # socket.listen(1)
    msg = socket.recv(1024)
    print("received form server: " + str(msg, 'utf-8'))
