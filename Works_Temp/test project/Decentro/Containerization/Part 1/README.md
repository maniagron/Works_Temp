This Dockerfile uses the official bash image as the base image and copies the crawl.sh script to the container. It then sets the executable permission on the script and specifies that the script should be the command that the container runs when it starts.

We can then build the image with the following command:

docker build -t crawl-shell .