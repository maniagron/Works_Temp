This Dockerfile copies the requirements.txt file and installs the required Python packages, then copies the crawler.py script to the container. It then specifies that the crawler.py script should be the command that the container runs when it starts.

We can build this image with the following command:

docker build -t crawl-python .


To ensure that the Python program only starts if the shell program is up, we can use Docker Compose and define a dependency between the two services. Use a docker-compose.yml file




This docker-compose.yml file defines three services: crawl-shell, crawl-python, and reverse-proxy. The crawl-shell service runs the shell program, the crawl-python service runs the Python program, and the reverse-proxy service runs Nginx as a reverse proxy.

The crawl-python service has a depends_on directive that specifies that it depends on the crawl-shell service, which means that the crawl-python service will only start if the crawl-shell service is up.

The reverse-proxy service maps ports 80 and 443 to the host machine and uses a volume to mount an Nginx configuration file. The depends_on directive ensures that the reverse-proxy service only starts if the crawl-python service is up.


nginx.conf file that configures Nginx to load-balance requests to the crawl-python service




This configuration will listen on both HTTP and HTTPS ports, and forward requests to the Python program container running on port 5000. We can use a tool like Let's Encrypt to obtain SSL certificates for our domain and configure Nginx to use them.

Scale up/down the number of containers for the Python program:
We can use the following Docker Compose command to scale up or down the number of Python program containers:

docker-compose up --scale python=<number-of-containers>
