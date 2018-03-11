import socket as sc
import _thread


class Client:
    nick = ""
    socket = None

    def __init__(self, nick, socket):
        self.nick = nick
        self.socket = socket


def tcp_on_new_client(client_socket, client_sockets):
    msg = client_socket.recv(1024)
    msg_converted = str(msg, 'utf-8')
    print("got message: " + msg_converted)

    msg_splitted = msg_converted.split(':', maxsplit=1)
    # print(str((msg_splitted[0], client_socket)))
    client_sockets.append(Client(msg_splitted[0], client_socket))

    for s in client_sockets:
        if s.nick != msg_splitted[0]:
            # print(s)
            s.socket.send(bytes(msg_converted, 'utf-8'))


def tcp_connection(server_port, client_sockets):
    server_socket = sc.socket(sc.AF_INET, sc.SOCK_STREAM)
    server_socket.bind(('', server_port))
    server_socket.listen(1)

    while True:
        socket, address = server_socket.accept()
        _thread.start_new_thread(tcp_on_new_client, (socket, client_sockets))


def udp_request(client_sockets, buff, address):
    print("got udp request from " + str(address))
    # print(str(buff, 'utf-8') + '\n')
    requesting_client_nick = (str(buff, 'utf-8')).split(':', maxsplit=1)[0]
    for s in client_sockets:
        if s.nick != requesting_client_nick:
            s.socket.send(buff)


def udp_connection(server_port, client_sockets):
    server_socket = sc.socket(sc.AF_INET, sc.SOCK_DGRAM)
    server_socket.bind(('', server_port))
    while True:
        buff, address = server_socket.recvfrom(1024)
        _thread.start_new_thread(udp_request, (client_sockets, buff, address))


server_port = 1260
client_sockets = []
_thread.start_new_thread(tcp_connection, (server_port, client_sockets))
_thread.start_new_thread(udp_connection, (server_port, client_sockets))

while True:
    pass
