import socket

serverIP = "127.0.0.1"
serverPort = 2345

msg_bytes = (300).to_bytes(4, byteorder='little')

client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client.sendto(msg_bytes, (serverIP, serverPort))

msg = client.recv(1024)

num = int.from_bytes(msg, "big")

print(num)

