import socket

def send_request(url, search_term):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect(('server_hostname_or_ip_address', 36713))
        request = f'{url} {search_term}'
        s.sendall(request.encode('utf-8'))
        response = s.recv(4096)
        print(response.decode('utf-8'))

if __name__ == '__main__':
    send_request('https://www.google.com', 'google')