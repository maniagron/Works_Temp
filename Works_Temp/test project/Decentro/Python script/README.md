This socket server program py1.py reads a request from a client socket connection, which should be a string with two space-separated values: the URL to crawl and the search term. 
It then uses the subprocess module to execute the main.sh shell script with the provided arguments and sends the output back to the client socket connection.

To run this server program as a system service controlled by systemd, you can create a unit file with the following contents:

[Unit]
Description=Socket server for web crawler script

[Service]
ExecStart=/usr/bin/python3 /path/to/socket_server.py
WorkingDirectory=/path/to
User=yourusername
Group=yourgroupname
Restart=always

[Install]
WantedBy=multi-user.target

Replace /path/to with the actual path to the directory containing the socket_server.py file, 
and replace yourusername and yourgroupname with the actual username and group name under which you want to run the service.

To start, stop, and restart the service using systemctl, use the following commands:



sudo systemctl start socket_server
sudo systemctl stop socket_server
sudo systemctl restart socket_server


Finally, to write a test client program to connect to the socket server and execute the script, you can use the Python code py2.py

Replace server_hostname_or_ip_address with the actual hostname or IP address of the machine running the socket server. This client program simply connects to the server, sends a request with the URL and search term, and prints the response from the server.