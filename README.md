# Full Cycle - Docker - Challenge - Go

*Target: Create a Docker image less than 2MB with `Code.education Rocks!` response.*

## Quick-Start
```bash
docker run rogeriocassares/fullcycle-docker-challenge-go:prod
```

*Done!*

## Explanation
At first, develop the go application by initializing a go module:

```bash
go mod init fullcycle-docker-challenge-go
```

Then, create a `main.go` file:

```go
package main

import "fmt"

func main() {
	fmt.Println("Code.education Rocks!")
}

```

From now, create a `Dockerfile` to build an `Alpine` `golang` image that shall be used to build the `go` code into binaries as the first step of a multi-stage `Dockerfile`.

**Dockerfile:**

```dockerfile
FROM golang:1.19-rc-alpine3.16
LABEL mantainer="roger10cassares@gmail.com"
WORKDIR /app
COPY main.go .
COPY go.mod .
RUN go build -o /fullcycle-rocks
CMD ["/fullcycle-rocks"]
```

To build and test the first stage, from the top root directory of this project, please run:

```bash
docker build -t rogeriocassares/fullcycle-docker-challenge-go:latest . -f Dockerfile
```
Run the container with a tagged name and enter in the bash:
```bash
docker run --rm --name fullcycle-docker-challenge-go rogeriocassares/fullcycle-docker-challenge-go:latest

Code.education Rocks!
```

After that, a `Scratch` Linux image shall be used where the `golang` binary file shall be copied to. The `Dockerfile.prod` file shall be created:

**Dockerfile.prod:**

```dockerfile
FROM golang:1.19-rc-alpine3.16 AS builder
LABEL mantainer="roger10cassares@gmail.com"
WORKDIR /app
COPY main.go .
COPY go.mod .
RUN go build -o /fullcycle-rocks

FROM scratch
COPY --from=builder /fullcycle-rocks /fullcycle-rocks
CMD ["/fullcycle-rocks"]
```

To build and test the first stage, from the top root directory of this project, please run:

```bash
docker build -t rogeriocassares/fullcycle-docker-challenge-go:prod . -f Dockerfile.prod
```

Run the container with a tagged name and enter in the bash:

```bash
docker run --rm --name fullcycle-docker-challenge-go rogeriocassares/fullcycle-docker-challenge-go:prod
----
Code.education Rocks!
```

**Verify the Images size:**

```bash
docker images
----
REPOSITORY                                      TAG                  IMAGE ID       CREATED             SIZE
rogeriocassares/fullcycle-docker-challenge-go   prod                 86cf517feada   40 minutes ago      1.81MB
<none>                                          <none>               a0e0087ff464   41 minutes ago      1.81MB
rogeriocassares/fullcycle-docker-challenge-go   latest               e4f3a2b2b7be   45 minutes ago      354MB

```

Yes! Now we have our image with just 1.81MB! The `Scratch` is quite smaller than the `Alpine` one!

**Push to Docker Registry:**

```bash
docker push rogeriocassares/fullcycle-docker-challenge-go:prod
----
The push refers to repository [docker.io/rogeriocassares/fullcycle-docker-challenge-go]
16a453e7622f: Pushed 
prod: digest: sha256:2671de8bd2ca9573f02458a65523bb30e4b02857f6603d0d25e32e9f77bb0a44 size: 528
```

**Run from Anywhere:**

```bash
docker run rogeriocassares/fullcycle-docker-challenge-go:prod
```





***Congratulations!***
