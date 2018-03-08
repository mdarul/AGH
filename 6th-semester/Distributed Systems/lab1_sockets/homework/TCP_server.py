import socket
import _thread


def on_new_client(client_socket, all_client_sockets):
    msg = client_socket.recv(1024)
    print("got message: " + str(msg, 'utf-8'))
    for s in all_client_sockets:
        if s != client_socket:
            print(s)
            s.send(bytes(str(msg), 'utf-8'))


server_port = 1241
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(('', server_port))
server_socket.listen(1)
client_sockets = []

while True:
    socket, address = server_socket.accept()
    client_sockets.append(socket)
    _thread.start_new_thread(on_new_client, (socket, client_sockets))
