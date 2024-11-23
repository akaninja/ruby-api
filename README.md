Plain Ruby API server
=====================

Made with Ruby 3.3.1

Run `ruby exec.rb` to open the server.

Run `curl` commands in a different terminal window to see it working.

Examples:

- `curl 'http://localhost:5678'`

- `curl -d "{\"plate\": aaa-444}" 'http://localhost:5678/parkings'`

- `curl -X PUT 'http://localhost:5678/parkings/aaa-445'`

To avoid error `Received HTTP/0.9 when not allowed` use option `--http0.9`

This is a study project and a work in progress. At the time only a couple of endpoints are available.


###Some references:

- https://ruby-doc.org/core-3.0.2/Proc.html

- https://ruby-doc.org/stdlib-3.0.2/libdoc/socket/rdoc/Socket.html






