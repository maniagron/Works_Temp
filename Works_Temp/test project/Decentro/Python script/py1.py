import socket
import subprocess

def handle_client(client_socket):
    request = client_socket.recv(1024).decode('utf-8').strip()
    args = request.split(' ')
    try:
        output = subprocess.check_output(['bash', 'main.sh', args[0], args[1]], stderr=subprocess.STDOUT)
        client_socket.sendall(output)
    except subprocess.CalledProcessError as e:
        client_socket.sendall(e.output)

def start_server():
    host = '0.0.0.0'
    port = 36713
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind((host, port))
    server_socket.listen(5)
    print(f"[*] Listening on {host}:{port}")

    while True:
        client_socket, addr = server_socket.accept()
        print(f"[*] Accepted connection from {addr[0]}:{addr[1]}")
        handle_client(client_socket)
        client_socket.close()

if __name__ == '__main__':
    start_server()